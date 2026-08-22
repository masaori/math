# 有限グラフ上の Ising 分配多項式と Fisher 零点

作業前にリポジトリ直下の `docs/context/` を全て読む。

## ゴール

任意の有限グラフについて、スピン配位の破れ辺数から整数係数 Ising 分配多項式を構成し、
係数・有理評価・整除性・代数的 Fisher 零点を、有限集合、`N`、`Z[x]`、`Q`、`Qbar` の中で
決定可能な対象として記述する。双曲曲面その他の幾何は仮定しない。

## 正本と接続

数学本文の正本は `structured-latex/content/main-text.ts` である。有限双曲曲面プロジェクトは、
その曲面固有本文が参照する最小の定義・主張だけをこの正本から取り込む。一般有限グラフの新しい
定義・主張・定理と Fisher 零点の一般論は、このプロジェクトだけで進める。

対応する厳密検算は `sagemath/check/`、依存関係は `docs/tasks/task-dependency-graph.md`、
自動 tick の持続状態は `docs/tasks/auto-loop-runbook.md` と `docs/tasks/auto-loop-state.md` に置く。

## 非可算への脱出

有限系の Fisher 零点は `Qbar` の元として扱う。複素平面への埋め込み、数値近似、距離、偏角、
零点列の集積、熱力学極限は別ブロックへ分離し、`R/C` への脱出を明記する。

## 検証

```sh
(cd finite-graph-ising-partition-polynomial-and-fisher-zeros/structured-latex && pnpm run gen && pnpm run check && pnpm run build:pdf)
node finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/tools/verify-check-linkage.ts
```

Lean 具体版と必要十分版は未着手であり、記述と SageMath 検算の完了と区別する。

