# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-15 の tick 274 は、「開境界長方形の接合不等式」の実数評価の上下評価を Lean 化し、
  claim の具体版・必要十分版・導出を完成させてセクションを閉じた。レビューでは前 tick の
  接合面分解の Lean と本文が一致しており、修正は無い。** 具体版は、値の定義と正値性、
  底が一以下・一以上の各場合の自然数冪の順序（指数についての帰納法）、全単射と三項分解による
  二重和への書き換え、項ごとの評価の有限和、有限和の分配則を人手証明と同じ順で辿り、
  第一・第二の座標方向の各二場合の四定理を得た。必要十分版は格子・配位・実数を外し、
  対との全単射・指数の三項分解・接合面因子の項ごとの評価・可換半環の順序だけを残した
  （全順序・減法は不要と判明）。本文の二ブロックへ `lean` 宣言を付けた（sorry 検査 994 件、
  すべて非依存）。式変形統一は締切のため今 tick は見送った（次 tick で 2 件分は行わず、
  通常どおり 1 件進める）。次の本文は「周期境界と開境界の境界評価」。

- **2026-08-15 の tick 273 は、「接合不等式・破れボンド数の接合面分解」の Lean 具体版を
  完成させた。レビューでは前 tick の接合写像と本文の制限・接合、入口 import、sorry 検査の
  登録が一致しており、修正は無い。** 第一座標方向では接合後の辺集合と「左側・右側・接合面」
  の直和との全単射を構成し、接合面の破れ辺数が $b$ 以下であることと破れボンド数の三項分解を
  示した。第二座標方向は座標交換で同じ全単射へ帰着し、接合面の破れ辺数が $a$ 以下であることと
  三項分解を得た（sorry 検査 984 件、すべて非依存）。claim 本体の Lean は未了なので本文の
  `lean` 宣言はまだ付けない。次は実数評価の上下評価を Lean 化し、具体版・必要十分版・導出を
  閉じる。式変形統一では姉妹側「指数行列による共役の交換子級数展開」の三つの計算を、
  一続きの等号と行末根拠へ揃えた。

- **2026-08-15 の tick 272 は、「開境界長方形の接合不等式」の Lean を論法ごとに三つへ割り直し、
  先頭の「接合の全単射」の Lean 具体版（`OpenRectangleGluing.lean`）を完成させた。
  レビューでは前 tick の接合不等式の本文と SageMath が一致しており、修正は無い。**
  第一・第二の座標方向について、左右（下上）への制限と接合を人手証明と 1 対 1 に写し、
  「二つの構成を順に行うと各頂点で元の値に戻る」を戻りの等式六補題として示し、二つの全単射
  `openConfigGlueEquivFirst/Second` を得た（sorry 検査 978 件、すべて非依存）。残りは
  破れボンド数の接合面分解と、実数評価の上下評価の Lean。式変形統一では姉妹側
  「テイラー係数の抽出」の (h1.y)(h2.z)(h2.y) の三鎖を、(h1.z) と同じ粒度
  （場合分け形の行と「和の外へ出す」行を持つ一行一等号）へ開いた。

- **2026-08-15 の tick 271 は、「開境界長方形の接合不等式」を記述と SageMath まで進めた。
  レビューでは前 tick の五定義の本文・SageMath・Lean が一致しており、修正は無い。**
  第一・第二の座標方向の接合について、配位の制限と接合の全単射、破れボンド数の接合面分解を示し、
  $0<t\le1$ と $1\le t$ の二場合で接合前の分配多項式の積を挟む不等式を得た。SageMath は
  $\mathbb{Q}_{>0}$ 上で両方向 80 組を厳密検査した。Lean は未着手。式変形統一では姉妹側
  「$\check Z,\check Y$ についての $\cosh,\sinh$ の展開係数への変換」の二補題に残っていた
  圧縮鎖を、一行一等号と行末根拠へ開いた。次 tick は接合不等式の Lean を進める。

- **2026-08-15 の tick 270 は、「開境界長方形の分配多項式」の五定義の Lean 具体版
  （`OpenRectangle.lean`）を完成させ、セクションを完了した。レビューでは前 tick の
  五定義と SageMath が一致しており、修正は無い。** 頂点・辺と端点写像・配位・破れボンド数・
  分配多項式を人手証明と 1 対 1 に写し、数え上げ補題 4 件（頂点数 $ab$、辺数
  $a(b-1)+(a-1)b$、配位数 $2^{ab}$、破れボンド数の上界）を sorry 検査へ登録した
  （972 件、すべて sorryAx 非依存）。定義ブロックには主張が無いので、必要十分版・導出は
  付けない（周期境界の定義 4 件と同じ扱い。tick 3 の前例）。式変形統一では姉妹側
  「$\check Z,\check Y$ についての $n$ 重交換子」の八つの帰納法の鎖へ、先頭行（定義と
  帰納法の仮定の代入）と最終行（スカラー倍の交換）の行末根拠を補い、二重等号の行を
  一行一等号へ開いた。次の本文は「開境界長方形の接合不等式」。

（これより古い 229 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## セクション台帳

**済んだ範囲**（章ごとの件数。個々の内訳は [auto-loop-archive.md](auto-loop-archive.md) と
MEMORY.md にある。番号で呼ばないので、ここでは章と件数だけを持つ）。

- 固有値の代数性: 128 セクション
- Fisher 零点: 44 セクション
- 分配多項式: 4 セクション
- 転送行列: 4 セクション
- 有限系の自由エントロピー: 5 セクション
- 形式検証の土台: 1 セクション
- 零点の詰め寄り: 5 セクション
- 熱力学極限: 12 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 周期境界と開境界の境界評価 | todo | 境界を横切る辺は $2L$ 本 |
| 熱力学極限 | 自由エネルギー密度の極限の存在 | todo | 接合不等式と境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-15（tick 274）: `ThermodynamicLimit/OpenRectangleGluingInequality.lean` に、値
  `openPartitionValue` と正値性 `openPartitionValue_pos`、一以下の底の冪の順序二補題、
  二重和への書き換え二補題（`openPartitionValue_glueFirst_eq/glueSecond_eq`）、積の二重和への
  展開（`openPartitionValue_mul_eq_double_sum`）、四定理
  `openPartitionValue_glueFirst/glueSecond_bounds_of_le_one/of_one_le` を実装した。必要十分版
  `NecSuf/ThermodynamicLimit/OpenRectangleGluingInequality.lean`（`sum_pow_glue_bounds_necSuf`。
  可換半環の順序だけを残し、全順序・減法が不要と判明）と導出四定理を書き、本文の
  `def_open_rectangle_partition_value`・`claim_open_rectangle_gluing_inequality` へ `lean`
  宣言を付けた（sorry 検査 994 件、すべて非依存）。「開境界長方形の接合不等式」を
  セクション完了にした。

- 2026-08-15（tick 273）: `ThermodynamicLimit/OpenRectangleGluing.lean` に、第一座標方向の
  接合後の辺と「左側・右側・接合面」の直和との全単射 `openEdgeJoinEquivFirst`、接合面の
  破れ辺数 `openSeamBrokenCountFirst` と上界、三項分解 `openBrokenBondCount_glueFirst` を
  実装した。座標交換 `openConfigTranspose`・`openEdgeTranspose` で第二座標方向へ移し、
  `openSeamBrokenCountSecond` と `openBrokenBondCount_glueSecond` まで示した。主要定理を
  sorry 検査へ登録した（984 件、すべて非依存）。claim 本体は次の実数評価の上下評価で閉じるため、
  本文の `lean` 宣言はまだ付けない。式変形統一では姉妹側「指数行列による共役の交換子級数展開」
  の級数展開・反復交換子・共役写像の三計算を、一続きの等号と行末根拠へ揃えた。

- 2026-08-15（tick 272）: 「開境界長方形の接合不等式」の Lean を論法ごとに
  「接合の全単射」「破れボンド数の接合面分解」「実数評価の上下評価」の三つへ割り直した
  （一 tick で閉じる大きさにするため）。先頭の「接合の全単射」の具体版
  `ThermodynamicLimit/OpenRectangleGluing.lean` を完成させた。第一・第二の座標方向の
  制限（`openConfigSplitFirstLeft/Right`・`openConfigSplitSecondBottom/Top`）と接合
  （`openConfigGlueFirst/Second`）を人手証明と 1 対 1 に写し、戻りの等式六補題と全単射
  `openConfigGlueEquivFirst/Second` を sorry 検査へ登録した（978 件、すべて非依存）。
  claim 本体の Lean は未了なので本文ブロックへの `lean` 宣言はまだ付けない。式変形統一では
  姉妹側「テイラー係数の抽出」の (h1.y)(h2.z)(h2.y) の三鎖を (h1.z) と同じ粒度へ開いた。

- 2026-08-15（tick 271）: `def_open_rectangle_partition_value` と
  `claim_open_rectangle_gluing_inequality` を記述した。第一・第二の座標方向について、接合後の
  配位と二つの配位の組との全単射、破れボンド数の「二つの内部＋接合面」への分解を置き、接合面の
  破れ辺数の範囲から $0<t\le1$ と $1\le t$ の二場合の上下評価を導いた。SageMath
  （`sagemath/check/open-rectangle-gluing-inequality/`）は $a,b,c\in\{1,2\}$ と正の有理点
  5 点で両方向 80 組を厳密検査した。Lean は未着手。式変形統一では姉妹側
  「$\check Z,\check Y$ についての $\cosh,\sinh$ の展開係数への変換」の生成子のスカラー倍と
  虚数単位の冪の圧縮鎖を、行末根拠付きの一続きへ開いた。

- 2026-08-15（tick 270）: 「開境界長方形の分配多項式」の Lean 具体版
  `ThermodynamicLimit/OpenRectangle.lean` を完成させ、セクションを完了した。五定義
  （`OpenVertex`・`OpenEdgeH/V/OpenEdge` と端点写像・`OpenConfig`・
  `openBrokenBondSet/Count`・`openPartitionPolynomial`）を人手証明と 1 対 1 に写し、
  数え上げ補題 4 件（`card_openVertex`・`card_openEdge`・`card_openConfig`・
  `openBrokenBondCount_le`）を sorry 検査へ登録した。定義ブロックには主張が無いので
  必要十分版・導出は付けない（周期境界の定義 4 件と同じ扱い。tick 3 の前例）。本文の
  五ブロックへ `lean` 宣言を付け、「この先に書くこと」から Lean 検証の項目を消した。
  式変形統一では姉妹側「$\check Z,\check Y$ についての $n$ 重交換子」の八つの鎖へ
  行末根拠を補った。

（これより古い 240 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録

- 2026-08-15（tick 274）: 前 tick の `OpenRectangleGluing.lean` の接合面分解
  （辺の三分割の全単射・接合面の破れ辺数と上界・三項分解・座標交換による第二方向への帰着）を
  本文の証明と突き合わせた。接合面の辺の位置（第一座標 $a-1$ と $a$ の間）、上界 $b$・$a$、
  分解の三項の並びが一致し、入口 import と sorry 非依存検査への登録も揃っているため、修正は無い。

- 2026-08-15（tick 273）: 前 tick の `OpenRectangleGluing.lean` を本文の第一・第二座標方向の
  制限・接合と突き合わせた。各頂点での左右（下上）の添字、六つの戻りの等式、二つの全単射が
  一致し、入口 import と sorry 非依存検査への登録も揃っているため、修正は無い。

- 2026-08-15（tick 272）: 前 tick の「開境界長方形の接合不等式」の本文（評価の定義・主張・
  全単射・接合面分解・二場合の評価）と SageMath（80 組）を突き合わせた。接合写像・接合面の
  破れ辺数の定義と範囲、破れボンド数の分解、$0<t\le1$ と $1\le t$ の上下評価が一致しており、
  修正は無い。

- 2026-08-15（tick 271）: 前 tick の「開境界長方形の分配多項式」の五定義について、本文・
  SageMath・Lean 具体版を突き合わせた。頂点の上界条件、向き付き直和としての辺、端点写像、
  破れボンド集合と個数、$\mathbb{Z}[x]$ の有限和、および数え上げ補題 4 件が同じ定義を使い、
  本文の Lean 宣言・入口 import・sorry 非依存検査も揃っているため、修正は無い。

- 2026-08-15（tick 270）: 前 tick の「開境界長方形の分配多項式」の五定義の本文と SageMath
  （108 件）を突き合わせた。頂点・辺の条件（$j+1<b$・$i+1<a$）、向きの印を付けた直和、
  端点写像、破れボンド数、$\mathbb{Z}[x]$ の分配多項式の定義が一致し、住処の宣言
  （N と Z）も実態どおりのため、修正は無い。

（これより古い 261 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## 判断待ち（人間に問うべき論点）

- **content のファイルを分けるときの文書順の決め方。** システムは `content/` のファイル名昇順を
  文書順とみなすが、リポジトリの規約はファイル名の連番を禁じている。
  2026-08-08（tick 5）に 2 つめの章を書くときこれに当たった。連番は振らず、章ごとにファイルを
  分けることもせず、**本文を 1 ファイル `content/main-text.ts` へまとめて章を見出しブロックで
  区切る**形にした（ファイルが 1 つなら配列順がそのまま文書順になり、論点に当たらないため。
  旧ファイル名 `partition-polynomial.ts` は 1 章分しか指さないので改名した）。
  これは論点の解決ではなく回避である。本文が育ってファイルを分けたくなった時点で決着が要る。
  → **決着の案（人間の判断を待つ）**: システム側（リポジトリ直下 `structured-latex/`）に
  文書順の明示的な宣言（例えば `content/order.ts` にファイル名を並べる）を入れ、
  ファイル名昇順という暗黙の規則をやめる。この変更はシステム側の入力言語に触るため、
  他プロジェクト（`exact-solution-of-2d-ising-model/` 等）にも影響する。

## cron（launchd）

- ラベル: `com.masaori.ising-lambda-auto-loop`
- 定義: `~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`
- 実体: `scripts/auto-loop-tick.sh`（毎時 5 分、見送られたときの再試行が 35 分。45 分で打ち切る）
- ログ: `logs/auto-loop.log`（git 管理外）
- 各 tick は**独立した新しいセッション**として走る（文脈を持ち越さない。持ち越すのは
  この台帳とリポジトリの中身だけ）。使うエージェントは **Claude と Codex の交互**
  （Claude は `claude-fable-5` の effort medium、Codex は `gpt-5.6-sol` の reasoning medium）。
  片方が使用量の上限に当たった間は、期限を `logs/claude-blocked-until` へ記録してもう片方だけで回す。
- 監査は別ジョブ（毎時 55 分の軽い監査 `scripts/audit-light.sh`、毎日 04:20 の重い監査
  `scripts/audit-loop.sh`）。PDF は `scripts/refresh-pdf.sh` が 5 分おきに最新へ保つ。

停止するには `launchctl bootout gui/$(id -u)/com.masaori.ising-lambda-auto-loop`。
再開するには `launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`。
