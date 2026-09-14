# SageMath 検算: 有限べき比較とスケーリング指数の境界

## 対象

**対象ラベル**: `remark_finite_power_bound_scaling_boundary`

- 併せて検証するラベル: `def_finite_power_bound_certificate`、
  `claim_finite_power_bound_certificate_decidable`、
  `def_finite_power_bound_cutoff_extensions`、
  `claim_finite_power_bound_cutoff_not_global`。
- 正整数値有限表の交差冪上界証明書、その有限決定、同じ有限表を持つ二列が次段階で分かれる
  打ち切り反例を、本文の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_certificate_decidability.sage` | 有限走査の返す真偽が、全添字における交差冪比較の論理積と一致する | PASS | 打ち切り一から六、表値一から四の全 5,460 表、正整数順序対 87,360 候補、495,168 比較で成立 |
| `check_cutoff_extensions.sage` | 二列の有限表一致、両方の有限証明書、次段階における各不等式の分岐を段別に判定する | PASS | 打ち切り一から三十二、正整数順序対 2,048 候補、共有 33,792 表値、有限証明書 67,584 比較、次段階 10,240 段で成立 |

## 範囲と限界

- 明示した有限範囲のプログラミングによる検証であり、任意の打ち切り・指数候補に対する一般証明ではない。
  一般証明は構造化記述にある。
- 全て有限集合と `ZZ` の乗法・冪・順序比較だけで厳密に検査する。
- 指数候補は正整数の順序対のまま扱う。商、根、対数、漸近的な指数、スケーリング極限、
  実数値の臨界指数、実数体、複素数体は定義も検査もしていない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-power-bound-certificate/check_*.sage; do sage "$file"; done
```
