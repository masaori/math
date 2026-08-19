# SageMath 検算: 安定ファイバー根付き木族の数値プロファイルは共役を決定しない

## 対象

**対象ラベル**: `claim_iterate_monoid_conjugacy_numerical_profile_not_complete`

- 併せて検証するラベル: `def_iterate_monoid_conjugacy_numerical_profile`、`claim_iterate_monoid_conjugacy_numerical_profile_invariant`、`def_iterate_monoid_conjugacy_numerical_profile_counterexample`、`claim_iterate_monoid_conjugacy_finite_decidability`
- 反例は 8 元の配位空間上の一つの有限対象なので、その部分は全数検査が主張の範囲を尽くす。
- 数値プロファイルの共役不変性は、共役不変性の章と同じ全数族（セル数 0 の唯一の大域写像と `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則、計 769 写像。決定的な全単射 5 種で共役対 3,073 対）で検査する。
- 全単射走査の有限決定は、セル数 0・1・2 の配位空間（元数 1・2・4）上の全自己写像対 65,553 対（元数違い 1 対を含む）で検査する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_counterexample_tables.sage` | 反例の二表の 2 値 CA 実現（N(v)=V の局所規則から大域表を再構成）、証明が引く反復の各行、$\mu=3$・$\lambda=1$・$e=3$・$m=3$、冪等反復写像と安定ファイバー | PASS | 実現 2 表・反復行 34・構造表 2 で成立 |
| `check_profile_invariance.sage` | 共役対の全数族で $\mathcal P(F)=\mathcal P(G)$ を定義から再計算して一致 | PASS | 3,073 対で成立 |
| `check_profile_match.sage` | 反例の深さ別個数列 $(1,2,3,1)$・$(1,0,0,0)$ と分岐個数多重集合 $\{\!\{0,0,0,1,1,2,2\}\!\}$・$\{\!\{0\}\!\}$、$\mathcal P(F)=\mathcal P(G)$ | PASS | ファイバー統計 8 件で成立 |
| `check_non_conjugacy.sage` | 根直前の頂点 $\{x_1,x_2\}$ の子孫集合と個数多重集合 $\{\!\{4,2\}\!\}\ne\{\!\{3,3\}\!\}$、全 $8!=40{,}320$ 個の全単射で $h\circ F=G\circ h$ が不成立 | PASS | 走査 40,320 全単射で成立 |
| `check_finite_decidability.sage` | 全単射走査の有限決定: 証人の全点検査、判定の対称性、$h\circ F\circ h^{-1}$ 対での存在判定、存在判定対でのプロファイル一致、元数違いでの不存在判定 | PASS | 65,553 対走査・共役 4,633 対で成立 |

## 限界と帰属

- 数値プロファイルの共役不変性と有限決定の全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。反例と 8 元集合上の全単射走査は、当該の有限対象については全数検査が主張の範囲を尽くす。
- 共役不変性の族の全単射 $h$ は決定的な 5 種に限られる。有限決定の検査（元数 1・2・4）は全単射の全数列挙である。
- 全て有限集合上の写像表、有限集合の等号・所属・像・個数、非負整数の除法・乗算・大小比較として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-conjugacy-numerical-profile/check_*.sage; do sage "$file"; done
```
