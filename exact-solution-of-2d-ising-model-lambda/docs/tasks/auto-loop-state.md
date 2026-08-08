# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（30 分おき。毎時 23 分と 53 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- 次に進めるセクション: **分配多項式 / 分配多項式の係数表示の Lean 形式化**（台帳の todo の先頭）
- 前回のレビュー到達点: 本文（定義 4 件・主張 1 件）とその Step 1–5 のラベル参照、`sagemath/`、
  `notes/`、`README`・`MEMORY`・`overview.md`、`lean/` の README と検査スクリプトを一巡した。
  次 tick は、この tick で書いた Lean のファイル 4 件が人手証明と 1 対 1 に対応しているか
  （具体版が一般論へ丸投げしていないか、必要十分版の仮定に使っていない構造が残っていないか）を
  読み直すところから始める。
- 最終更新: 2026-08-08（tick 3 実行）

## セクション台帳

状態は `todo` / `記述まで` / `記述と SageMath まで` / `done`（＝四層すべて）のいずれか。
**Lean が未了なら `done` にしない。**

| # | 章 | セクション | 状態 | 備考 |
|---|---|---|---|---|
| 1 | 分配多項式 | 格子・配位・破れボンド数・多重度・分配多項式の定義 | 記述と SageMath まで | 定義は Lean へ写した（`PartitionPolynomial/Basic.lean`）。係数表示 $Z_L=\sum_m\Omega_L(m)x^m$ の等式が Lean 未証明なので `done` にしない |
| 2 | 分配多項式 | 多重度の総和は配位の総数に等しい | done | 2026-08-08 完了。四層すべて（記述・SageMath・Lean 具体版・Lean 必要十分版） |
| 3 | 形式検証の土台 | Lean の環境を整える（`lake update` と `lake build` が通る状態にする） | done | 2026-08-08 完了。`lake update` → `lake exe cache get`（8639 ファイル取得）→ `lake build` が通り、`check-no-sorry.sh` も通る。mathlib の実体は `lake-manifest.json` で固定し追跡している。`import Mathlib.Data.Finset.Card` が引けることも確認した |
| 4 | 分配多項式 | 主張「多重度の総和は配位の総数に等しい」の Lean 具体版と必要十分版 | done | 2026-08-08 完了。`lake build` と `check-no-sorry.sh` が通り、検査対象に定理 3 件を登録した |
| 4b | 分配多項式 | 分配多項式の係数表示 $Z_L=\sum_m\Omega_L(m)x^m$ の Lean 具体版と必要十分版 | todo | セクション 4 から分けた。これが済めばセクション 1 が `done` になる |
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

## 前進の記録

- 2026-08-08（tick 3）: 主張「多重度の総和は配位の総数に等しい」を Lean で形式化した。
  具体版は人手証明の Step 1–5 と 1 対 1（Step 2 の「各配位がちょうど 1 つの類に属すること」は
  被覆と互いに素性を自分で示し、Step 3 の数え上げだけ mathlib の `Finset.card_biUnion` を引く。
  Step 2 と Step 3 をまとめてしまう `Finset.card_eq_sum_card_fiberwise` は使っていない）。
  必要十分版は、この証明が実際に使っているのが「配位の集合が有限」「破れボンド数が
  $2L^2$ 以下の自然数を返す写像」の 2 つだけであることを示した（格子の形・周期境界条件・
  スピンの値が $\pm1$ であることは使っていない）。具体版がその特殊化として得られることを
  導出ファイルで明示した。あわせて定義 4 件も Lean へ写し、人手証明の各ブロックの `lean`
  フィールドへ Lean 側の名前を書いた。

## レビュー記録

各 tick のレビューで**何をなぜ直したか**を 1 行ずつ追記する。直すものが無かった tick も
「見た範囲」と「問題なし」を残す（見ていないのに見たことにしない）。

- 2026-08-08（tick 4 のレビュー、前 tick で書いた Lean 4 ファイル
  `PartitionPolynomial/Basic.lean`・`PartitionPolynomial/CoefficientSum.lean`・
  `NecSuf/PartitionPolynomial/CoefficientSum.lean`・`PartitionPolynomial/CoefficientSumFromNecSuf.lean`）:
  人手証明との 1 対 1 対応を辺の番号付け（0 始まりへの読み替え）・端点写像の向き・Step 1–5 の
  対応まで突き合わせたが、誤りは無かった。具体版は Step 2 を自分で示しており一般論へ丸投げしていない。
  必要十分版の仮定 3 つ（有限性・相等の決定可能性・有界性）はいずれも削ると証明が通らないので残ってよい。
  本文の `lean` フィールドが挙げる 13 個の名前が実際に Lean 側に存在することも確かめた。
  代わりに SageMath 側に欠陥を 1 件見つけて直した。`_shared/defs.sage` の `partition_polynomial(L)` が
  分配多項式を多重度ベクトルから作っていた。本文の定義は $Z_L=\sum_\sigma x^{b(\sigma)}$（配位ごとの
  単項式の和）なので、これは定義ではなく係数表示の方を実装していたことになる。この作り方だと
  係数表示 $Z_L=\sum_m\Omega_L(m)x^m$ が構成から自明になり、係数表示の検証が空になる。
  定義どおり配位ごとに足し上げる実装へ直し、多重度から作る側を別関数
  `partition_polynomial_from_multiplicity(L)` として分けた。再実行して $L=1,2,3$ の結果は変わらない。
- 2026-08-08（tick 3 のレビュー、主張「多重度の総和は配位の総数に等しい」の証明 Step 1–5 の
  ラベル参照と、`lean/README.md`・`lean/scripts/check-no-sorry.sh`・`lean/Ising2DLambda.lean`）:
  証明の各ステップは根拠のラベル参照（多重度の定義・破れボンド数の定義・格子と配位の定義）が
  過不足なく付いており、数学の記述に誤りは無かった。Step 3 で使う「互いに素な有限集合の合併の
  個数は個数の和」は高校教科書レベルなので参照無しでよいと判断した。
  代わりに `lean/README.md` の記述が事実と食い違っていたので直した。1 tick の長さを 50 分と
  書いていたが、自動ループは 30 分間隔・1 tick 25 分打ち切りへ変更済みである
  （mathlib のビルド済みファイル取得を省略できない理由の説明に使われている数値なので、
  古いままだと判断を誤らせる）。
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
- 実体: `exact-solution-of-2d-ising-model-lambda/scripts/auto-loop-tick.sh`（毎時 23 分と 53 分。25 分で打ち切る）
- ログ: `exact-solution-of-2d-ising-model-lambda/logs/auto-loop.log`（git 管理外）
- 各 tick は `claude -p` で**独立した新しいセッション**として走る（文脈を持ち越さない。
  持ち越すのはこの台帳とリポジトリの中身だけ）。

停止するには `launchctl bootout gui/$(id -u)/com.masaori.ising-lambda-auto-loop`。
再開するには `launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`。
