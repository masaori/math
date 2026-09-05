# 自動ループ Runbook（毎時）

このファイルは、毎時 12 分に独立したエージェントが読み、研究を一層だけ前進させる手順の正本である。
進捗は [auto-loop-state.md](auto-loop-state.md) に残す。研究姿勢は
[マニフェスト](../マニフェスト.md) を最優先する。

このループが**向いている方向そのもの**は、6 時間ごとの独立した監督が評価する（契約は
[supervision-runbook.md](supervision-runbook.md)、記録は [supervision-log.jsonl](supervision-log.jsonl)）。
**この tick から監督の記録を書かない。** 前進の駆動と方向の決定を同じループへ置くと、
方向が空になったことをこのループの内側からは検出できない。逆に、監督はこの tick を止めず、
頻度も変えず、1 tick で進める一層の中身も決めない。

## 1 tick の境界

1. 前 tick の成果を先にレビューする。誤りを見つけた場合は新規作業より修正を優先する。
2. **成果整理が完了するまで、新しい定義・定理・証明対象を起票しない。** 台帳の「成果整理」の
   先頭にある未完了一層だけを進める。
3. 一層を検証し、台帳と MEMORY を更新し、`origin/main` への包含を確認して止まる。
4. 整理完了後に次の研究対象へ進む場合は、人間が上位ゴールを定めてから runbook を改訂する。

## 現在の上位ゴール: 既存成果の二章への整理

既存の章立てを正本として扱わず、本文の全定義・全定理を一度フラットな集合として監査する。
最終章は次の二つだけとする。

- **数学的道具立て**: 有限集合・写像・関係・順序・近傍割り当て等について、2 値 CA の状態、
  局所規則、大域写像、時間発展を仮定せずに述べられるもの。
- **2 値セルオートマトンのセマンティクスを持つもの**: 2 元状態、局所規則、大域写像、
  時間発展のいずれかが主張の意味に不可欠なもの。

整理は次の順で行う。

1. 全定義・全定理を旧章から外して一覧化し、参照依存を抽出する。
2. 各項目を上の二章へ全件分類する。数学的道具へ CA 固有語・仮定・解釈が混入していないかを検査する。
3. 独立した複数のレビューを反復し、分類境界への指摘が無くなるまで修正する。
4. 各章内を参照依存のトポロジカル順に並べる。
5. 依存上のまとまりから節を設計し、各節の入力、出力、主定理または主張を本文に明示する。
6. 構造化テキスト、PDF、全 SageMath 対応、Lean 全体を検証し、公開物へ反映する。

成果整理の `done` は、全件分類の網羅性、章内の依存順、節の入力・出力・主定理、独立レビューの
指摘解消が機械検査または記録で確認できた場合だけ付ける。

Claude 回は専用アカウントの `claude-opus-5`、effort `medium` に固定する。モデルの利用上限を
検出しても別モデルへ実行時に切り替えず、エラーとして終了する。

## 着手前に読むもの

- `docs/context/` の全ファイル
- このプロジェクトの `README.md`、`docs/マニフェスト.md`、`MEMORY.md`
- この runbook と `auto-loop-state.md`
- `docs/2値セルオートマトンの定義と呼び名.md`
- 今回の対象を定める survey / ideas / structured-latex の該当箇所

## 研究方向の制約

- 量子、場、粒子、時空、エネルギー等の物理的意味を局所規則へ入れない。
- ヒルベルト空間、作用素代数、多様体、因果集合等の既存構造を目標仕様として先に置かない。
- 有限舞台、有限状態集合、有限真理値表から内在的に定義できる集合・写像・関係・演算を先に抽出する。
- 既存理論との比較は第二段階で行い、比較写像、保存される構造、失われる情報を明記する。
- 実数・複素数、完備化、無限積、全配位空間を使う場合は、その行で脱出点と目的を明記する。
- CA 側に既存物理との対応物がない構造を捨てない。反例と否定結果も台帳に残す。

## 命題を昇格させる四層

### 構造化記述

- 証明の正本は `structured-latex/content/` に置く。
- 一ブロック一主張、一行一変形、各行末に根拠を書く。
- すべての記号の所属と、有限・高々可算・非可算のどれかを宣言する。
- 人手証明は現在の CA の具体的対象に固定し、既製の一般論へ丸投げしない。

### SageMath

- `sagemath/check/<対象名>/check.sage` と `overview.md` を対にする。
- 浮動小数点を使わず、有限集合、`ZZ`、`QQ`、有限体、厳密多項式環で検証する。
- 本文の証明の各段を別々に検査し、最終式だけの一致で済ませない。
- 全数列挙の範囲と、そこから一般の場合を結論できないことを記録する。

### Lean 具体版

- 人手証明と同じ対象、同じ仮定、同じ順序で形式化する。
- `sorry`、`admit`、未証明公理を使わない。
- 人手証明に無い強い既製定理だけで結論へ飛ばない。

### Lean 必要十分版と導出

- 具体版の証明で実際に使った構造だけを残した定理を書く。
- 状態が二値であること、舞台がグラフであること、時間が自然数であること等を落とせるか一つずつ検査する。
- 具体版が抽象版の特殊化であることを別の定理で導出する。

`done` は四層が揃い、相互の主張が一致した場合だけ付ける。

## 1 tick の実行手順

1. remote default branch を取得し、専用 worktree が最新であることを確認する。
2. 前 tick の変更を本文・SageMath・Lean・台帳の間で突き合わせる。
3. 修正があれば検証して先にコミット・push する。
4. 台帳の「成果整理」の先頭にある未完了一層だけを進める。新しい証明対象は起票しない。
5. 下の検証を通す。検証を主張に合わせて弱めない。
6. `auto-loop-state.md` の現在地と対象表、`MEMORY.md` を更新する。
7. commit し、remote が進んでいれば取り込んでから `HEAD:main` へ push する。
8. fetch 後、成果コミットが remote default branch の祖先であることを確認する。
9. 正常終了かつ worktree が clean の場合だけ、外側の `scripts/publish-artifact.sh` が論文 HTML を
   `hexagonal-computation/artifacts` へ公開し、Firebase Hosting の公開 URL が HTTP 200 を返した後、その URL を含む
   Slack 通知を一度だけ送る。公開アーティファクト URL のない完了通知は送信失敗として扱う。
   tick 内のエージェントは通知しない。

## 検証

存在する層について、少なくとも次を行う。

```sh
(cd cellular-automata-statistical-mechanics/structured-latex && pnpm run check)
(cd cellular-automata-statistical-mechanics/structured-latex && pnpm run build:pdf)
sage cellular-automata-statistical-mechanics/sagemath/check/<対象名>/check.sage
node cellular-automata-statistical-mechanics/sagemath/tools/verify-check-linkage.ts
node cellular-automata-statistical-mechanics/sagemath/tools/verify-tooling-tests.ts
bash cellular-automata-statistical-mechanics/scripts/verify-roadmap-artifact.sh
(cd cellular-automata-statistical-mechanics/lean && lake build && bash scripts/check-no-sorry.sh)
```

掃引 `sweep_all_checks.py` の収集・集計の fail-closed 性を守っているのは、その単体テスト
`test_sweep_all_checks.py` だけである。`verify-tooling-tests.ts` はその単体テストを fail-closed に
走らせる入口であり、テストファイル 0 本・実行件数 0 件・skip 混入を成功として通さない。
掃引の実装を触った tick は必ずこれを通す。

初回に検証基盤を作る場合は、リポジトリ内の既存 structured-latex / SageMath / Lean 基盤を参照し、
語彙を複製せず共通の構造化テキストシステムを利用する。

## 最初の探索列

最初は物理的な名前を使わず、局所真理値表から生じる依存関係だけを調べる。

- 局所規則の本質的依存台を有限の存在量化で定義し、真理値表から決定できることを示す。
- 冗長な近傍を足しても本質的依存台が変わらないことを示す。
- 有限時間展開上の直接依存関係と、その推移閉包を定義する。
- 時間座標が厳密に増えることだけから、推移閉包が反対称であることを示す。
- 到達可能なセルの有限性と有限伝播境界を示す。
- ここまでで得た順序・凸部分集合・非比較関係をカタログ化した後にだけ、既存の因果構造と比較する。

## 止まってよい場合

- マニフェストまたは `docs/context/` の変更が必要になった。
- 既存理論を目標仕様に採るか否かで結果が変わり、一次情報だけでは決められない。
- 未許可の不可逆操作、課金、秘密情報、ユーザー固有の価値判断が必要になった。

検証失敗、依存不足、remote の前進、仮説の反例は停止理由ではない。直すか、否定結果として記録する。

## 起動

- launchd ラベル: `com.masaori.cellular-automata-auto-loop`
- 定義: `~/Library/LaunchAgents/com.masaori.cellular-automata-auto-loop.plist`
- 発火: 毎時 12 分（`~/Library/LaunchAgents/com.masaori.cellular-automata-auto-loop.plist` の実測）
- 専用 worktree: `<repo>/.codex/worktrees/tick/cellular-automata-auto-loop`
- ログ: `~/Library/Logs/cellular-automata-auto-loop/auto-loop.log`
- エージェント: Claude と Codex を tick ごとに交互に使う
- 論文公開・通知: `scripts/publish-artifact.sh`（同じ論文版は再通知しない）

### launchd の実体は自分で触らない（2026-08-16 に経路が固定された）

**`launchctl`（`bootstrap` / `bootout` / `kickstart`）と `~/Library/LaunchAgents/` の編集を、
この tick から行ってはならない。** 設置・頻度変更・一時停止・再開は、tmux セッション
`local-pc-management` のウィンドウ `tick窓口` へ依頼する（`launchd-tick-loop` skill と
`communicate-with-agent-session` skill に従う）。**頻度そのものは柔軟に変えてよい。固定するのは経路である。**
あるべき頻度の宣言は `local-pc-management/agent-sessions/config/tick-schedules.json` にあり、
実体との食い違いは日次の監査が検出して宣言側へ戻す（＝実体だけ書き換えても翌朝消える）。

**読み取りだけの調査は自由。** 次はそのまま使ってよい。

```sh
bash ~/.local/bin/cellular-automata-loop-launcher.sh              # 手で 1 tick 回す（launchd を触らない）
launchctl print "gui/$(id -u)/com.masaori.cellular-automata-auto-loop" | grep -E 'state =|last exit|calendar'
tail -50 ~/Library/Logs/cellular-automata-auto-loop/auto-loop.log           # 見送り／打ち切り／異常終了の区別
python3 ~/git/masaori/local-pc-management/agent-sessions/audit-tick-schedules.py  # 宣言との食い違い
```
