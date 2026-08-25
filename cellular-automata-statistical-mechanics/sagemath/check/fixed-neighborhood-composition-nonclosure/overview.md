# SageMath 検算: 固定近傍による可逆大域写像族の合成非閉性

## 対象

**対象ラベル**: `claim_fixed_neighborhood_reversible_maps_not_composition_closed`

- 併せて検証するラベル: `def_three_cell_cyclic_dependency_stage`、`claim_three_cell_cyclic_shift_reversible`
- 3 セルを巡回して一つ先の座標を読む有限舞台について、全 8 配位、
  固定近傍で表せる全 64 大域写像を走査し、本文の各段を分けて検査する。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_shift_reversible.sage` | `s` の三回合成が恒等であること、`G(x)(v) = x(s(s(v)))` が `F` の両側逆写像であること、`F` が単射かつ全射で固定近傍で表せること | PASS |
| `check_composition_external_dependency.sage` | 合成の `a` 座標写像が `x(c)` に一致すること、定値零配位とその `c` での一点反転が本文の証人であること、`supp(g_a) = {c}` が `N(a) = {b}` に含まれないこと | PASS |
| `check_composition_not_representable.sage` | 固定近傍で表せる大域写像 64 通りの全数列挙、その各座標の依存台が近傍に含まれること、`F` が属し `F o F` が属さないこと、可逆な元だけに絞っても閉じないこと | PASS |

## 限界と帰属

- 検査は本文が主張する一つの有限反例舞台に限る。反例の主張は一つの有限対象についての主張なので、
  この全数検査が主張の範囲を尽くす。一般の有限舞台で合成が閉じないことを主張しているのではなく、
  閉じるとは限らないことの証拠である。
- 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/fixed-neighborhood-composition-nonclosure/check_*.sage; do sage "$file"; done
```
