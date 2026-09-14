# SageMath 検算: 熱力学極限について有限不等式列だけで閉じる範囲

## 対象

**対象ラベル**: `remark_finite_submultiplicative_count_limit_boundary`

- 併せて検証するラベル: `def_finite_submultiplicative_count_certificate`、
  `claim_finite_submultiplicative_count_certificate_decidable`、
  `def_finite_count_density_comparison`、
  `claim_finite_submultiplicative_count_multiple_index_density_bound`、
  `def_finite_submultiplicative_count_cutoff_extensions`、
  `claim_finite_submultiplicative_count_cutoff_not_global`。
- 正整数値有限表の劣乗法証明書、その有限決定、倍数添字上界と交差冪比較、有限表だけでは
  次段階の不等式を決められない反例を、本文の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_certificate_decidability.sage` | 証明書の候補対が有限であり、有限走査の返す真偽が全候補対の論理積と一致する | PASS | 打ち切り一から六、表値一から三の全 1,092 表、13,941 比較で成立 |
| `check_multiple_index_bound.sage` | 証明書を満たす表について、倍数添字上界と、それを正整数乗した交差冪比較を別々に判定する | PASS | 打ち切り一から六、表値一から四の全 2,253 証明書、各 28,055 比較で成立 |
| `check_cutoff_extensions.sage` | 二列の有限表一致、両方の有限証明書、次段階での不等式の分岐を判定する | PASS | 打ち切り一から六十四、共有 2,080 表値、87,360 証明書比較、64 分岐で成立 |

## 範囲と限界

- 明示した有限範囲のプログラミングによる検証であり、任意の打ち切りに対する一般証明ではない。
  一般証明は構造化記述にある。
- 全て有限集合と `ZZ` の加法・乗法・冪・順序比較だけで厳密に検査する。
- 数え上げ列の全段階の劣乗法性、極限値、下限、完備化、実対数、実数体、複素数体は
  定義も検査もしていない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-submultiplicative-count-bounds/check_*.sage; do sage "$file"; done
```
