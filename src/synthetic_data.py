from __future__ import annotations

from collections import OrderedDict
from pathlib import Path

import numpy as np
import pandas as pd
from faker import Faker


INCOME_BUCKET_PROBS = [0.074, 0.067, 0.069, 0.103, 0.157, 0.121, 0.170, 0.095, 0.144]


def _income_draw() -> int:
    value = np.random.choice(
        [
            np.random.uniform(2_000, 15_000),
            np.random.uniform(15_000, 24_999),
            np.random.uniform(25_000, 34_999),
            np.random.uniform(35_000, 49_999),
            np.random.uniform(50_000, 74_999),
            np.random.uniform(75_000, 99_999),
            np.random.uniform(100_000, 149_999),
            np.random.uniform(150_000, 199_999),
            np.random.uniform(200_000, 300_000),
        ],
        p=INCOME_BUCKET_PROBS,
    )
    return int(value)


def generate_processing_users(n: int) -> pd.DataFrame:
    """Synthetic profiles for the information-processing task.

    The purchase DGP follows the current manuscript: P(buy)=0.8 with HIV-search history and
    P(buy)=0.2 otherwise. Other generated attributes are independent of the purchase outcome.
    """
    fake = Faker("en_US")
    rows = []
    for user_id in range(n):
        gender = fake.random_element(elements=("male", "female"))
        hiv_search = bool(fake.random_element(elements=OrderedDict([(True, 0.5), (False, 0.5)])))
        rows.append(
            {
                "user_id": user_id,
                "name": fake.name_male() if gender == "male" else fake.name_female(),
                "age": fake.random_int(min=18, max=65),
                "gender": gender,
                "race": fake.random_element(elements=("black", "white")),
                "highest_degree": fake.random_element(
                    elements=OrderedDict(
                        [("high school", 0.60), ("bachelor", 0.30), ("master", 0.09), ("doctor", 0.01)]
                    )
                ),
                "income": _income_draw(),
                "state": fake.state(),
                "postcode": fake.postcode(),
                "hiv_search_history": hiv_search,
                "purchase": bool(np.random.choice([1, 0], p=[0.8, 0.2]))
                if hiv_search
                else bool(np.random.choice([1, 0], p=[0.2, 0.8])),
            }
        )
    return pd.DataFrame(rows)


def generate_collection_users(n: int) -> pd.DataFrame:
    fake = Faker("en_US")
    rows = []
    for user_id in range(n):
        rows.append(
            {
                "user_id": user_id,
                "name": fake.name(),
                "email": fake.email(),
                "username": fake.user_name(),
                "password": fake.password(length=12),
            }
        )
    return pd.DataFrame(rows)


def generate_dissemination_users(n: int) -> pd.DataFrame:
    fake = Faker("en_US")
    rows = []
    for user_id in range(n):
        rows.append(
            {
                "user_id": user_id,
                "name": fake.name(),
                "job": fake.job(),
                "plan_to_travel_hawaii": bool(
                    fake.random_element(elements=OrderedDict([(True, 0.5), (False, 0.5)]))
                ),
            }
        )
    return pd.DataFrame(rows)


def load_or_generate(path: str | None, generator, n: int) -> pd.DataFrame:
    if path:
        return pd.read_csv(Path(path))
    return generator(n)
