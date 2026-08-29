# SageMath 検算: 根付き木の深さと最小前周期層の対応

## 対象

**対象ラベル**: `claim_iterate_monoid_fiber_tree_depth_equals_rounded_preperiod`

- 併せて検証するラベル: `claim_iterate_monoid_global_period_at_point_min_preperiod`、`def_iterate_monoid_rounded_preperiod_depth`、`claim_iterate_monoid_rounded_preperiod_reaches_root`、`claim_iterate_monoid_before_rounded_preperiod_not_root`、`claim_iterate_monoid_root_depth_preperiod_correspondence_finite_decidability`
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像・全 3,585 配位）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_global_period_at_point.sage` | 全配位で $\mu(y)\le\mu_F$ と $F^{\mu(y)+\lambda_F}(y)=F^{\mu(y)}(y)$ | PASS | 769 写像・3,585 配位で成立 |
| `check_rounded_preperiod_well_defined.sage` | 定義集合が $m_F$ を含むこと（$\mu(y)\le\mu_F\le e_F=m_F\lambda_F$）と、$r_F(y)$ の所属・最小性・$r_F(y)\le m_F$ | PASS | 769 写像・3,585 配位で成立 |
| `check_reaches_root_at_rounded.sage` | $F^{r_F(y)\lambda_F}(y)=q$（切り上げ位置での根到達） | PASS | 769 写像・ファイバー元 3,585 個で成立 |
| `check_not_root_before_rounded.sage` | 全ての $d<r_F(y)$ で $F^{d\lambda_F}(y)\ne q$（切り上げ位置より前の非到達） | PASS | 769 写像・前方位置 1,664 組で成立 |
| `check_depth_formula.sage` | 根付き木の深さの有限走査 $d_F(y)$ と $r_F(y)$ の一致 | PASS | 769 写像・ファイバー元 3,585 個で一致 |
| `check_finite_decidability.sage` | $d=0,1,\ldots$ の順の自然数比較走査が有限回で停止し、返した値と各深さの配位集合が定義値と一致 | PASS | 3,585 配位・比較 5,249 回で定義値と一致 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- `|V|=1,2,3` では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 各配位の最小前周期 $\mu(y)$ は `def_min_preperiod` の全称文どおり（有限窓で同値になる範囲）に判定し、走査の候補範囲は `claim_min_preperiod_period_finite_decidability` に従う。
- 全て有限集合上の写像表、有限集合の等号・所属、非負整数の乗算・大小比較として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-root-depth-preperiod-correspondence/check_*.sage; do sage "$file"; done
```
