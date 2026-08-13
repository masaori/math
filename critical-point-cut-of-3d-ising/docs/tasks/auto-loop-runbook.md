# 自動ループ Runbook（30 分に 1 回）

このファイルは、30 分ごとの launchd が**毎回まっさらな文脈で**読み、決定論的に 1 tick 分を
実行するための手順書である。状態は [auto-loop-state.md](auto-loop-state.md) に永続化する。
判断の根拠は、この 2 ファイルとリポジトリ内の一次情報
（`docs/context/`、このプロジェクトの [README](../../README.md)、
`docs/discussion/3次元Isingを可算側で書く/`）だけとする。

## 1 tick の大方針（最重要・絶対遵守）

1. **既存出力のレビューと修正を先に行う。** 新しいセクションへ進む前に、既に書いたものを読み直し、
   誤り・記号の濫用・未証明の主張の扱い・立場違反（許されない脱出）を直す。
   レビューを飛ばして前進してはならない。
2. **前進は 1 セクションだけ。** 1 tick で複数セクションを進めない。進めたら止まり、次の tick を待つ。
   （リポジトリ全体の「todo が尽きるまで連続消化する」規約より、**このループではこちらが優先**する。
   ユーザーの明示指示による。）
3. **30 分間隔なので、セクションは 1 tick で終わる大きさに割る。** 割る基準は時間ではなく**中身**である。
   1 セクションは「1 つの論法で閉じるもの」に限る（帰納法 1 本、両包含 1 組、1 対 1 対応 1 つ、
   有限和の評価 1 本）。定義を複数書いて主張も複数示す塊は必ず割る。
4. **立場を偽らない。** 許されない脱出（上限・下限・積分・微分・無限和・指数関数・実対数）を
   使ったまま「可算で閉じた」と書かない。箱の大きさの極限を使ったら、そのブロックの
   `habitat` を非可算にして `realEscape` に書く。
5. **未証明を未証明と書く。** `todo` を消すのは証明が書けたときだけである。
   未証明の主張に依存する主張には、依存していることを本文に明記する。

## 1 tick の実行手順

1. **同期**: `git fetch origin main && git status` で作業ツリーが `origin/main` の最新であることを
   確認する。遅れていて競合しないなら取り込む。
2. **読む**: `docs/context/` を全て、このプロジェクトの `README.md`、`MEMORY.md`、
   `auto-loop-state.md`、および `docs/discussion/3次元Isingを可算側で書く/` の全ファイル。
3. **レビューと修正**（毎 tick 必須。下の「レビュー観点」）。
   直したものがあれば、その時点でコミットし、**その場で push まで済ませる**。
   前進の作業に入る前に `origin/main` へ入れること。
4. **前進**: `auto-loop-state.md` の `status: todo` の**最初の 1 セクション**だけを実行する。
   **時間のかかる処理は前面で実行し、終わるまで待つ。** tick が終わると子プロセスは道連れに
   終了するので、「裏で走らせたまま tick を終える」は成果が残らない。
5. **検証**（下の「検証コマンド」）。すべて通るまで直す。落ちたら本文を直す
   （検証を主張に合わせて緩めない）。
6. **台帳と MEMORY の更新**: セクションの四層の状態、観察、日付を書く。
7. **main へ push**し、`git merge-base --is-ancestor <commit> origin/main` で反映を確認する。
8. **PDF を作り直す**（`cd structured-latex && npm run build:pdf`）。**tick の最後に必ず行う。**
   本文を 1 行も変えなかった tick でも作り直す（人間が開いたまま進み具合を見るため）。
9. **止まる。** 次のセクションへ進まない。次の tick を待つ。

## レビュー観点（毎 tick、前進の前に）

**1 tick で全部を見る必要はない。前回のレビュー到達点を台帳に記録し、続きから見る。**

- [ ] **許されない脱出が混ざっていないか**（このプロジェクト固有・最重要）。
      上限・下限・積分・微分・無限和・級数・指数関数・実対数・逆温度の記号を使っていないか。
      無限体積の語（相・臨界温度・自発磁化）を主張に使っていないか。
      箱の大きさの極限を使ったブロックが `habitat` を非可算にして `realEscape` を書いているか。
- [ ] **記号の濫用が無いか**。1 記号 1 意味か。多項式とその値を区別しているか。
      初出で宣言していない記法を使っていないか。省略された量化子が無いか。
- [ ] **一ステップ一定理が守られているか**。式変形が飛んでいないか。
      本文で示した定義・主張の適用にラベル参照が付いているか。
- [ ] **未証明の扱いが正しいか**。`todo` を残した主張に依存する主張が、依存を明記しているか。
      証明が書けていないのに `todo` を消していないか。
- [ ] **SageMath 検証が本文と対応しているか**。本文を直したのに検証が古いままになっていないか。
      逆に、検証を通すために本文の主張を弱めていないか（**これは禁止**。記録も消さない）。
- [ ] **台帳の状態が実態と合っているか**。四層のどこまで済んだかを偽っていないか。

修正した場合は、**何をなぜ直したかを台帳の「レビュー記録」へ 1 行で残す**。

## セクション完了の条件（四層。2 次元側と同じ）

セクションを `done` にしてよいのは次を**すべて**満たしたときだけである
（[docs/context/証明の書き方.md](../../../docs/context/証明の書き方.md) の四層の検証）。

1. **記述**: 本文が構造化テキストで書けている（一ステップ一定理・根拠の明示・記号の帰属・住処の宣言）。
   未証明の `todo` がそのセクションに残っていない。
2. **SageMath 検証**: 式変形と数え上げを**一行ずつ**確かめる検証があり、**実行して通っている**
   （`sagemath/check/<対象名>/overview.md` に対象ラベル・結果・実行日）。`ZZ`/`QQ` の厳密計算で行う。
3. **Lean 具体版**: 人手証明と **1 対 1 に対応する**証明が `lean/Ising3DCut/` にあり、
   `lake build` が通り `sorry` が無い。**人手証明の計算を mathlib の一般論へ委ねない。**
4. **Lean 必要十分版**: 同じ手順のまま抽象度だけ必要十分まで上げた版が `lean/Ising3DCut/NecSuf/` にあり、
   仮定が「具体版の証明が実際に使っている性質」だけになっている。削れなかった仮定は理由をコメントに書く。
   **mathlib の高抽象度の既製定理へ丸投げしたものは認めない。**

四層のどこまで済んだかは台帳の `status` に正直に書く（`記述まで` / `記述と SageMath まで` /
`Lean 具体版まで` / `done`）。**Lean 未着手を黙って `done` にしない。**

**1 tick 1 セクションの上限があるので、Lean は 1 tick に 1 主張（具体版・必要十分版・導出の 3 本）** を
上限とする。それで収まらない主張は、先に本文の側で論法ごとに割り直す。

## 検証コマンド（push 前に毎回）

```sh
(cd structured-latex && npm run check)       # 生成物の鮮度 → 型検査 → 実行時検証 → ノート非混入
(cd structured-latex && npm run build:pdf)   # PDF まで組めること（組めない文字・未解決参照を検出）
sage sagemath/check/<対象名>/check.sage       # その tick で触れた検証
node sagemath/tools/verify-check-linkage.ts  # 検証 ↔ 証明の対応
(cd lean && lake build)                      # Lean が通ること
(cd lean && bash scripts/check-no-sorry.sh)  # 入口からの import・sorry 非依存・登録漏れ
```

ラベル・ブロックを増減したら `(cd structured-latex && npm run gen)` を先に走らせる
（忘れると型検査が落ちる）。

## git レシピ

`main` は保護されていないので直接 push する。

```sh
git add -A
git commit -m "ising-3d-cut auto-loop: <セクション名>（<何をしたか>）"
git push origin HEAD:main
git fetch origin && git merge-base --is-ancestor HEAD origin/main && echo INCLUDED
```

non-fast-forward で蹴られたら `git fetch origin main && git rebase origin/main` してから push する。

## 止まってよい場合

リポジトリ直下 CLAUDE.md「ユーザーに判断を求めてよい条件」に該当する場合だけ止めて問う。
このプロジェクトで実際に起きうるのは次の 2 つである。

- **`docs/context/` を直したくなったとき。** 人間の確認と議論が必須（例外なし）。提案だけして止まる。
- **立場そのものを緩める判断が必要になったとき**（例: あるセクションが箱の大きさの極限以外の
  脱出なしには書けないと分かったとき）。台帳へ論点を書き、報告して止まる。
  **黙って脱出して書き進めてはならない。**

作業単位の区切りそれ自体は停止理由にならない——が、**1 tick 1 セクションの上限は守る**。

## 報告（Slack。毎 tick・ユーザー指示）

**毎 tick の完了時に、作業内容の概要と公開したアーティファクトの URL を添えて Slack へ報告する。**
これは `scripts/publish-artifact.sh` が tick の最後に自動で行う（tick が手で呼ぶ必要はない）。

- 本文は台帳の「現在地」の先頭項目をそのまま使う。**だから「現在地」の先頭に、
  その tick で何をしたかを人間が読める日本語で書くこと。** 番号や記号だけで書かない。
- 同じ版（コミット）では二度送らない。
- **止まったとき**（下の「止まってよい場合」に該当し人間の判断を待つとき）は、
  それとは別に `slack-notification` skill で論点を報告する。

## 論文を Web で公開する（ユーザー指示）

`scripts/publish-artifact.sh` が `structured-latex/content/` から論文 1 枚の HTML
（`tools/build-html.ts`）を作り、artifacts リポジトリの GitHub Pages へ置く。tick の最後に自動で走る。

- **公開するのは論文であって、進捗の報告ではない。** 台帳の内容は HTML へ載せない。
- **PDF は公開しない。** 手元の `structured-latex/build/document.pdf` で読む
  （tick はメイン側の同じパスへ複製するので、ビューアを開いたままにできる）。
- **URL を決め打ちしない。** 実際の URL は
  `~/Library/Logs/ising-3d-cut-auto-loop/publish-artifact.log` の「OK: 公開した」の行に出る。

## 打ち切られたときの扱い

25 分の上限に当たった tick は、push 前で終わっている可能性が高い。

- **次の tick はまず作業ツリーに残った成果を拾う。** `git status` を確認し、
  検証を通してからコミットする（捨てない）。目印は
  `~/Library/Logs/ising-3d-cut-auto-loop/leftover-from-tick` にある。
- **打ち切られたセクションは、やり直す前に割り直す。** 割る基準は中身である（上の大方針 3）。
- **時計は見る。** tick には毎回「まとめに入る締切」（強制終了の 5 分前）が渡される。
  作業の区切りごとに `date` で現在時刻を確認し、締切を過ぎたら新しい着手をやめて、
  手元にあるものを検証・コミット・push して終える。見積もりではなく観測である。

## 起動の仕組み（launchd。対話セッションとは独立）

各 tick は launchd が起動する**独立したセッション**として走る。会話の文脈は持ち越さない。
持ち越すのは、この runbook・状態台帳・リポジトリの中身だけである。だからこそ台帳を正直に書く。

| | |
| --- | --- |
| ラベル | `com.masaori.ising-3d-cut-auto-loop` |
| 定義 | `~/Library/LaunchAgents/com.masaori.ising-3d-cut-auto-loop.plist` |
| 起動 | `~/.local/bin/ising-3d-cut-loop-launcher.sh`（リポジトリ外。専用 worktree を用意して tick 本体を exec する） |
| 実体 | `scripts/auto-loop-tick.sh`（毎時 0 分と 30 分。多重起動を防ぎ、25 分で打ち切る） |
| 作業ツリー | `~/git/masaori/math-ising-3d-cut-loop`（ブランチ `ising-3d-cut-loop`。毎 tick の冒頭で `origin/main` へ合わせる） |
| 使うエージェント | **Claude と Codex を 1 tick ごとに交互**（2 次元側と同じ運用）。Claude は `claude-fable-5` の effort medium、Codex は `gpt-5.6-sol` の reasoning medium。直前に使ったほうを `logs/last-agent` に記録し、その反対を選ぶ |
| ログ | `~/Library/Logs/ising-3d-cut-auto-loop/auto-loop.log`（リポジトリ外。作業ツリーを合わせ直しても消えないため） |

```sh
bash ~/.local/bin/ising-3d-cut-loop-launcher.sh                       # 手で 1 tick 回す
launchctl kickstart -k gui/$(id -u)/com.masaori.ising-3d-cut-auto-loop # 次の発火を待たず起動する
launchctl bootout gui/$(id -u)/com.masaori.ising-3d-cut-auto-loop      # 止める
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.masaori.ising-3d-cut-auto-loop.plist
```

**2 次元側のループ（`com.masaori.ising-lambda-auto-loop`。毎時 5 分と 35 分）とは別の作業ツリーで走る。**
同じ作業ツリーを共有すると、あちらの tick が 45 分走る間こちらは「汚れている」で見送られ続けるためである。
発火時刻をずらしてあるのは機械の負荷を分けるため。
