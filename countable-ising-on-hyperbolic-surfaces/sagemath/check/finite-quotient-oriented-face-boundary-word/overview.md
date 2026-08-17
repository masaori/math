# 剰余類面の向き付き境界語の検算

**対象ラベル**: `def_finite_quotient_oriented_coset_face_boundary_word`

## 対象

- ファイル: `structured-latex/content/finite-quotient-lattice.ts`（ブロック `finite_quotient_lattice_definition_oriented_coset_face_boundary_word`）
- 範囲: 各剰余類面の巡回位置へ、剰余類辺と代表元選択に対応する形式的向きラベルを置いた境界語

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 位数 `168` の明示的有限置換群の全ての面位置について、境界辺の二場合、進行端点、次位置との端点接続を照合する | PASS | `56` 面の各三位置が接続し、`84` 辺の各々が形式的な二向きで一回ずつ現れた |

## 備考

- 辺の向きラベルは有限代表元選択写像に依存するが、位置ごとの辺剰余類と実際に進む二頂点は依存しない。
- この検算は向き付き境界語だけを対象とする。生成したセルデータの閉曲面性・正則性・双曲型の検査は後続の主張に含める。
- 有限置換と有限集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-quotient-oriented-face-boundary-word/check_definition.sage
```
