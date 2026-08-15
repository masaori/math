# SageMath 検算: 周期点の個数

## 対象

**対象ラベル**: `claim_fixed_point_count_finite_decidability`

- 併せて検証するラベル: `claim_periodic_iff_min_preperiod_zero`、`claim_fixed_iff_min_period_divides`、`claim_fixed_point_count_decomposition`
- 検証範囲: 周期点と最小前周期の同値、反復の不動点と最小周期の整除の同値、最小周期ごとの個数分解、全配位走査による有限決定
- 全数範囲: 配位数 $1,2,4$ の有限集合上の全自己写像、およびセル数 $1$ から $3$ の巡回舞台上の全 256 初等 CA 規則

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_periodic_iff_min_preperiod_zero.sage` | 周期点であることと最小前周期が 0 であることの同値 | PASS | 4,618 軌道で一致 |
| `check_fixed_iff_period_divides.sage` | 反復の不動点と最小周期による整除条件の同値 | PASS | 4,618 軌道・51,236 指数で一致 |
| `check_count_decomposition.sage` | 反復の不動点の個数の最小周期ごとの分解 | PASS | 1,029 写像・9,234 指数で一致 |
| `check_finite_decidability.sage` | 全配位を一度ずつ検査する有限決定 | PASS | 1,029 写像・51,234 回の等号検査で一致 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- 配位数 $1,2,4$ では全自己写像を検査する。配位数 $8$ では全自己写像を列挙せず、セル数 $3$ の巡回舞台上の初等 CA が与える写像だけを検査する。
- 整除条件と個数分解は $1\le n\le 2|A^V|$ で検査する。全ての $n$ に対する根拠は構造化記述の最小周期の証明である。
- 全て有限集合と非負整数の等号・大小比較・四則演算として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/periodic-point-count/check_*.sage; do sage "$file"; done
```
