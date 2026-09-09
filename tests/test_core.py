from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from src.common import parse_numeric_score, seed_everything
from src.synthetic_data import generate_processing_users


def test_parse_numeric_score():
    assert parse_numeric_score("42") == 42
    assert parse_numeric_score("[42.5]") == 42.5
    assert str(parse_numeric_score("score=42 because...")) == "nan"
    assert str(parse_numeric_score("101")) == "nan"


def test_synthetic_generation_is_seeded():
    seed_everything(123)
    a = generate_processing_users(5)
    seed_everything(123)
    b = generate_processing_users(5)
    assert a.equals(b)
