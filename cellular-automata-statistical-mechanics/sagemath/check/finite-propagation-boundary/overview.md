# SageMath 検算: 有限伝播境界

## 対象

**対象ラベル**: `claim_finite_propagation_boundary`

- 併せて検証: `claim_path_time_increment_exact`、`claim_propagation_ball_finite`、`claim_start_cell_in_propagation_ball`
- 検証範囲: 経路の正確な時刻差、伝播球の再帰と個数上界、経路始点の伝播球所属、依存元集合の有限伝播境界
- 全数範囲: $|V|\leq3$ の全ての本質的依存台の族と $0\leq\tau\leq4$

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_path_time_increment_exact.sage` | 終点時刻が始点時刻と経路長の和に等しい | PASS | 2,655 個の組に含まれる 80,896 経路で成立 |
| `check_propagation_ball_cardinality.sage` | 伝播球の再帰式と有限合併の個数上界 | PASS | 531 個の依存台族に対する 6,280 個の個数比較で成立 |
| `check_start_cell_in_ball.sage` | 経路の始点セルが対応する伝播球に属する | PASS | 2,655 個の組に含まれる 80,896 経路で成立 |
| `check_dependency_source_boundary.sage` | 依存元集合の包含・個数上界・時刻 0 での空性 | PASS | 2,655 個の組に含まれる 23,550 個の終点イベントで成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、一般の有限舞台・任意の $\tau\in\mathbb{N}$ に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- 近傍や真理値表そのものではなく、そこから得た本質的依存台の全ての族を列挙する。今回の主張が局所規則から使う情報は本質的依存台だけだからである。
- 全て有限集合と非負整数の等号・大小比較として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/finite-propagation-boundary/check_*.sage; do sage "$file"; done
```
