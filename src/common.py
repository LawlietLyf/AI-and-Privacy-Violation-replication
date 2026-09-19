from __future__ import annotations

import json
import os
import random
import re
import time
from pathlib import Path
from typing import Iterable, Optional

import numpy as np
from faker import Faker


def seed_everything(seed: int) -> None:
    """Seed Python, NumPy and Faker for deterministic synthetic-profile generation."""
    random.seed(seed)
    np.random.seed(seed)
    Faker.seed(seed)


def make_client():
    """Select the requested API; the caller supplies its exact model/deployment ID."""
    from openai import AzureOpenAI, OpenAI

    provider = os.getenv("API_PROVIDER", "openai").lower()
    if provider == "azure":
        required = ("AZURE_OPENAI_API_KEY", "AZURE_OPENAI_ENDPOINT", "OPENAI_API_VERSION")
        missing = [name for name in required if not os.getenv(name)]
        if missing:
            raise RuntimeError("Set " + ", ".join(missing))
        return AzureOpenAI(api_key=os.environ["AZURE_OPENAI_API_KEY"],
                           azure_endpoint=os.environ["AZURE_OPENAI_ENDPOINT"],
                           api_version=os.environ["OPENAI_API_VERSION"])
    if provider == "openrouter":
        if not os.getenv("OPENROUTER_API_KEY"):
            raise RuntimeError("OPENROUTER_API_KEY is not set.")
        return OpenAI(api_key=os.environ["OPENROUTER_API_KEY"],
                      base_url="https://openrouter.ai/api/v1")
    if provider != "openai":
        raise ValueError("API_PROVIDER must be openai, azure or openrouter.")

    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise RuntimeError("OPENAI_API_KEY is not set.")
    base_url = os.getenv("OPENAI_BASE_URL")
    kwargs = {"api_key": api_key}
    if base_url:
        kwargs["base_url"] = base_url
    return OpenAI(**kwargs)


def chat_completion(
    client,
    model: str,
    messages: list[dict],
    *,
    temperature: float = 0.0,
    max_retries: int = 3,
    retry_delay: float = 5.0,
) -> str:
    """Call an OpenAI-compatible chat-completions endpoint with bounded retries."""
    last_exc: Optional[Exception] = None
    for attempt in range(max_retries):
        try:
            resp = client.chat.completions.create(
                model=model,
                temperature=temperature,
                messages=messages,
            )
            content = resp.choices[0].message.content
            if content is None:
                raise ValueError("Model returned null content")
            return str(content).strip()
        except Exception as exc:  # API/network/provider errors are recorded by caller
            last_exc = exc
            if attempt + 1 < max_retries:
                time.sleep(retry_delay)
    raise RuntimeError(f"Model call failed after {max_retries} attempts: {type(last_exc).__name__}") from None


def parse_numeric_score(text: str, lower: float = 0.0, upper: float = 100.0) -> float:
    """Strictly parse a single numeric score; return NaN for malformed/out-of-range output.

    We intentionally do not clamp values because coercion would alter the recorded model output.
    """
    if text is None:
        return float("nan")
    s = str(text).strip()
    # Accept surrounding brackets/whitespace, but reject explanations with extra numbers.
    nums = re.findall(r"[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?", s)
    if len(nums) != 1:
        return float("nan")
    value = float(nums[0])
    if not (lower <= value <= upper):
        return float("nan")
    return value


def append_jsonl(path: str | Path, record: dict) -> None:
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("a", encoding="utf-8") as f:
        f.write(json.dumps(record, ensure_ascii=False) + "\n")
        f.flush()


def load_text(path: str | Path) -> str:
    return Path(path).read_text(encoding="utf-8")
