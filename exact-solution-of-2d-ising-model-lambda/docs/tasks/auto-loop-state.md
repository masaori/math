# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-15 の tick 293 は、「開境界長方形の値の配位数による上からの評価」を本文・
  SageMath・Lean（具体版・既存の必要十分版からの導出版）まで完成させてセクションを閉じた。**
  $0<t\le1$ では各項を $1$ で、$1\le t$ では破れボンド数を $2ab$ で抑え、配位数 $2^{ab}$ を掛けて
  $Z^{\mathrm{op}}_{a,b}(t)\le2^{ab}$ と $Z^{\mathrm{op}}_{a,b}(t)\le2^{ab}t^{2ab}$ を得た。
  レビューでは前 tick の定数配位・破れボンド数零・値の下界という三つの主張が一致し、修正は無い。
  式変形統一では姉妹側「$\check Z,\check Y$ についての $\cosh,\sinh$ の展開係数への変換」の
  (h1.y) で、冪の展開と $2^{-n}2^n=1$ を別の行へ分けた。次は「開境界正方形と部分正方形の値の比較」。

- **2026-08-15 の tick 292 は、「倍数でない辺への拡張」を六つに割り直し、その先頭
  「開境界長方形の値は 1 以上である」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで
  完成させてセクションを閉じた。** 開境界の全て正の定数配位 $\tau_{+}$ を定義し、その破れボンド数が
  零であることから、正の実数 $t$ での $1\le Z^{\mathrm{op}}_{a,b}(t)$ を、一項の分離で示した。
  レビューでは前 tick の下限への任意近接の本文・SageMath・Lean 三本が一致し、修正は本文末尾
  「この先に書くこと」に済んだ項目が残っていたのを消しただけ。式変形統一では姉妹側「$\check Z,\check Y$ に
  ついての $\cosh,\sinh$ の展開係数への変換」の (h1.z) の鎖で、商と積の冪の展開と $2^{-n}2^{n}=1$ が
  一行に圧縮されていたのを二行へ分けた。次は「開境界長方形の値の配位数による上からの評価」。

- **2026-08-15 の tick 291 は、「倍数の辺での下限への任意近接（$0<t\le1$ の場合）」を本文・
  SageMath・Lean（具体版・必要十分版・導出版）まで完成させ、セクションを閉じた。** 下限 $v$ と
  $\varepsilon>0$ に対し、$v+\varepsilon$ が下界でないことから一辺 $a$ を取り、
  $\psi^{\mathrm{op}}_{ka}\le\psi^{\mathrm{op}}_a$ と下界性で
  $v\le\psi^{\mathrm{op}}_{ka}<v+\varepsilon$ を全ての $k\ge1$ について得た。レビューでは前 tick の
  下界・下限の本文・SageMath・Lean 三本が一致し、修正は無い。式変形統一では姉妹側
  「$\check Z,\check Y$ の $n$ 重交換子」の (h2.z) の二つの帰納段階で、スカラー整理と冪の指数法則を
  別の行へ分けた。次は「倍数でない辺への拡張」。

- **2026-08-15 の tick 290 は、「開境界密度の下からの評価と下限の存在」の Lean（具体版・必要十分版・
  導出版）を完成させ、本文へ `lean` 宣言を付けてセクションを閉じた。具体版は人手証明と同じ順
  （$2t^{E_L}\le2^{L^2}t^{E_L}=\sum_\tau t^{E_L}\le Z^{\mathrm{op}}_{L,L}(t)$、
  $t^{2L^2}\le t^{E_L}\le2t^{E_L}$、対数側の係数の合成と単調性）を辿り、下限は値集合を符号反転して
  上限の存在を適用し戻した。必要十分版は「下界を写像で運び尺度係数を合成・相殺する」ことと
  「順序を反転する対合と上限の存在」だけを残した（順序の反射律・推移律も不要）。レビューでは
  下限の証明の係数表記を主張の $\iota_{\mathbb{Q}\to\mathbb{R}}(2)$ へ揃え、SageMath 概要の
  対象ラベル宣言が検査の正規表現に合っていなかった（対応検査が落ちていた）ので直した。**
  式変形統一では姉妹側「$\check Z,\check Y$ の $n$ 重交換子」の (h2.y) の第二帰納段階で、圧縮されていた
  スカラー整理と冪の指数法則を二行へ分けた（残りは (h2.z) の二つの帰納段階の同じ箇所）。
  次は「倍数の辺での下限への任意近接（$0<t\le1$ の場合）」。

- **2026-08-15 の tick 289 は、「開境界密度の下からの評価と下限の存在」を本文と SageMath まで
  進めた。$0<t\le1$ で $2t^{2L(L-1)}\le Z^{\mathrm{op}}_{L,L}(t)$ と
  $t^{2L^2}\le2t^{2L(L-1)}$ を経て $2\log_{\mathbb R}t\le\psi^{\mathrm{op}}_L(t)$ を得た。値集合の
  符号を反転し、既存の上限の存在だけから下限を構成した。Lean は未着手である。レビューでは前 tick の
  SageMath の上界判定を整数冪の厳密比較へ修正し、前進前に push した。**
  式変形統一では姉妹側「$\check Z,\check Y$ の $n$ 重交換子」の (h2.y) の第一帰納段階で、圧縮されていた
  スカラー整理と冪の指数法則を二行へ分けた。次は同じセクションの Lean。

（これより古い 248 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
- 熱力学極限: 25 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 開境界正方形と部分正方形の値の比較 | todo | $a\le L$ に対し、接合不等式と上の二評価で $Z^{\mathrm{op}}_{L,L}(t)$ を $Z^{\mathrm{op}}_{a,a}(t)$ の定数倍で二場合に挟む（$0<t\le1$: $t^{a+L}Z_{a,a}\le Z_{L,L}\le2^{L^2-a^2}Z_{a,a}$。$1\le t$ は向きが反転し $t$ の冪が付く） |
| 熱力学極限 | 部分正方形との比較の対数化 | todo | $\psi^{\mathrm{op}}_L(t)$ を $\iota(a^2/L^2)\psi^{\mathrm{op}}_a(t)$ と $\log_{\mathbb R}t$・$\log_{\mathbb R}2$ の有理数倍で二場合に挟む |
| 熱力学極限 | 開境界密度の極限（$0<t\le1$ の場合） | todo | 任意近接の $a$ を固定し、$ka\le L<(k+1)a$ で $\psi^{\mathrm{op}}_L$ を $\psi^{\mathrm{op}}_{ka}$ で挟んで、下限 $v$ への $\varepsilon$–$N$ の言明を閉じる |
| 熱力学極限 | 開境界密度の極限（$1\le t$ の場合） | todo | 同じ論法で上限 $u$ への収束を閉じる |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-15（tick 293）: `claim_open_rectangle_value_upper_bound_le_one` と
  `claim_open_rectangle_value_upper_bound_one_le` を記述した。SageMath は 8 形状と二場合の有理点
  64 組について、各項の一様上界・配位数・有限和の上界を `QQ` で厳密に検査した。Lean 具体版二本は
  各項の冪を一様に抑えて配位数個の定数和へまとめ、人手証明と同じ順を辿る。必要十分版は既存の
  `sum_pow_le_uniform_bound_necSuf`（有限添字型・底と指数の一様上界だけ）を再利用し、導出版二本で
  特殊化を明示した。式変形統一では姉妹側「$\cosh,\sinh$ の展開係数への変換」の (h1.y) の圧縮行を
  二行へ開いた（残りは同じブロックの (h2.z)・(h2.y) の同じ箇所）。

- 2026-08-15（tick 292）: **割り直し**: 「倍数でない辺への拡張」は、値の評価二本・部分正方形との
  比較・その対数化・二場合の極限の言明を含み 1 tick で終わらないので、六つのセクションへ割った
  （表を参照）。先頭の「開境界長方形の値は 1 以上である」を閉じた:
  `def_open_rectangle_constant_plus_configuration`、`claim_open_rectangle_constant_plus_breaks_no_bond`、
  `claim_open_rectangle_value_at_least_one` を記述し、SageMath は 8 形状で破れボンド数零、48 組で
  一項の分離と $1\le Z^{\mathrm{op}}_{a,b}(t)$ を有理数で厳密に検査した。Lean 具体版
  `OpenRectangleValueAtLeastOne.lean`（`openAllPlusConfig`、破れボンド数零、`one_le_openPartitionValue`）、
  必要十分版 `one_le_sum_pow_by_separating_zero_exponent_term_necSuf`（有限添字型・指数零の一項・
  正の元の冪の非負性だけ）、導出版。sorry 検査 1056 件。式変形統一では姉妹側「$\cosh,\sinh$ の展開係数への
  変換」の (h1.z) の鎖の一行を二行へ開いた（残りは同じブロックの (h1.y)・(h2.z)・(h2.y) の同じ箇所）。

- 2026-08-15（tick 291）: `claim_open_free_energy_density_infimum_approximation_multiples_le_one` を
  記述した。SageMath は倍数列の単調性を有理数の整数冪で厳密に 16 件、有限モデルを 15 件検査した。
  Lean 具体版は反例の一辺を取る三段を人手証明と同じ順で辿り、必要十分版
  `rangeValue_infimum_approximation_multiples_necSuf` は線形順序・下限・倍数写像に沿う単調性だけを
  残した。sorry 検査 1052 件。式変形統一では姉妹側 (h2.z) の二つの帰納段階を一ステップ一定理へ開いた。

- 2026-08-15（tick 290）: `OpenFreeEnergyDensityLowerBound.lean` に辺数 `openSquareEdgeCount`、
  値の二段の評価 `two_mul_pow_edgeCount_le_openPartitionValue`・`pow_twoSquare_le_two_mul_pow_edgeCount`、
  具体版 `openSquareFreeEnergyDensity_lowerBound_of_le_one` を、`OpenFreeEnergyDensityInfimum.lean` に
  具体版 `openFreeEnergyDensityValueSet_has_infimum_of_le_one` を人手証明と 1 対 1 に実装した。
  必要十分版 `scaled_map_lowerBound_necSuf`（下界の写像・尺度の合成・係数の相殺のみ）と
  `indexedValueSet_has_infimum_necSuf`（証人・一様下界・順序反転対合・上限の存在のみ）、導出版二本。
  sorry 検査 1049 件。本文へ `lean` 宣言を付け、SageMath 概要へ Lean の状態を書いた。式変形統一では
  姉妹側 (h2.y) の第二帰納段階の最後を、スカラー整理と冪の指数法則の二行へ開いた。

- 2026-08-15（tick 289）: `claim_open_free_energy_density_lower_bound_le_one` と
  `claim_open_free_energy_density_infimum_exists_le_one` を記述した。値の下界と冪の比較を可算側で
  厳密に行って一様下界 $2\log_{\mathbb R}t$ を得た。下限は $-\Psi^{\mathrm{op}}_t$ の上限の符号反転
  として構成し、完備性は既に宣言した上限の存在の形だけを使った。SageMath は値の下界 32 件、密度と
  有限モデル 24 件を検査した。Lean は未着手。式変形統一では姉妹側 (h2.y) の第一帰納段階の最後を、
  スカラー整理と冪の指数法則の二行へ開いた。

（これより古い 259 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

- 2026-08-15（tick 293）: 前 tick の「開境界長方形の値は 1 以上である」の本文・SageMath・
  Lean 具体版・必要十分版・導出版を突き合わせた。定数配位の定義、破れボンド数零、一項の分離、
  対象ラベル、入口 import、sorry 検査への登録は一致しており、修正は無い。

- 2026-08-15（tick 292）: 前 tick の「倍数の辺での下限への任意近接（$0<t\le1$）」の本文・
  SageMath・Lean 具体版・必要十分版・導出版を突き合わせた。三段の論法、対象ラベル、sorry 検査への
  登録は一致した。本文末尾「この先に書くこと」に済んだ「倍数の辺での下限への任意近接」が残っていたので
  消した。

- 2026-08-15（tick 291）: 前 tick の「開境界密度の下からの評価と下限の存在」の本文・SageMath・
  Lean 具体版・必要十分版・導出版を突き合わせた。値の二段評価、対数側の係数相殺、値集合の符号反転に
  よる下限構成、対象ラベルと sorry 検査への登録が一致しており、修正は無い。

- 2026-08-15（tick 290）: 前 tick の「開境界密度の下からの評価と下限の存在」の本文・SageMath を
  突き合わせた。数学内容は一致した。下限の存在の証明が主張の $\iota_{\mathbb{Q}\to\mathbb{R}}(2)\log t$
  に対し裸の $2\log t$ と書いていたので揃え、下界の定義へのラベル参照を足した。SageMath 概要の
  「対象ラベル」が箇条書き形式で、対応検査 `verify-check-linkage.ts` の正規表現に合わず検査が
  落ちていたので一行形式へ直した（対象に下界・下限の定義二つも加えた）。

- 2026-08-15（tick 289）: 前 tick の「倍数の辺での上限への任意近接（$1\le t$）」の本文・
  SageMath・Lean 具体版・必要十分版・導出版を突き合わせた。三段の論法は一致していたが、有限モデルの
  上界検査が ball 差の下端が非正であることしか見ておらず、上界を保証していなかった。有限集合の
  最大密度を分配関数の整数冪の厳密比較で特定し、各値が最大値以下であることも同じ厳密比較で検査する
  よう修正した。

（これより古い 280 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
