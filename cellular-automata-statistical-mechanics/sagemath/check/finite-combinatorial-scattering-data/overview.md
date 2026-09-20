# SageMath 検算: 有限組合せ散乱表

## 対象

**対象ラベル**: `claim_finite_internal_scattering_compatibilities_decidable`

- 固定した二元の内部表について、部分作用表との可換性、整数値表の差分条件、正規化を別々に検査する。
- 別の二元三型の成分交換表について、整数次数を記号のまま保ち、三つのアフィン持ち上げの Yang--Baxter 等式を検査する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_operator_compatibility.sage` | 部分作用表と内部散乱表の可換性 | PASS | 二添字・四内部入力の全 8 入力 |
| `check_integer_difference.sage` | 整数値表の差分適合条件 | PASS | 定義域の全 4 入力で差分 $-1,0,1$ の三分岐 |
| `check_integer_normalization.sage` | 基準入力での整数値表の正規化 | PASS | 指定した一入力 |
| `check_affine_yang_baxter.sage` | 型付き整数位相持ち上げの Yang--Baxter 等式 | PASS | 二元三型の全 8 内部入力、整数次数は記号的に検査 |

## 範囲と限界

- 検算は固定した有限表について主張の各条件を別々に確認する。一般の有限表に対する有限決定性の人手証明を代用しない。
- アフィン検算は内部成分交換と組ごとに一定な整数値表を使う成立例である。任意の内部表から Yang--Baxter 適合条件が従うとは主張しない。
- 整数の加減算と等号だけを使う。除算、対数、極限、実数体、複素数体、浮動小数点は使わない。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-combinatorial-scattering-data/check_*.sage; do sage "$file"; done
```
