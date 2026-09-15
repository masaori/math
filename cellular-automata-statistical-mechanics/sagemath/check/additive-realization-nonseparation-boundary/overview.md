# SageMath 検算: 加法的実数実現の識別力境界

## 対象

**対象ラベル**: `claim_additive_realization_need_not_distinguish_counts`

- 併せて検証するラベル: `def_prime_vector_zero_real_realization`、
  `claim_prime_vector_zero_realization_additive`、`claim_prime_logarithm_inverse`。
- 零実数実現の零保存と加法保存、正の有限個数一・二の対数順序群値の非一致、
  その二元の実数像の一致を、本文の定義と証明の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_zero_preservation.sage` | 零実数実現が対数順序群の零を実数の零へ送ること | PASS | 零等式 1 件で成立 |
| `check_addition_preservation.sage` | 零実数実現が加法を保存すること | PASS | 三素数上の 125 ベクトルの全 15,625 加法対で成立 |
| `check_logarithmic_counts_distinct.sage` | 復元写像を通じた `log_Λ 1` と `log_Λ 2` の非一致 | PASS | 正の有限個数一・二の 1 対で非一致 |
| `check_zero_realization_images_equal.sage` | 相異なる二元を零実数実現が同じ零へ送ること | PASS | 上の相異なる二元の 1 対で実数像が一致 |

## 範囲と限界

- 零保存は零ベクトル一件、加法保存は三素数上で係数を -2 から 2 まで動かした 125 ベクトルの
  全 15,625 対、非一致と像の一致は本文で証人に選んだ正の有限個数一・二を検査する。
- 実数の零は有理数の零の標準単射による像なので、有理数内で等号を厳密に判定する。
  実数体を浮動小数点で近似せず、実対数も使わない。
- これは明示した有限反例のプログラミングによる検証であり、任意の加法的実数実現の分類ではない。
  一つの反例により、加法性だけから単射性や順序保存性を導けないことを検算する。
- 一般語族の実数列、収束概念、極限、位相的エントロピー、複素数体は定義も検査もしていない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/additive-realization-nonseparation-boundary/check_*.sage; do sage "$file"; done
```
