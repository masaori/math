# 二段の有限商の塔の入力の検算

**対象ラベル**: `def_two_stage_finite_quotient_tower_input`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_two_stage_finite_quotient_tower_input`）
- 範囲: 共通有限置換群の二つの正規部分群の包含、二つの有限商群、標準商写像、段間の全射群準同型、可換条件

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | `S_4` の Klein 四元部分群が交代群 `A_4` に含まれる二段について、正規性、商の元数、段間写像の代表元非依存性・全射性・乗法性、および二つの標準商写像との可換条件を全要素・全商元対で照合する | PASS | 細段の商は六元、粗段の商は二元であり、段間写像は代表元に依存しない全射群準同型として可換条件を満たした |

## 備考

- この検算は、写像をもつ二段の有限商の塔という入力形式だけを対象とする。特定の双曲三角群の二段、セルの被覆写像、分配多項式の比較は後続ブロックで固定・検証する。
- 有限置換群と有限剰余類集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-finite-quotient-tower-input/check_definition.sage
```
