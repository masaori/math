# SageMath 検算: 合成写像の本質的依存台

## 対象

**対象ラベル**: `claim_composite_map_support_bounded_by_composed_support`

- 併せて検証するラベル: `def_finite_configuration_map_cell_map`、
  `def_global_map_essential_dependency_assignment`、
  `def_composed_neighborhood`、
  `claim_support_is_minimum_representing_set`、
  `claim_global_map_composition_representable_on_composed_neighborhood`、
  `claim_representable_implies_support_subset`、
  `claim_support_finite_decidability`、
  `def_composite_support_strict_inclusion_witness`、
  `claim_composite_map_support_bound_can_be_strict`
- 本文の各段（上界そのもの、証明の三段の表現構成、有限決定、真の包含の明示反例）を
  別々の検算に分け、最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_composite_support_upper_bound.sage` | `D_{F∘G}(v) ⊆ (D_F * D_G)(v)` を全ての配位写像の組（`|V| <= 2`）と `|V| = 3` の部分族で検査 | PASS |
| `check_representation_steps.sage` | 証明の三段（`supp` が表現集合であること、合成局所規則族 `h_v` の明示構成が `(F∘G)_v` と一致すること、表せることから `supp` の包含が従うこと）を分けて検査 | PASS |
| `check_finite_decidability.sage` | 走査する組数が `|V| * 2^{|V|}` であること、走査で得た依存台が存在量化の定義と一致すること、包含判定が有限個の所属判定で済むこと | PASS |
| `check_strict_inclusion_witness.sage` | 二元舞台の明示反例で `D_{F∘G}(a)` が空、`(D_F * D_G)(a) = {a}`、包含が真であること。併せて `|V| = 2` の全組での真の包含の個数 | PASS |

## 検証範囲

- 上界は `|V| = 1`（16 組）と `|V| = 2`（65,536 組）の全ての写像の組で検査した。
  `|V| = 3` は写像が `8^8` 個あり全数走査できないため、8 個の値写像
  （定数 0、定数 1、三つの座標射影、パリティ、三変数の積、多数決）から各セルの値写像を選んで作る
  512 個の写像に限り、その全ての組 262,144 組を検査した。**これは `|V| = 3` の全数検査ではない。**
- 証明の三段と有限決定は `|V| <= 2` の全ての組で検査した。
- 反例は本文が指定した一つの有限対象なので、その全数検査が主張の範囲を尽くす。
  併せて `|V| = 2` の全 65,536 組のうち 26,640 組でどこかのセルの包含が真になることを記録した。

## 限界と帰属

- 上界・有限決定・表現の各段は上記の有限範囲の検査であり、任意の有限舞台と任意の二写像に対する
  一般証明ではない。一般の場合の根拠は構造化記述である。
- 有限集合、有限写像表、0/1 と自然数の等号だけを使う。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/composite-map-essential-dependency/check_*.sage; do sage "$file"; done
```
