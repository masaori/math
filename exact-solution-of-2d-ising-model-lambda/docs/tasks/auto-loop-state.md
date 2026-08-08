# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 23 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- 次に進めるセクション: **形式検証の土台 / Lean の環境を整える**（台帳の todo の先頭）
- 前回のレビュー到達点: 本文（定義 4 件・主張 1 件）、`sagemath/`、`notes/`、`README`・`MEMORY`・
  `overview.md` を一巡した。次 tick は本文の証明の各ステップに根拠のラベル参照が過不足なく
  付いているかを、主張「多重度の総和は配位の総数に等しい」の Step 1–5 から見直す。
- 最終更新: 2026-08-08（tick 2 実行）

## セクション台帳

状態は `todo` / `記述まで` / `記述と SageMath まで` / `done`（＝四層すべて）のいずれか。
**Lean が未了なら `done` にしない。**

| # | 章 | セクション | 状態 | 備考 |
|---|---|---|---|---|
| 1 | 分配多項式 | 格子・配位・破れボンド数・多重度・分配多項式の定義 | 記述と SageMath まで | Lean 未着手 |
| 2 | 分配多項式 | 多重度の総和は配位の総数に等しい | 記述と SageMath まで | Lean 未着手 |
| 3 | 形式検証の土台 | Lean の環境を整える（`lake update` と `lake build` が通る状態にする） | todo | mathlib 未取得。**`lake update` のあと必ず `lake exe cache get` を実行する**（省くと mathlib を原本から building することになり、1 tick では終わらない）。前面で実行し終わるまで待つこと |
| 4 | 分配多項式 | 上記 2 件の Lean 具体版と必要十分版 | todo | 完了したら 1・2 を `done` にする |
| 5 | 有限系の自由エントロピー | 有理点での評価と素因数分解、$\Phi_L\in\Lambda$ の定義 | todo | SageMath 側に $Z_L(1/2)$ の素因数分解が既にある |
| 6 | 有限系の自由エントロピー | $\Phi_L$ の基本性質（この tick で何を示すかは台帳へ書いてから着手する） | todo | |
| 7 | 転送行列 | 行配位と、破れボンド数の行内・行間への分解 | todo | 辺の番号を横向き・縦向きに分けてあるのでそのまま使える |
| 8 | 転送行列 | $T\in M_{2^L}(\mathbb{Z}[x])$ の定義と $Z_L=\operatorname{Tr}T^L$ | todo | 指数形を経由しない |
| 9 | 固有値の代数性 | 特性多項式が $\mathbb{Z}[x][\lambda]$ に属すること | todo | |
| 10 | 固有値の代数性 | 円分体上での対角化（解析関数としての $\cos$ を使わない） | todo | |
| 11 | Fisher 零点 | 零点が $\overline{\mathbb{Q}}$ に属すること、Kramers–Wannier 双対 | todo | |
| 12 | Fisher 零点 | 自己双対点 $x_c=\sqrt2-1$ | todo | |
| 13 | 零点の詰め寄り | 相転移を $\mathbb{Q}$ 上の量化言明として書く | todo | |
| 14 | 熱力学極限 | 自由エネルギー密度・零点密度（**ここが $\mathbb{R}$ 脱出**） | todo | `realEscape` を具体的に書く |
| 15 | 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

セクションを細かく割り直してよい。割り直したらこの表を更新し、理由を「レビュー記録」へ書く。

## レビュー記録

各 tick のレビューで**何をなぜ直したか**を 1 行ずつ追記する。直すものが無かった tick も
「見た範囲」と「問題なし」を残す（見ていないのに見たことにしない）。

- 2026-08-08（tick 2 のレビュー、`notes/partition-polynomial.ts` と `README.md`・`MEMORY.md`・
  `overview.md` の記述が現行の定義と合っているか）: 数学の記述に誤りは無かった。
  ノートの 4 サイクルの数え上げ（多重度 2, 12, 2、$Z_{C_4}(1/2)=2^{-3}\cdot41$）と
  格子 $L=2,3$ の分配多項式は、SageMath で厳密計算して一致を確認した。
  代わりに自動ループの起動スクリプトの欠陥を 1 件見つけて直した。launchd 用に固定していた PATH に
  node（nvm 配下）と lake（elan 配下）が入っておらず、tick の中では `npm run check` も
  `npm run build:pdf` も `lake build` も起動できない状態だった（この tick で実際に
  「npm が見つからない」が出た）。既定バージョンを見て nvm と elan の実行パスを足すようにした。
- 2026-08-08（tick 1 のレビュー、`content/partition-polynomial.ts` の先頭から定義 4 件と主張 1 件、
  および対応する `sagemath/_shared/defs.sage` と検証まで）: 「横向き」と名付けた辺の端点写像が
  行番号をずらしており、名前と実体が食い違っていた（同じ章の中で「後の章で行内・行間に分ける」と
  書いているので、そのままでは後続が破綻する）。頂点 $(i,j)$ の第 1 成分を行番号・第 2 成分を列番号と
  本文で宣言し、横向きの辺が列番号だけを 1 進めるように端点写像を入れ替えた。SageMath 側の
  端点の定義と検証のアサーションも同じ向きへ直し、再実行して $L=1,2,3$ で結果が変わらないことを確認した。
- 2026-08-08（同レビュー）: `overview.md` と `MEMORY.md` に、既に廃止した辺集合の定義
  （頂点との直積 $V_L\times\{\mathrm{h},\mathrm{v}\}$）が現行の定義として残っていたので、
  番号の集合による現行の定義へ直し、定義を変えた経緯を `overview.md` の記録へ追記した。
- 2026-08-08: 雛形作成時に、辺の集合の定義を 2 元集合の集合 → 番号の集合（横向き・縦向きに分割）へ
  2 度直した。破れボンド数の関数名と多重度の添字が同じ記号だったのを分けた。
  写像全体の集合の冪記法をやめた。多項式とその値の区別を本文で約束した。

## 判断待ち（人間に問うべき論点）

- **content のファイルを分けるときの文書順の決め方。** システムは `content/` のファイル名昇順を
  文書順とみなすが、リポジトリの規約はファイル名の連番を禁じている。いまは 1 ファイルなので
  衝突していない。章を増やす前に決める必要がある（システム側に順序宣言を入れるのが筋）。
  → **この論点に当たったら、勝手に連番を振らず、報告して止まる。**

## cron（launchd）

- ラベル: `com.masaori.ising-lambda-auto-loop`
- 定義: `~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`
- 実体: `exact-solution-of-2d-ising-model-lambda/scripts/auto-loop-tick.sh`（毎時 23 分）
- ログ: `exact-solution-of-2d-ising-model-lambda/logs/auto-loop.log`（git 管理外）
- 各 tick は `claude -p` で**独立した新しいセッション**として走る（文脈を持ち越さない。
  持ち越すのはこの台帳とリポジトリの中身だけ）。

停止するには `launchctl bootout gui/$(id -u)/com.masaori.ising-lambda-auto-loop`。
再開するには `launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`。
