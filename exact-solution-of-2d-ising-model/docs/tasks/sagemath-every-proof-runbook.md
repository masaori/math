# 全ての証明に SageMath の検算を付ける Runbook

## ゴールライン

2026-11-01 の代表の指示（「全証明に SageMath をつけてほしい」）による。論文の冒頭の章「この論文について」は
「全ての計算過程は、SageMath による数値計算による検証と、Lean による形式検証により、その精度を担保している」と書いており、
この文を事実にすることが目的である。次がすべて成り立てば完了である。

- `node sagemath/tools/verify-every-proof-has-check.ts` が exit 0 で終わる（本文で証明を持つブロックのすべてが、
  どれかの検算の `overview.md` の「**対象ラベル**」に宣言されている）。
- `node sagemath/tools/verify-check-linkage.ts` が通り、足した検算が `bash sagemath/tools/run-all-checks.sh <対象名>` で全部通る。
- 足した検算が、リポジトリの [証明の書き方](../../../docs/context/証明の書き方.md) の「SageMath 検証」を満たす。

## 一つの検算の作り方

- 対象のブロックの証明を読み、**式変形の各行**を検算に落とす。行と検算の対応を `overview.md` の表に書く。
  等号の鎖が無い証明（場合分け、集合の包含、存在の構成など）は、その中に現れる計算を一行ずつ確かめ、
  加えて主張そのものを具体的な値で確かめる。どの行を確かめ、どの行を確かめられないかと理由を `overview.md` に書く。
- **厳密計算を優先する**（`ZZ`・`QQ`・`QQbar`・記号計算）。浮動小数点を使うのは $\mathbb{R}$ への脱出を含む量
  （指数関数・極限・積分・実数の不等式の評価）だけで、使ったら理由と許容誤差の根拠を書く。
- 検算が落ちたら**人手証明を直す**。検算を主張に合わせて緩めない。直したら論文側の `npm run check` を通し、
  同じ主張の Lean があれば `lake build` と `bash scripts/check-no-sorry.sh` を通す。
- ディレクトリは `sagemath/check/<内容の分かる名前>/` とし、**番号を付けない**（リポジトリの CLAUDE.md
  「文書・定理を番号や記号で管理しない」）。既存の番号付きディレクトリは改名しない。
- 形式は [sagemath/README.md](../../sagemath/README.md) と skill `sagemath-checker` に従う。実行ログを `logs/` に残す。
- この VM の SageMath は `~/micromamba/envs/sage/bin/sage`（非対話シェルの PATH に無い）。

## 作業の順序

`node sagemath/tools/verify-every-proof-has-check.ts --list` の出力（文書順）の上から進める。
一回の作業は、同じファイルに並ぶ未検算のブロックを、互いに依存する小さな組なら数件まとめて、大きなものなら一件だけ扱う。
進んだ位置と、検算で見つかった本文の誤りは状態台帳 [sagemath-every-proof-state.md](sagemath-every-proof-state.md) に書く。

## 毎回の手順

1. 状態台帳の「次の一歩」と `--list` の先頭を読み、扱うブロックを決める。前回の成果が未完で残っていれば、それを仕上げる。
2. 検算を書き、走らせ、`overview.md` とログを残す。
3. 担当とは別のエージェント（サブエージェント）に、検算が証明の行と対応しているか、厳密計算で済むところを浮動小数点にしていないか、
   検算が両辺を同じ式から作っていないかをレビューさせ、指摘が無くなるまで直す。サブエージェントには commit・push させない。
4. `verify-check-linkage.ts`、`verify-every-proof-has-check.ts`（件数が減ったこと）、足した検算の `run-all-checks.sh` を通す。
   人手証明を変えたら論文側の `npm run check`・`build:pdf` も通す。
5. 状態台帳と `MEMORY.md` を更新してコミットし、`git fetch origin && git rebase origin/main` の後に main へ push し、
   `git merge-base --is-ancestor` で包含を確かめる。
