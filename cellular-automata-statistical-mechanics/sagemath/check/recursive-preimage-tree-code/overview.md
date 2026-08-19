# SageMath 検算: 周期成分に付随する再帰的前像木符号の完全性

## 対象

**対象ラベル**: `claim_recursive_preimage_tree_code_complete_invariant`

- 併せて検証するラベル: `def_recursive_preimage_tree_code_multiset_hierarchy`、`def_recursive_preimage_tree_code_children`、`claim_recursive_preimage_tree_code_child_preperiod_increment`、`claim_recursive_preimage_tree_code_preperiod_upper_bound`、`def_recursive_preimage_tree_code`、`def_recursive_preimage_tree_code_periodic_orbits`、`def_recursive_preimage_tree_code_base_word`、`def_recursive_preimage_tree_code_component_code`、`def_recursive_preimage_tree_code_map_code`、`claim_recursive_preimage_tree_code_conjugacy_invariance`、`claim_recursive_preimage_tree_code_completeness`、`claim_recursive_preimage_tree_code_finite_decidability`
- 定義段の検査族は、セル数 0 の唯一の大域写像と `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則、計 769 写像（配位 3,585 個）。
- 共役不変性は、共役不変性の章と同じ全数族（決定的な全単射 5 種による共役対 3,073 対）で検査する。
- 完全性の再帰構成と完全不変量の同値は、元数 1・2・4 の配位集合上の全自己写像（`N(v)=V` の局所規則で実現できる 2 値 CA の大域写像表 261 個）の同サイズ全順序対 65,553 対と元数違い 2,568 対で検査する。
- 有限決定は、セル数 0・1・2 の全初等 CA 規則対（513 表の全順序対 263,169 対）で、局所真理値表からの符号計算・等号判定・構成を全単射の全数走査による独立判定と突き合わせる。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_code_definitions.sage` | 非周期一段前像の定義と最小前周期の増分 $\mu(z)=\mu(y)+1$、上界 $\mu(y)\le2^{\lvert V\rvert}-1$、再帰符号の well-defined 性と階層所属 $c_F(y)\in\mathbb M_{2^{\lvert V\rvert}-1-\mu(y)}$ | PASS | 769 表・上界 3,585 件・増分 1,384 件・所属 3,585 件で成立 |
| `check_conjugacy_invariance.sage` | 周期点集合・非周期一段前像の移送、点ごとの符号保存 $c_F(y)=c_G(h(y))$、周期軌道・基点語・成分符号の保存、$\mathcal K(F)=\mathcal K(G)$ | PASS | 3,073 対・点ごと 16,385 件・軌道 6,701 件で成立 |
| `check_completeness_construction.sage` | 証明の再帰構成（軌道対応・等基点語の周期辺接着・等子符号の再帰対応）が全域に一度ずつ定義された全単射を与え $h\circ F=G\circ h$ を満たす | PASS | 共役対 3,073 対・符号一致対 4,633 対で成立 |
| `check_complete_invariant.sage` | $\mathcal K(F)=\mathcal K(G)$ と全単射全数走査による共役全単射の存在の同値。元数違いでは両者とも不成立 | PASS | 同サイズ 65,553 対（共役 4,633 対）・元数違い 2,568 対で成立 |
| `check_finite_decidability.sage` | 局所真理値表からの符号計算・符号等号・構成の有限完了と、独立な全単射走査との判定一致 | PASS | 513 表・263,169 対（符号一致 32,257 対）で成立 |

## 限界と帰属

- いずれの検査族も上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- 元数 1・2・4 の全自己写像族と全単射の全数走査は、その範囲については全数検査が主張の範囲を尽くす。元数 8 以上は共役対の族（構成した共役 $G=h\circ F\circ h^{-1}$）に限られる。
- 入れ子有限多重集合は要素を整列した入れ子タプル、有限集合は重複を除いて整列したタプルで正準表現し、等号は表現の等号として比較する。
- 全て有限集合上の写像表、有限集合の等号・所属・像、非負整数の加減・大小比較、有限列・入れ子有限多重集合の等号として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/recursive-preimage-tree-code/check_*.sage; do sage "$file"; done
```
