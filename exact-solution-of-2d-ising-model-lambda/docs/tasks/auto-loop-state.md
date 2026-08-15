# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

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

- **2026-08-15 の tick 288 は、「倍数の辺での上限への任意近接」を $1\le t$ の場合に限って本文・
  SageMath・Lean（具体版・必要十分版・導出版）まで完成させ、セクションを閉じた。$0<t\le1$ では
  開境界密度の上限は極限ではない（$\psi^{\mathrm{op}}_1(t)=\log_{\mathbb R}2$ が上限で、
  倍数列は $\psi^{\mathrm{op}}_{ka}\le\psi^{\mathrm{op}}_a$ と減少する）ので、下限へ向かう
  二セクションを表へ足した。レビューでは前 tick の上界・上限の存在の本文・SageMath・Lean 三本が
  一致した。前 tick の Lean 定理 5 件が sorry 検査の登録一覧に無かったので登録した。**
  次は「開境界密度の下からの評価と下限の存在」。

- **2026-08-15 の tick 287 は、「開境界密度の上からの評価と値集合の上限の存在」を本文・
  SageMath・Lean（具体版・必要十分版からの導出）まで完成させ、セクションを閉じた。レビューでは
  前 tick のブロック敷き詰め評価の本文・SageMath・Lean 三本が一致し、修正は無い。**
  一様上界から値集合の上限を得て、姉妹側の式変形を一件統一した。次は「倍数の辺での上限への任意近接」。

- **2026-08-15 の tick 286 は、「ブロック敷き詰め評価の対数化」の Lean（具体版・必要十分版・
  導出版）を完成させ、本文へ `lean` 宣言を付けてセクションを閉じた。レビューでは前 tick の証明で
  実対数の乗法加法性・単調性の根拠にラベル参照が無かったので `\blkref{remark_real_logarithm}` を
  付けて前進前に push した。**
  具体版は人手証明と同じ順（ブロック評価→実対数の単調性→積と冪の対数の展開→正の係数の乗法→
  有理数の約分）を辿り、必要十分版 `scaled_map_twoSided_bounds_necSuf` は順序を保つ写像・像の
  二項分解・尺度係数の相殺だけを残した（$1\le t$ の場合は順序の向きを反転して同じ定理で得る）。
  sorry 検査 1032 件、すべて非依存。式変形統一では姉妹側「$\check Z,\check Y$ の $n$ 重交換子」の
  (h1.y) の基底段階を、(h1.z) と同じ二段の等号鎖と行末根拠へ開いた。次は「開境界密度の上からの
  評価と値集合の上限の存在」。

（これより古い 245 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
- 熱力学極限: 22 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 倍数の辺での下限への任意近接（$0<t\le1$ の場合） | todo | 下限に近い一辺 $a$ を取り、対数化した評価の $\psi^{\mathrm{op}}_{ka}\le\psi^{\mathrm{op}}_a$ で倍数列を下限の近くへ押し込む（$1\le t$ の上限版と対称） |
| 熱力学極限 | 倍数でない辺への拡張 | todo | $ka\le L<(k+1)a$ の正方形を接合不等式で挟み、極限の言明を閉じる |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

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

- 2026-08-15（tick 288）: `claim_open_free_energy_density_supremum_approximation_multiples_one_le`
  を記述した。$1\le t$ で、上限 $u$ と $\varepsilon$ に対し、$u-\varepsilon$ が上界でないことから
  一辺 $a$ を取り、ブロック敷き詰め評価の対数化の $\psi^{\mathrm{op}}_a\le\psi^{\mathrm{op}}_{ka}$ と
  上界性で $u-\varepsilon<\psi^{\mathrm{op}}_{ka}\le u$ を全ての $k$ で得た。SageMath は単調性を
  有理数の指数側の不等式 $Z_a^{(ka)^2}\le Z_{ka}^{a^2}$ として厳密に 16 件、有限モデルを ball で
  14 件。Lean 具体版は人手証明の三段を辿り、必要十分版
  `rangeValue_supremum_approximation_multiples_necSuf` は線形順序・上限・倍数写像に沿った単調性
  だけを残した。**割り直し**: 「倍数の辺での上限への任意近接」は $0<t\le1$ では成り立たない
  （上限は $\psi^{\mathrm{op}}_1(t)=\log_{\mathbb R}2$ で、倍数列は減少して下限へ向かう）ため、
  $1\le t$ の場合で閉じ、$0<t\le1$ 用に「開境界密度の下からの評価と下限の存在」と
  「倍数の辺での下限への任意近接」を表の先頭へ足した。式変形統一では姉妹側「$\check Z,\check Y$ の $n$ 重交換子」の (h2.y) の基底 $F_0$ を、(h2.z) と同じ恒等写像と零乗を根拠にした二段の等号鎖へ開いた。

- 2026-08-15（tick 287）: `claim_open_free_energy_density_upper_bound` と開境界密度の値集合・
  上限の存在を記述した。開境界の値の上界は、各項の底を $t$ から $1+t$ へ上げ、指数を辺数
  $2L(L-1)$ から $2L^2$ へ上げ、$2^{L^2}$ 個の定数和へまとめた。Lean 具体版はこの三段と
  実対数の展開を人手証明と同じ順で辿り、必要十分版は既存の `scaled_map_upperBound_necSuf` と
  `indexedValueSet_has_supremum_necSuf` を特殊化した。SageMath は厳密計算と ball 算術で 20 件。
  式変形統一では姉妹側「$\check Z,\check Y$ の $n$ 重交換子」の (h2.z) の基底 $E_0$ を、
  恒等写像と零乗を根拠にした二段の等号鎖へ開いた。

- 2026-08-15（tick 286）: `OpenSquareBlockTilingLogarithm.lean` に補正項 `blockTilingCorrection`、
  一辺 $ka$ の `squareSide`、下側・上側の対数の展開補題、係数の約分補題二本と、二場合の定理
  `openSquareFreeEnergyDensity_blockTiling_bounds_of_le_one/of_one_le` を人手証明と 1 対 1 に
  実装した。必要十分版 `scaled_map_twoSided_bounds_necSuf` は「順序を保つ写像・像の二項分解・
  尺度作用の分配と係数の相殺」だけを仮定し（$A$ の加法の可換性も $K$ の乗法も不要）、導出版
  二本で特殊化を示した。本文へ `lean` 宣言を付け、SageMath 概要の「Lean 未着手」を実態へ直した。
  sorry 検査 1032 件。式変形統一では姉妹側「$\check Z,\check Y$ の $n$ 重交換子」
  （`014_even_sector_T_action`）の (h1.y) の基底段階 $D_0$ を、散文中の行内等式から
  恒等写像と零乗を根拠にした二段の等号鎖へ開いた（(h1.z) の $C_0$ と同じ形）。

（これより古い 256 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

- 2026-08-15（tick 288）: 前 tick の「開境界密度の上からの評価」「値集合」「上限の存在」の本文・
  SageMath・Lean 具体版・導出版を突き合わせた。値の三段の評価（底を $1+t$ へ、指数を $2L^2$ へ、
  定数和）、対数の展開と係数の約分、非空性と有界性からの完備性の適用が一致した。ただし前 tick の
  Lean 定理 5 件（値の上界・密度の上界・その導出・上限の存在・その導出）が sorry 検査の登録一覧
  `lean/scripts/check-no-sorry.sh` に無かった（本文の `lean` 宣言だけがあり、検査の対象になって
  いなかった）ので登録した。今 tick の 3 件も登録し、1040 件すべて非依存を確認した。

- 2026-08-15（tick 287）: 前 tick の「ブロック敷き詰め評価の対数化」の本文・SageMath・Lean
  具体版・必要十分版・導出版を突き合わせた。二場合の不等式の向き、補正係数、対数展開、
  有理係数の約分が一致しており、修正は無い。

- 2026-08-15（tick 286）: 前 tick の「ブロック敷き詰め評価の対数化」の本文・SageMath を突き合わせた。
  数学内容は一致したが、証明中で実対数の乗法加法性・狭義単調性を根拠に挙げた 4 箇所に
  `\blkref{remark_real_logarithm}` が無く、既存の証明の書き方（性質名＋ラベル参照）と食い違って
  いたので付けた（散文側にも参照を足した）。

（これより古い 277 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
