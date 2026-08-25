# SageMath 検算: 合成近傍による大域写像の合成表現

## 対象

**対象ラベル**: `claim_global_map_composition_representable_on_composed_neighborhood`

- 併せて検証するラベル: `def_composed_neighborhood`、`def_composed_local_rule_family`
- 本文の証明の各段（合成近傍の定義、二段制限、合成局所規則族、大域写像の合成の一致と所属）を
  別々の検算に分け、最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_composed_neighborhood.sage` | 合成近傍が合併として定まり `V` の部分集合として有限であること、`u in N(v)` ならば `M(u)` が合成近傍に含まれること | PASS |
| `check_two_stage_restriction.sage` | 証明中の二段制限の段、すなわち合成近傍への制限をさらに `M(u)` へ制限したものが `V` から `M(u)` への制限に等しいこと | PASS |
| `check_composed_local_rule_family.sage` | 合成局所規則族 `h_v` が `A^{(N*M)(v)}` 上の有限真理値表であること（引数が `A^{N(v)}` の元、表の大きさが `2^{|(N*M)(v)|}`）と、セルごとの一致 | PASS |
| `check_composed_global_map.sage` | 大域写像の合成 `F o G` が合成局所規則族の大域写像 `H` に一致すること、および `F o G` が合成近傍上の大域写像全体に属すること | PASS |

## 検証範囲

- 合成近傍と二段制限は、`1 <= |V| <= 3` の全ての近傍割り当ての組（各 `|V|` で `(2^{|V|})^{|V|}` 通りの
  `N` と `M`）と、必要な全ての配位について検査した。
- 合成局所規則族と大域写像の一致・所属は、`1 <= |V| <= 2` の全ての組
  `(近傍割り当て, 局所規則族)` について検査した（`|V|=2` では各側 676 個、組で 456,976 通り）。
- `M(V, N*M)` は合成近傍上の全局所規則族を独立に列挙して作り、`F o G` の所属を照合した。

## 限界と帰属

- 上記の有限範囲の全数検査であり、任意の有限舞台に対する一般証明ではない。
  一般の場合の根拠は構造化記述である。
- 有限集合、有限写像表、`0/1` の等号だけを使う。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/composed-neighborhood-closure/check_*.sage; do sage "$file"; done
```
