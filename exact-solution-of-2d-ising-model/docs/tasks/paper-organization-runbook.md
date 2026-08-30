# 論文構成再編の継続 Runbook

## ゴールライン

複素行列版の本文にある全定義・主張・定理を一度フラットな依存グラフへ戻し、「高校生でも読める具体的な行列計算として積み上げる」という主題で、最終章を「数学的道具立て」「2次元イジングモデル」の二章だけにする。数学的道具立てを先に置き、そこからイジング固有語彙を除く。各章内を依存関係でトポロジカルソートし、依存境界から節を定め、各節の入力・出力・主定理を明示する。節末コラムは配置可能な境界だけを記録し、本文は作らない。

## 1 tick の一歩

1 tick は、分類境界または依存境界について相互レビュー可能な一単位だけを確定する。単位は、同じ依存境界を共有するブロック群、または一つの道具概念に属するブロック群とする。複数の独立した境界へ進まない。

## 毎回の手順

- `AGENTS.md`、`CLAUDE.md`、`docs/context/` 全文、プロジェクト README、この Runbook、状態台帳、`MEMORY.md` を読む。
- 120秒の上限付きで `origin` を fetch し、remote default branch は fetch 後のローカル `origin/HEAD` から取得する。専用worktreeが遅れていれば、未コミット成果を失わない方法で取り込む。通信処理の失敗時は別経路へ切り替えずエラーで終了し、共有main作業ツリー、lambda版、既存tickには触れない。
- `npm run inventory:organization` で機械可読棚卸しを再生成し、件数・依存ラベル・差分を確認する。
- 状態台帳の「次の一歩」だけを担当者が分析し、別のエージェントが、分類境界・依存方向・イジング固有セマンティクス混入・二章制約・高校生可読性をレビューする。指摘があれば同じ単位を修正して再レビューし、未解決のまま次へ進まない。
- 必要な検証を全て通し、状態台帳と `MEMORY.md` を更新する。コミット後は、launchd由来のtmux外実行でkeyringを必要とする `gh` を使わず、SSHのGitで成果コミットをremote defaultへ直接pushし、fetch後の包含確認までを同じtickで行う。non-fast-forward時は同じGit経路でremote defaultを取り込み、再検証してからpushする。

## 分類規則

- 「数学的道具立て」は、2次元イジング模型を一切参照せずに定義・主張できる複素数・複素行列の道具を含む。参照回数は分類条件にしない。
- 記号の由来がスピン、格子、転送行列、セクター、運動量、フェルミオン等に依存するなら「2次元イジングモデル」に置く。一般化できそうという印象だけで道具章へ移さない。
- 道具章の対象にイジング固有名が残る場合は、証明が実際に使う複素行列の構造へ名前と statement を直せるかレビューする。意味を変える修正は一単位として独立に扱う。
- 人手本文は複素数と具体的複素行列に固定する。必要十分な抽象化は Lean の中だけに置く。
- 可算／非可算、および実数解析への脱出の有無を章・節境界へ使わない。解析や極限は必要な入力として説明し、具体的な行列計算を高校生が依存順に追えるかで説明粒度を判定する。

## 節境界の規則

分類確定後、ラベル参照を有向辺として章ごとにトポロジカルソートする。外部入力集合が変わる点、または一つの主定理へ収束した依存群が閉じる点を節境界候補にする。各節には入力、出力、主定理を名前で記し、番号は付けない。

## 継続実行の資産

- 状態: `docs/tasks/paper-organization-state.md`
- 棚卸し: `docs/organization/flat-inventory.json`
- 棚卸し生成器: `structured-latex/tools/build-flat-inventory.ts`
- tick本体: `scripts/paper-organization-tick.sh`
- local-pc-management が配布する起動口: `/Users/masaori/.local/bin/math-complex-matrix-ising-paper-organization-loop-launcher.sh`
- 推奨 launchd label: `com.masaori.math-complex-matrix-ising-paper-organization-loop`
- 推奨頻度: 2時間ごと。分は既存tickとの衝突を窓口が監査して決める。tickの強制終了上限55分に対して次回起動まで重ならず、失敗・打ち切り・残骸をログで識別できる間隔として採る。
- 専用worktree: `/Users/masaori/git/masaori/math-complex-matrix-ising-paper-loop`
- 専用branch: `goal/complex-matrix-ising-paper-organization-loop`
- lock/log: `~/Library/Logs/math-complex-matrix-ising-paper-organization/`
