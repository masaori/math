# 自動ループ Runbook（1 時間に 1 回）

このファイルは、1 時間ごとの cron が**毎回まっさらな文脈で**読み、決定論的に 1 tick 分を実行するための手順書である。
状態は [auto-loop-state.md](auto-loop-state.md) に永続化する。判断の根拠は、この 2 ファイルと
リポジトリ内の一次情報（`docs/context/`、このプロジェクトの [README](../../README.md)、
`docs/discussion/Lee-Yang-Fisher零点プログラム/`、`docs/discussion/対数順序群上の統計力学/`）だけとする。

## 1 tick の大方針（最重要・絶対遵守）

1. **既存出力のレビューと修正を先に行う。** 新しいセクションへ進む前に、既に書いたものを読み直し、
   誤り・記号の濫用・未検証の主張を直す。レビューを飛ばして前進してはならない。
2. **前進は 1 セクションだけ。** 1 tick で複数セクションを進めない。進めたら止まり、次の tick を待つ。
   （リポジトリ全体の「todo が尽きるまで連続消化する」規約より、**このループではこちらが優先**する。
   ユーザーの明示指示による。）
3. **四層の状態を偽らない。** 記述・SageMath・Lean 具体版・Lean 必要十分版のどこまで済んだかを
   台帳に正直に書く。未検証のまま「証明した」と書かない。

## 1 tick の実行手順

1. **同期**: `git fetch origin main && git status` で作業ツリーが `origin/main` の最新であることを確認する。
   遅れていて競合しないなら取り込む。
2. **読む**: `docs/context/` を全て、このプロジェクトの `README.md`、`MEMORY.md`、`auto-loop-state.md`。
3. **レビューと修正**（毎 tick 必須。下の「レビュー観点」）。
   直したものがあれば、その時点でコミットし、**その場で push まで済ませる**。
   前進の作業に入る前に `origin/main` へ入れること
   （実測: 初回 tick でレビューの修正をコミットしたまま前進へ移り、tick が終わって push されずに残った）。
4. **前進**: `auto-loop-state.md` の `status: todo` の**最初の 1 セクション**だけを実行する。
   **時間のかかる処理は前面で実行し、終わるまで待つ。**
   tick が終わるとその tick が起動した子プロセスは道連れに終了するので、
   「裏で走らせたまま tick を終える」は成果が残らない
   （実測: 初回 tick が `lake update` を裏で走らせたまま終了し、取得済みの 305MB が消えた）。
   1 tick（50 分）で終わらない見込みなら、**終わる大きさに割り直してから**着手する。
5. **検証**（下の「検証コマンド」）。すべて通るまで直す。落ちたら本文を直す（検証を主張に合わせて緩めない）。
6. **台帳と MEMORY の更新**: セクションの四層の状態、観察、日付を書く。
7. **main へ push**し、`git merge-base --is-ancestor <commit> origin/main` で反映を確認する。
8. **止まる。** 次のセクションへ進まない。次の tick を待つ。

## レビュー観点（毎 tick、前進の前に）

前回までに書いたもの（`structured-latex/content/`、`notes/`、`sagemath/`、`lean/`）を対象に見る。
**1 tick で全部を見る必要はない。前回のレビュー到達点を台帳に記録し、続きから見る。**

- [ ] **記号の濫用が無いか**（README「記号の濫用を排除する」）。1 記号 1 意味になっているか。
      添字集合とそこに構造を与える写像が分かれているか。多項式とその値が区別されているか。
      初出で宣言していない記法を使っていないか。省略された量化子が無いか。
- [ ] **住処の宣言が実態と合っているか**。可算を宣言したブロックが本当に可算で閉じているか。
      非可算のブロックの `realEscape` が、脱出の理由として具体的か。
- [ ] **一ステップ一定理が守られているか**。式変形が飛んでいないか。
      本文で証明済みの定義・主張の適用にラベル参照が付いているか。
- [ ] **未定義のまま使っている概念が無いか**。
- [ ] **四層の状態の記述が正しいか**。台帳・MEMORY・`overview.md` の「済んだ」が実態と合っているか。
- [ ] **SageMath 検証が本文と対応しているか**。本文を直したのに検証が古いままになっていないか。
      逆に、検証を通すために本文の主張を弱めていないか（**これは禁止**。記録も消さない）。

修正した場合は、**何をなぜ直したかを台帳の「レビュー記録」へ 1 行で残す**。

## セクション完了の条件

セクションを `done` にしてよいのは、次をすべて満たしたときだけである。

- 本文が構造化テキストで書けている（一ステップ一定理・記号の帰属・住処の宣言）。
- 対応する SageMath 検証があり、**実行して通っている**（`overview.md` に対象ラベルと結果と実行日）。
- Lean の具体版と必要十分版が書けており、`lake build` が通り `sorry` が無い。

Lean だけが未了なら `done` にせず `記述と SageMath まで` と書く。**「Lean 未着手」を黙って `done` にしない。**

## 検証コマンド（push 前に毎回）

```sh
(cd structured-latex && npm run check)          # 生成物の鮮度 → 型検査 → 実行時検証 → 負テスト
(cd structured-latex && npm run build:pdf)      # PDF まで組めること（組めない文字・未解決参照を検出）
sage sagemath/check/<対象名>/check.sage          # その tick で触れた検証
node sagemath/tools/verify-check-linkage.ts     # 検証 ↔ 証明 の対応
(cd lean && lake build && bash scripts/check-no-sorry.sh)   # lean/ に中身がある場合
```

## git レシピ

`main` は保護されていないので直接 push する。

```sh
git add -A
git commit -m "ising-lambda auto-loop: <セクション名>（<何をしたか>）"
git push origin HEAD:main
git fetch origin && git merge-base --is-ancestor HEAD origin/main && echo INCLUDED
```

non-fast-forward で蹴られたら `git fetch origin main && git rebase origin/main` してから push する。

## 止まってよい場合

リポジトリ直下 CLAUDE.md「ユーザーに判断を求めてよい条件」に該当する場合だけ止めて問う。
このプロジェクトで実際に起きうるのは次の 2 つである。

- **`docs/context/` を直したくなったとき。** 人間の確認と議論が必須（例外なし）。提案だけして止まる。
- **証明の方針そのものを変える判断**（例: ある章を可算側で書ききれないと分かり、
  ℝ 脱出の位置を動かす必要が出たとき）。台帳へ論点を書き、報告して止まる。

作業単位の区切りそれ自体は停止理由にならない——が、**1 tick 1 セクションの上限は守る**（上記大方針 2）。

## 報告（Slack）

**毎 tick は報告しない**（1 時間ごとに通知が来ると読まれなくなる）。次の 2 つの場合だけ
`slack-notification` skill で報告する。

- **セクションが `done` になったとき**（四層すべて満たした）。何を証明したかを 1–2 文で書く。
- **止まったとき**（下の「止まってよい場合」に該当し、人間の判断を待つとき）。何が論点かを書く。

検証が落ちて自分で直した、レビューで誤りを直した、といったことは台帳に書けばよく、通知しない。

## 起動の仕組み（launchd。このセッションとは独立）

各 tick は launchd が起動する**独立した Claude セッション**として走る。会話の文脈は持ち越さない。
持ち越すのは、この runbook・状態台帳・リポジトリの中身だけである。だからこそ台帳を正直に書く。

| | |
|---|---|
| ラベル | `com.masaori.ising-lambda-auto-loop` |
| 定義 | `~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist` |
| 実体 | `scripts/auto-loop-tick.sh`（毎時 23 分。多重起動を防ぎ、50 分で打ち切る） |
| ログ | `logs/auto-loop.log`（git 管理外） |

```sh
bash scripts/auto-loop-tick.sh                                   # 手で 1 tick 回す
launchctl kickstart -k gui/$(id -u)/com.masaori.ising-lambda-auto-loop   # 次の発火を待たず起動する
launchctl bootout gui/$(id -u)/com.masaori.ising-lambda-auto-loop        # 止める
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist  # 再開する
```
