# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-15 の tick 277 は、「周期境界と開境界の境界評価」の
  「破れボンド数の分解」の Lean 具体版を完成させた。レビューでは前 tick の
  頂点対応と配位の全単射が本文の往復写像と一致し、修正は無い。**
  周期境界の辺を行・列座標付きの横向き・縦向き辺へ開き、それを
  開境界正方形の辺と各向き `L` 本の境界横断辺の直和へ分ける全単射を構成した。
  各部分で辺が破れる条件を端点写像に沿って照合し、境界横断辺の破れ本数が
  `2L` 以下であることと `b(r_L(τ))=b^op(τ)+s^bd_L(τ)` を得た。claim 本体の
  Lean は未了なので本文の `lean` 宣言はまだ付けない。式変形統一では姉妹側
  「ad_X と Ad_g の定義」中の逆行列の一意性を示す五等号の圧縮鎖を、
  一行一等号と行末根拠へ開いた。次はこの境界評価の「実数評価の上下評価」の Lean。

- **2026-08-15 の tick 276 は、「周期境界と開境界の境界評価」の Lean を論法ごとに
  「配位の全単射」「破れボンド数の分解」「実数評価の上下評価」の三つへ割り、先頭の
  「配位の全単射」の Lean 具体版を完成させた。レビューでは前 tick の証明に残っていた
  無名の同一視（周期境界と開境界の配位を同じ文字で使い回す書き方）を、頂点対応 $v_L$ と
  配位の全単射 $r_L$ の定義へ書き直し、前進前に main へ反映した。**
  具体版 `ThermodynamicLimit/PeriodicOpenComparison.lean` は、代表を取る写像と自然な射影の
  往復の等式二本から頂点の全単射を作り、配位の読み替え $r_L(\tau)=\tau\circ v_L$ の全単射を
  人手証明と 1 対 1 に写した（sorry 検査 1000 件、すべて非依存）。claim 本体の Lean は未了
  なので本文の `lean` 宣言はまだ付けない。式変形統一では姉妹側「Frobenius 内積の性質」の
  場合 1 の $u=0_{\mathbb{C}}$ と Step 6 の $u+\overline{u}$ に残っていた行内の等号鎖を、
  一行一等号と行末根拠へ開いた。次はこの境界評価の「破れボンド数の分解」の Lean。

- **2026-08-15 の tick 275 は、「周期境界と開境界の境界評価」を本文と SageMath まで進めた。
  周期境界にだけある $2L$ 本の辺による破れボンド数の差から、二つの分配値を挟んだ。**
  本文は配位の全単射、境界横断辺の破れ本数 $0\le s_L^{\mathrm{bd}}\le2L$、
  $b=b^{\mathrm{op}}+s_L^{\mathrm{bd}}$、自然数冪の順序、有限和の順に上下評価を導いた。
  SageMath は $L\in\{1,2,3\}$ と正の有理点 5 点の 15 組を厳密検査した。Lean は未着手。
  レビューでは前 tick の SageMath 概要に残っていた「Lean は次 tick」という古い記述を、
  具体版・必要十分版・導出版が完成済みという実態へ直し、前進前に main へ反映した。
  式変形統一では姉妹側「Frobenius 内積の性質」の Cauchy--Schwarz から三角不等式を導く計算に
  残っていた複数等号・複数不等号を、一行一関係と行末根拠へ開いた。次はこの境界評価の Lean。

- **2026-08-15 の tick 274 は、「開境界長方形の接合不等式」の実数評価の上下評価を Lean 化し、
  claim の具体版・必要十分版・導出を完成させてセクションを閉じた。レビューでは前 tick の
  接合面分解の Lean と本文が一致しており、修正は無い。** 具体版は、値の定義と正値性、
  底が一以下・一以上の各場合の自然数冪の順序（指数についての帰納法）、全単射と三項分解による
  二重和への書き換え、項ごとの評価の有限和、有限和の分配則を人手証明と同じ順で辿り、
  第一・第二の座標方向の各二場合の四定理を得た。必要十分版は格子・配位・実数を外し、
  対との全単射・指数の三項分解・接合面因子の項ごとの評価・可換半環の順序だけを残した
  （全順序・減法は不要と判明）。本文の二ブロックへ `lean` 宣言を付けた（sorry 検査 994 件、
  すべて非依存）。式変形統一では姉妹側「Frobenius 内積の性質（Cauchy–Schwarz）」の証明の
  代入計算三鎖を一行一等号と行末根拠へ開いた。次の本文は「周期境界と開境界の境界評価」。

- **2026-08-15 の tick 273 は、「接合不等式・破れボンド数の接合面分解」の Lean 具体版を
  完成させた。レビューでは前 tick の接合写像と本文の制限・接合、入口 import、sorry 検査の
  登録が一致しており、修正は無い。** 第一座標方向では接合後の辺集合と「左側・右側・接合面」
  の直和との全単射を構成し、接合面の破れ辺数が $b$ 以下であることと破れボンド数の三項分解を
  示した。第二座標方向は座標交換で同じ全単射へ帰着し、接合面の破れ辺数が $a$ 以下であることと
  三項分解を得た（sorry 検査 984 件、すべて非依存）。claim 本体の Lean は未了なので本文の
  `lean` 宣言はまだ付けない。次は実数評価の上下評価を Lean 化し、具体版・必要十分版・導出を
  閉じる。式変形統一では姉妹側「指数行列による共役の交換子級数展開」の三つの計算を、
  一続きの等号と行末根拠へ揃えた。

（これより古い 232 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
- 熱力学極限: 13 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 境界評価・実数評価の上下評価の Lean | todo | 具体版・必要十分版・導出。済んだら本文へ `lean` 宣言 |
| 熱力学極限 | 自由エネルギー密度の極限の存在 | todo | 接合不等式と境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-15（tick 277）: `ThermodynamicLimit/PeriodicOpenComparison.lean` に、周期辺を
  行・列座標付きの横・縦へ開く `periodicEdgeOrientedEquiv`、それを開境界辺と
  各向き `L` 本の境界横断辺の直和へ分ける `periodicOpenEdgeEquiv` を構成した。
  境界破れ本数 `periodicBoundaryBrokenCount` とその `2L` 上界、三種の辺ごとの
  端点条件の同値を示し、`brokenBondCount_openConfigToPeriodic` で人手証明と同じ
  有限和の並べ替えから破れボンド数の分解を得た。式変形統一では姉妹側
  「`ad_X` と `Ad_g` の定義」の逆行列の一意性の証明を一行一等号へ開いた。

- 2026-08-15（tick 276）: 「周期境界と開境界の境界評価」の Lean を論法ごとに
  「配位の全単射」「破れボンド数の分解」「実数評価の上下評価」の三つへ割り直した
  （一 tick で閉じる大きさにするため）。先頭の「配位の全単射」の具体版
  `ThermodynamicLimit/PeriodicOpenComparison.lean` を完成させた。頂点対応
  `periodicVertexToOpen`（$v_L$。代表を取る写像は `ZMod.val`、自然な射影は `Nat.cast`）と
  逆写像、往復の等式二本、配位の読み替え `openConfigToPeriodic`（$r_L$）と逆写像、往復の
  等式二本、全単射 `periodicOpenVertexEquiv`・`periodicOpenConfigEquiv` を人手証明と
  1 対 1 に写し、sorry 検査へ登録した（1000 件、すべて非依存）。式変形統一では姉妹側
  「Frobenius 内積の性質」の場合 1 と Step 6 に残っていた行内の等号鎖を、一行一等号と
  行末根拠へ開いた。

- 2026-08-15（tick 275）: `claim_periodic_open_boundary_comparison` を記述した。周期境界と
  開境界正方形の配位を、各剰余類の $0,\ldots,L-1$ の代表元で全単射にし、周期境界にだけある
  各向き $L$ 本ずつの境界横断辺の破れ本数 $s_L^{\mathrm{bd}}$ を定めた。
  $0\le s_L^{\mathrm{bd}}\le2L$ と $b=b^{\mathrm{op}}+s_L^{\mathrm{bd}}$ から、
  $0<t\le1$ と $1\le t$ の二場合で $Z_L(t)$ と $Z^{\mathrm{op}}_{L,L}(t)$ を
  $t^{2L}$ 倍までで挟んだ。SageMath は $L\in\{1,2,3\}$ と正の有理点 5 点の 15 組で、
  辺の分解・破れボンド数の加法・上下評価を厳密検査した。Lean は未着手なのでセクションは
  「記述と SageMath まで」のまま。式変形統一では姉妹側「Frobenius 内積の性質」の
  Cauchy--Schwarz から三角不等式を導く計算に残っていた圧縮鎖を、一行一関係と行末根拠へ開いた。

- 2026-08-15（tick 274）: `ThermodynamicLimit/OpenRectangleGluingInequality.lean` に、値
  `openPartitionValue` と正値性 `openPartitionValue_pos`、一以下の底の冪の順序二補題、
  二重和への書き換え二補題（`openPartitionValue_glueFirst_eq/glueSecond_eq`）、積の二重和への
  展開（`openPartitionValue_mul_eq_double_sum`）、四定理
  `openPartitionValue_glueFirst/glueSecond_bounds_of_le_one/of_one_le` を実装した。必要十分版
  `NecSuf/ThermodynamicLimit/OpenRectangleGluingInequality.lean`（`sum_pow_glue_bounds_necSuf`。
  可換半環の順序だけを残し、全順序・減法が不要と判明）と導出四定理を書き、本文の
  `def_open_rectangle_partition_value`・`claim_open_rectangle_gluing_inequality` へ `lean`
  宣言を付けた（sorry 検査 994 件、すべて非依存）。「開境界長方形の接合不等式」を
  セクション完了にした。式変形統一では姉妹側「Frobenius 内積の性質」の Cauchy–Schwarz の
  証明中、$t$ の代入計算の三鎖（1 行 2 等号で根拠なし）を一行一等号と行末根拠
  （代入・Step 0 の $\overline{u}u$・約分・$\iota_{\mathbb{R}\to\mathbb{C}}$ の保存）へ開いた。

- 2026-08-15（tick 273）: `ThermodynamicLimit/OpenRectangleGluing.lean` に、第一座標方向の
  接合後の辺と「左側・右側・接合面」の直和との全単射 `openEdgeJoinEquivFirst`、接合面の
  破れ辺数 `openSeamBrokenCountFirst` と上界、三項分解 `openBrokenBondCount_glueFirst` を
  実装した。座標交換 `openConfigTranspose`・`openEdgeTranspose` で第二座標方向へ移し、
  `openSeamBrokenCountSecond` と `openBrokenBondCount_glueSecond` まで示した。主要定理を
  sorry 検査へ登録した（984 件、すべて非依存）。claim 本体は次の実数評価の上下評価で閉じるため、
  本文の `lean` 宣言はまだ付けない。式変形統一では姉妹側「指数行列による共役の交換子級数展開」
  の級数展開・反復交換子・共役写像の三計算を、一続きの等号と行末根拠へ揃えた。

（これより古い 243 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

- 2026-08-15（tick 277）: 前 tick の `PeriodicOpenComparison.lean` にある頂点対応、
  自然な射影と代表を取る写像の往復、配位の読み替えの往復を本文の
  `v_L`・`r_L` と突き合わせた。定義域・値域・写像の向きが一致し、入口 import と
  sorry 非依存検査への登録も揃っているため、修正は無い。

- 2026-08-15（tick 276）: 前 tick の「周期境界と開境界の境界評価」の証明が、配位の全単射に
  名前を付けず、周期境界と開境界の配位を同じ文字 $\sigma$ で使い回していたため
  （README「構造を『同一視』で済ませない」に反する）、頂点対応 $v_L(i,j)=(s(i),s(j))$ と
  逆写像、配位の全単射 $r_L(\tau)=\tau\circ v_L$ を定義し、分解を
  $b(r_L(\tau))=b^{\mathrm{op}}_{L,L}(\tau)+s^{\mathrm{bd}}_L(\tau)$、和の書き換えを
  「全単射 $r_L$ に沿う和の並べ替え」の行として明示する形へ書き直した。前進前にコミット
  `cf66b444` として main へ反映した。

- 2026-08-15（tick 275）: 前 tick の「開境界長方形の接合不等式」の本文・SageMath・Lean
  具体版・必要十分版・導出版を突き合わせた。数学内容と四層の対応は揃っていたが、SageMath の
  `overview.md` が「次の tick の Lean」と記したままだったため、三種の Lean が完成済みという
  実態へ訂正し、前進前にコミット `03469704` として main へ反映した。

- 2026-08-15（tick 274）: 前 tick の `OpenRectangleGluing.lean` の接合面分解
  （辺の三分割の全単射・接合面の破れ辺数と上界・三項分解・座標交換による第二方向への帰着）を
  本文の証明と突き合わせた。接合面の辺の位置（第一座標 $a-1$ と $a$ の間）、上界 $b$・$a$、
  分解の三項の並びが一致し、入口 import と sorry 非依存検査への登録も揃っているため、修正は無い。

- 2026-08-15（tick 273）: 前 tick の `OpenRectangleGluing.lean` を本文の第一・第二座標方向の
  制限・接合と突き合わせた。各頂点での左右（下上）の添字、六つの戻りの等式、二つの全単射が
  一致し、入口 import と sorry 非依存検査への登録も揃っているため、修正は無い。

（これより古い 264 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
