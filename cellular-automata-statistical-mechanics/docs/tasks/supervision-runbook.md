# 研究監督 Runbook（6 時間ごと）

このファイルは、**研究を前進させる自動ループとは別に**、その自動ループが向いている方向そのものを
定期的に評価する手順の正本である。記録は [supervision-log.jsonl](supervision-log.jsonl) に残す。

研究を一層進める手順の正本は [auto-loop-runbook.md](auto-loop-runbook.md) であり、
**この監督はそちらを置き換えない。** 監督は研究 tick を止めず、頻度も変えず、
研究 tick が扱う一層の中身も決めない。監督が触るのは**方向**だけである。

## なぜ独立の監督が要るのか

研究 tick は「台帳の先頭の未完了一層を進める」という形で駆動される。この形は前進を確実にする代わりに、
**一層の完了を積み上げること自体が目的化しても、その内側からは検出できない。**

実際に起きた。[auto-loop-state.md](auto-loop-state.md) の 2026-09-05 の各節を読むと、
成果整理は全層 `done` に達しているにもかかわらず、以後の tick は検査ツールの穴を塞ぐ作業を
繰り返している。個々の tick は正しく、検査は実際に強くなった。しかし
[README](../../README.md) が掲げる問い（連続物理の概念ごとの可算な担い手の同定、境界の同定、
実数を経由しない熱力学の構成）へは、その間ひとつも近づいていない。

**個々の tick の正しさは、方向の正しさを含意しない。** 方向は、tick の外から、
tick より長い時間尺度で見なければ判定できない。それがこの監督の存在理由である。

## 監督の契約（1 回の監督で何を判定するか）

1 回の監督は、次の四つを**必ず全て**判定し、判定と根拠を機械可読な記録として残す。
四つのうち一つでも欠けた記録は、検査 `verify-supervision-log.ts` が受理しない。

### 最終ゴールとの照合（ゴールを忘れていないか）

[README](../../README.md) の「問い」と「成果物」、および
[マニフェスト](../マニフェスト.md) の「成功条件」を、直前の監督以降に積まれた成果と突き合わせる。

判定は `整合` か `逸脱` の二値で書く。`逸脱` と判定するのは、次のいずれかが言えるときである。

- 積まれた成果が、README の五つの成果物のどれにも寄与していない。
- 成果が寄与していると主張できるが、その主張が成果物の名前の言い換えでしかない。
- 手段（検査基盤・公開・整形）の改善だけが積まれ、問いへの前進が無い。

**`逸脱` は失敗ではない。** 検出して記録し、次の探索へ接続することがこの監督の仕事である。
`逸脱` を避けるために判定を甘くすることを禁じる。

### 段取りの妥当性（ロードマップは今も正しいか）

`structured-latex/research-roadmap.ts` の七段階について、**段取りが書かれた時点では
分かっていなかったこと**が、その後の成果から分かっていないかを問う。

判定は `妥当` か `要変更` の二値。`要変更` と判定する根拠になるのは、例えば次である。

- 現在地の段階の完了条件が、実際には有限検査で判定できない形だと分かった。
- ある段階の依存が逆向き、または不要だと分かった（後段の結果が前段を要していない）。
- ある段階の範囲に、その段階では扱えない対象が混ざっていると分かった。
- 段取りに無い対象が、成果の側で繰り返し現れている（段取りの側に穴がある）。

### 証明済み事項から得たインサイト

直前の監督以降に本文へ入った定義・主張・定理を読み、**そこから何が分かったか**を書く。
書くのは定理の再述ではない。「この主張が成り立つということは、〜という構造が効いている／
〜は本質的でなかった」という、次の探索の向きを変えうる内容である。

得たインサイトが無いなら、無いと書く。**無いことは正当な記録であり、
無理に何かを書くこと（そしてそれが次の監督で根拠として扱われること）のほうが有害である。**

### 段取りの変更（変えるべきなら変える）

上の判定から段取りを変えるべきだと結論したなら、**この監督の中で
`structured-latex/research-roadmap.ts` を実際に変更する。** 提案だけを残して次へ送らない。

変更するときの制約は二つ。

- **証拠と差分を残す。** 何をどう変えたか、どの成果を根拠にしたかを記録に書く。
  根拠は本文のラベルかプロジェクト内のファイルで、検査が実在を確かめる。
- **ゴールを縮めない。** 到達できていない段階を、到達できていないという理由で
  範囲から外したり、完了条件を弱めたりしてはならない。段階の分割・順序・依存・範囲の
  記述を変えることは許されるが、[README](../../README.md) の三つの問いが射程から落ちる変更は
  この監督の権限の外にあり、人間へ渡す。

## 進捗を件数で測らない（この監督が最も守るべき一点）

**証明の件数・ブロック数・検査の件数・ページ数を、この研究の進捗として扱ってはならない。**
それらは[方法論レイヤー](../../../docs/context/成果の出し方.md)が明示的に禁じている
「物量を成果と言い換えること」そのものである。

したがって監督の記録は、件数ではなく**反復の中身**を持つ。1 回の監督は、直前の監督以降に
実際に起きた反復を、次の形で列挙する。

| 項目 | 内容 |
| --- | --- |
| 対象 | その反復が扱った本文のラベル、またはプロジェクト内のファイル。**検査が実在を確かめる** |
| 仮説 | 何が成り立つと考えて手を付けたか |
| 反例 | 仮説が崩れたなら、崩した具体例。崩れていないなら空 |
| 不変量 | その反復で同定された不変量・構造。無ければ空 |
| 採否 | `採用` / `棄却` / `保留` のいずれか。`棄却` には反例が必須 |
| インサイト | この反復から分かったこと |
| 次の探索への接続 | それが次に何を調べさせるか |

**対象が実在しない反復は記録として受理されない。** これは、監督が抽象的な感想
（「順調に進んでいる」「方向は妥当である」）だけで自分を通せてしまう経路を塞ぐためである。

## 着手前に読むもの

- `docs/context/` の全ファイル（リポジトリ全体の思想の正本）
- このプロジェクトの `README.md`、`docs/マニフェスト.md`
- `structured-latex/research-roadmap.ts`（段取りの正本）
- `docs/tasks/auto-loop-runbook.md` と `docs/tasks/auto-loop-state.md`
  （研究 tick の契約と、直前の監督以降の全ての節）
- `docs/tasks/supervision-log.jsonl`（直前までの監督の記録。特に「次の監督までの申し送り」）

## 1 回の監督の実行手順

1. remote default branch を取得し、専用 worktree が最新であることを確認する。
2. 直前の監督の記録の末尾から現在までに積まれた研究 tick の節と成果コミットを特定する。
   **これが今回の監督の対象範囲であり、記録へ書く。**
3. 上の四つを判定する。判定に使った一次情報を、ラベルまたはプロジェクト内のパスで指す。
4. 段取りを変えるべきなら `structured-latex/research-roadmap.ts` を変更し、
   `scripts/verify-roadmap-artifact.sh` を通す。
5. 記録を `docs/tasks/supervision-log.jsonl` へ 1 行追記し、下の検証を通す。
6. `MEMORY.md` を更新し、commit して `HEAD:main` へ push し、fetch 後に ancestry を確認する。

**研究 tick の作業（本文の定義・主張・定理を進めること）をこの監督で行わない。**
方向の評価と、その結果としての段取りの変更だけを行う。研究の一層を進めたくなったら、
それは次の探索への接続として記録へ書き、研究 tick へ渡す。

## 検証

```sh
node cellular-automata-statistical-mechanics/scripts/verify-supervision-log.ts
node cellular-automata-statistical-mechanics/scripts/verify-supervision-log-test.ts
bash cellular-automata-statistical-mechanics/scripts/verify-cellular-automata-supervisor-tick.sh
bash cellular-automata-statistical-mechanics/scripts/verify-roadmap-artifact.sh   # 段取りを変えた回だけ
```

`verify-cellular-automata-supervisor-tick.sh --installed` は、上に加えて
**launchd への設置が宣言と一致していること**まで確かめる。設置の直後と、
設置が生きているかを疑ったときに使う。

## 止まってよい場合

- 段取りの変更が、README の三つの問いのいずれかを射程から落とす形になる。
- `docs/context/` またはマニフェストの変更が必要になった。
- 未許可の不可逆操作、課金、ユーザー固有の価値判断が必要になった。

`逸脱` の検出、`要変更` の判定、インサイトが無いこと、研究 tick の停滞は、いずれも停止理由ではない。
記録して次へ渡す。

## 起動

- launchd ラベル: `com.masaori.cellular-automata-research-supervision`
- 起動口: `~/.local/bin/cellular-automata-supervision-launcher.sh`
- tick 本体: `cellular-automata-statistical-mechanics/scripts/supervisor-tick.sh`
- 発火: 6 時間ごと（2 時 52 分、8 時 52 分、14 時 52 分、20 時 52 分）
- 専用 worktree: `<repo>/.codex/worktrees/tick/cellular-automata-research-supervision`
  （研究 tick の worktree とは別。同じ worktree を共有すると、監督が研究 tick の
  未コミット成果を巻き込むか、互いのロックで見送り合う）
- ログ: `~/Library/Logs/cellular-automata-research-supervision/supervision.log`

### tick のモデルと利用上限

監督も研究 tick と同じ `gpt-6-astra`、reasoning `medium` に統一する。
正規起動口が起動前に選んだ `CODEX_HOME` を保持し、未設定・空なら起動前に失敗する。Claude は呼び出さない。
上限・認証失敗・モデル利用不可は非ゼロ終了として記録し、未コミット成果を保持する。
実行中の別モデル・別 CLI・別アカウントへの切り替えは行わない。次回の起動前の選定は正規起動口が行う。
認証失敗時は tick 窓口へ停止を依頼して正規の認証経路を復旧する。

### 頻度の根拠

研究 tick は毎時 12 分の 1 回で、1 回につき台帳へ 1 節を積む
（`~/Library/LaunchAgents/com.masaori.cellular-automata-auto-loop.plist` の
`StartCalendarInterval` と、`auto-loop-state.md` の節の実測）。6 時間ごとの監督は、
**毎回 5 回前後の研究 tick の成果を評価対象として持つ。** 方向の判定には複数回分の
積み重ねが要る（1 回分では、その tick が手段の改善だったのか問いへの前進だったのかを
区別できても、傾向としての逸脱は見えない）ため、研究 tick と同じ頻度にはしない。
逆にこれ以上まばらにすると、逸脱の検出が半日以上遅れ、その間の tick が全て同じ方向へ積まれる。

### launchd の実体は自分で触らない

`launchctl` と `~/Library/LaunchAgents/` の編集を、この監督から行ってはならない。
設置・頻度変更・停止・再開は、tmux セッション `local-pc-management` のウィンドウ `tick窓口` へ
依頼する（`launchd-tick-loop` skill に従う）。**固定するのは頻度の値ではなく経路である。**
あるべき頻度の宣言は `local-pc-management/agent-sessions/config/tick-schedules.json` にあり、
実体との食い違いは日次の監査が検出する。

読み取りだけの調査は自由。

```sh
bash ~/.local/bin/cellular-automata-supervision-launcher.sh   # 手で 1 回まわす（launchd を触らない）
launchctl print "gui/$(id -u)/com.masaori.cellular-automata-research-supervision" | grep -E 'state =|last exit|calendar'
tail -50 ~/Library/Logs/cellular-automata-research-supervision/supervision.log
```
