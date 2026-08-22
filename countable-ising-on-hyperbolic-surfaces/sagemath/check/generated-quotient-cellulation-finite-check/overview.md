# 生成剰余類セルデータの有限検査

**対象ラベル**: `theorem_generated_quotient_cellulation_is_hyperbolic_regular`

## 対象

- ファイル: `structured-latex/content/finite-quotient-lattice.ts`（ブロック `finite_quotient_lattice_theorem_generated_cellulation_is_hyperbolic_regular`）
- 範囲: 出典を固定した位数 `168` の有限置換群から生成したセルデータについて、向き付け閉曲面条件を検査し、正則型集合と双曲正則型集合を構成する

## 実例の出典と再現

- Gábor Gévay and Gareth A. Jones, “Hole operations on Hurwitz maps”, *The Art of Discrete and Applied Mathematics* 5 (2022), DOI `10.26493/2590-9770.1531.46a`, <https://doi.org/10.26493/2590-9770.1531.46a>。
- 同論文の Klein の写像の節は、型 `{3,7}`、種数 `3`、向きを保つ自己同型群 `PSL(2,7)`、群位数 `168` を明記し、`PSL(2,7)` の Hurwitz 三生成元を行列
  `x=[[1,1],[0,1]]`、`y=[[0,1],[-1,0]]`、`z=[[0,-1],[1,-1]]`
  として与える。
- `check.sage` はこれらの行列が `P^1(F_7)` 上に与える変換 `x(t)=t+1`、`y(t)=-1/t`、`z(t)=-1/(t-1)` を直接実装する。全単射
  `infinity→3, 0→8, 1→4, 2→2, 3→5, 4→6, 5→7, 6→1`
  による移送が、本文の `r_V`、`r_E`、`r_F` とそれぞれ一致することを全八点で検査する。したがって、本文の置換は出典の三生成元と同じ有限作用を再現する。

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check.sage` | 出典の射影直線作用との一致、剰余類セル生成、辺の正逆二回出現、頂点リンク単巡回、一次骨格連結、面次数像、頂点次数像、双曲型自然数不等式を厳密検算する | PASS | `24` 頂点、`84` 辺、`56` 三角形面からなる向き付け閉曲面セル分割で `(3,7)` が双曲正則型集合に属した |

## 備考

- 有限置換、有限集合、自然数、有理数だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- この検算が保証するのは、保存した有限群データから生成したセルデータが本文の有限述語を満たすことまでである。群名だけから曲面性を仮定していない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/generated-quotient-cellulation-finite-check/check.sage
```
