# SageMath 検算: 最小前周期と最小周期

## 対象

**対象ラベル**: `claim_min_preperiod_period_finite_decidability`

- 併せて検証するラベル: `claim_periodicity_pair_iff_collision`、`claim_period_descends_to_min_preperiod`、`claim_min_preperiod_period_bound`
- 検証範囲: 周期組の所属の同値、周期の最小前周期への移送、最小前周期・最小周期の有限走査、両者の和の上界
- 全数範囲: 配位数 $1,2,4$ の有限集合上の全自己写像・全初期値、およびセル数 $0$ から $3$ の巡回舞台上の全 256 初等 CA 規則・全配位

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_periodicity_pair_equivalence.sage` | 周期組の所属と 1 回の衝突の同値 | PASS | 4,618 軌道・191,540 組で一致 |
| `check_period_descends.sage` | 任意の周期が最小前周期の位置でも成立し、最小周期以上である | PASS | 4,618 軌道・121,426 周期組で成立 |
| `check_scan_matches_definition.sage` | 有限走査で得る最小値と最初の再訪から得る値の一致、走査候補数 | PASS | 4,618 軌道・53,754 成立候補で一致 |
| `check_minimal_sum_bound.sage` | $\mu(y)+\pi(y)\leq 2^{|V|}$ | PASS | 4,618 軌道で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- 配位数 $1,2,4$ では全自己写像を検査する。配位数 $8$ では全自己写像を列挙せず、セル数 $3$ の巡回舞台上の初等 CA が与える写像だけを検査する。
- 周期組の全称条件は有限検算では証明できないため、各候補について最小前周期以後 $2\cdot2^{|V|}+1$ 個の指数を検査する。普遍的な根拠は構造化記述の衝突移送の帰納法である。
- 全て有限集合と非負整数の等号・大小比較・四則演算として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/minimal-preperiod-period/check_*.sage; do sage "$file"; done
```
