# 主辺係数から双対辺係数への移送写像の検算

**対象ラベル**: `def_primal_to_dual_edge_coefficient_transport`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_definition_primal_to_dual_edge_coefficient_transport`）
- 範囲: 主辺から双対辺への全単射の逆写像を用い、主辺係数写像を双対辺係数写像へ移す有限写像

## チェック一覧

実行日: 2026-08-17

| ファイル | 内容 | 状態 | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 三本の主辺に対する全八つの `F_2` 係数写像について、各双対辺の係数が対応する主辺の係数と一致し、像が双対辺係数空間全体になることを照合する | PASS | 全八係数写像が、主辺集合とは別の双対辺集合へ座標ごとに移送された |

## 備考

- この検算は係数写像の移送だけを扱う。一次サイクル空間への制限と第一ホモロジー類への作用は後続の別ブロックの対象である。
- 有限集合と `GF(2)` の等号だけを用いる厳密検算である。
- 非可算への脱出はない。浮動小数点、実数、複素数、極限、積分を用いていない。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/primal-to-dual-edge-coefficient-transport/check_definition.sage
```
