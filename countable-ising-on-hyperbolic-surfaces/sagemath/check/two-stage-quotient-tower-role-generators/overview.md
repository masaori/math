# 商の塔における役割生成元の整合性の検算

**対象ラベル**: `def_quotient_tower_role_generator_compatibility`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_role_generator_compatibility`）
- 範囲: 共通有限群の面・頂点・辺の役割元、その両商への像、両段での生成性、段間全射群準同型による三つの役割元の保存

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | `S_4` の三つの役割元を Klein 四元部分群による六元商と交代群による二元商へ射影し、両段での生成性と段間写像による三元全ての保存を全商元の有限演算で照合する | PASS | 細段と粗段の役割元は各商を生成し、面・頂点・辺の各像が段間写像で対応する役割元へ移った |

## 備考

- 商で役割元の位数が小さくなることは許しており、各段が同じ双曲型正則セル分割を生成するとは主張しない。
- 有限置換群と有限商群だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-role-generators/check_definition.sage
```
