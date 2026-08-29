# 自動 tick Runbook

この文書は、独立した Codex セッションが毎回まっさらな会話文脈で読み、双曲曲面固有の研究を一つの主張だけ前進させるための手順書である。一般有限グラフ上の Ising 多項式と Fisher 零点は独立プロジェクトの台帳で扱う。

## 一 tick のゴール

既存成果をレビューした後、依存関係上実行可能な最初の作業から、構造化本文の一つの定義・主張・定理だけを完成方向へ進める。複数の数学的主張を一ブロックへ束ねない。

## 読むもの

次を省略せず読む。

- リポジトリ直下の `AGENTS.md`、`CLAUDE.md`、`docs/context/` の全ファイル
- `.codex/skills/math-prover/SKILL.md`
- プロジェクトの `README.md`、`MEMORY.md`
- この runbook、`auto-loop-state.md`
- `hyperbolic-ising/task-dependency-graph.md` と、今回進める個別タスク文書

## 実行手順

- remote default branch を問い合わせ、fetch 後に現在のブランチの遅れを確認する。安全に取り込める遅れは作業前に取り込む。
- 前回までの構造化本文、対応する SageMath、台帳の状態をレビューする。定義の不足、記号の使い回し、住処の誤り、未検証の完了表示があれば、新規追加より先に直す。
- `auto-loop-state.md` の「実行待ち」の最初の双曲曲面固有項目だけを進める。一般有限グラフ理論は進めない。
- 数学的主張は `math-prover` skill に従い、一ステップ一定理、行末の根拠、ラベル参照、全記号の所属を満たす。
- 探索上の仮説は本文へ定理として入れず、定義・確立済みの主張と分離して `notes/` またはタスク文書へ記録する。
- 対応する厳密検算を作れる主張は SageMath で検算し、`overview.md` に対象ラベル、実行日、PASS または失敗を記録する。失敗した検算を消さない。
- 次の検査を全て通す。

```sh
(cd countable-ising-on-hyperbolic-surfaces/structured-latex && npm run gen && npm run check && npm run build:pdf)
node countable-ising-on-hyperbolic-surfaces/sagemath/tools/verify-check-linkage.ts
```

その tick で SageMath の検算を追加・変更した場合は、対象の `.sage` を実行する。

- `auto-loop-state.md` と `MEMORY.md` を実態に合わせて更新する。Lean 未着手を完了と書かない。
- 変更をコミットする前に再度 fetch し、remote default branch の進行を確認する。競合しない遅れは取り込む。
- 成果を `origin/main` へ push し、成果コミットが fetch 後の `origin/main` の祖先であることを確認する。ここまで済まなければ完了ではない。
- 作業結果を通知する場合は話題名を「有限双曲曲面上の可算イジング模型」とし、公開本文
  `https://hexcomp-artifacts.web.app/math/countable-hyperbolic-ising-mathjax/` を付ける。
- 一つの主張を進めたら止まる。次の主張は次の tick へ残す。

## レビュー観点

- 有限群の名前だけから曲面性・正則性・向き付けを仮定していないか。
- 有限集合とその添字集合、商集合と代表元、多項式と評価値を同一視していないか。
- `x`、`t` を実温度の関数として定義していないか。
- 可算 habitat の数式に `R/C`、極限、積分、実指数が混入していないか。
- 高温展開の偶部分グラフと、セル複体のホモロジー類を定義なしに同じものとして扱っていないか。
- 主格子と双対格子の対応に、始域・終域のある写像があるか。
- Fisher 零点の代数的表現と数値近似を区別しているか。
- 商の列と、被覆写像をもつ商の塔を区別しているか。

## 止まってよい場合

`docs/context/` の変更が必要な場合、研究ゴールの変更が必要な場合、不可逆操作が必要な場合だけ、人間の判断を求めて止まる。単に次の作業へ進む区切りは停止理由にならない。ただし一 tick 一主張の上限は、この自動ループに対するユーザーの指示として優先する。
