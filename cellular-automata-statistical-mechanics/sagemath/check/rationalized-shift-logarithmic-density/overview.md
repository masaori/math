# SageMath 検算: 有理係数正規化列と完全安定化の境界

## 対象

**対象ラベル**: `claim_shift_rationalized_logarithmic_density_not_eventually_constant`

- 併せて検証するラベル: `def_finite_support_rational_prime_vectors`、
  `def_shift_rationalized_logarithmic_density_sequence`。
- 有限台・有理係数閉性、素数二係数、二段階の非一致を、本文の定義と証明の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_finite_support_rational_closure.sage` | 有限台整数ベクトルの有理係数への埋め込みと、正整数による係数ごとの除算が有限台を保つこと | PASS | 三素数上の係数 `-2..2` の全 125 ベクトルと、各舞台サイズ 1..64 の計 8,000 除算で成立 |
| `check_shift_rationalized_prime_coefficient.sage` | 一方向シフトの不動点数二から作る正規化列の素数二係数が `1/L` であること | PASS | 舞台サイズ 1..16 の全 131,070 配位で不動点数を再計算して成立 |
| `check_two_stage_nonequality.sage` | 各開始段階 `L` と後続段階 `2L` で素数二係数が異なり、ベクトルが一致しないこと | PASS | 開始段階 1..128 の全 128 対で成立 |

## 範囲と限界

- 有限台閉性は素数二・三・五と係数 `-2..2`、舞台サイズ 1..64 の明示した有限範囲を全数検査する。
- 素数二係数は舞台サイズ 1..16 の全配位から不動点を再計算する。二段階の非一致は開始段階
  1..128 を検査する。
- これは明記した有限範囲のプログラミングによる検証であり、一般証明ではない。任意の有限台、
  任意の舞台サイズ、最終的な完全安定化の否定の一般的な根拠は構造化記述にある。
- 有限集合、自然数、整数、有理数、有限台ベクトルだけを使う。除数は正整数に限定し、零除算へ
  既定値を置かない。浮動小数点、実対数、位相、距離、完備化、極限、実数体、複素数体は使わない。

## 実行方法

```bash
for file in sagemath/check/rationalized-shift-logarithmic-density/check_*.sage; do sage "$file"; done
```
