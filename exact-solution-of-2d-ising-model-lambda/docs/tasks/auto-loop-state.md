# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-16 の tick 311 は、「有理数倍と埋め込みを通した順序の移送」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで
  完成させた。** $L\ge1$、$\lambda,\mu\in\Lambda$ に対し $\frac{1}{L^2}\cdot\iota(\lambda)\le_{\Lambda_{\mathbb Q}}\frac{1}{L^2}\cdot\iota(\mu)
  \iff\lambda\le_\Lambda\mu$（`claim_scaled_embedding_order_transfer`、密度の定義の直後・実数体脱出の宣言の直前）。準備で $N=L^2$ が
  $\frac{1}{L^2}\cdot\iota(\lambda)$ の共通分母で証人が $\lambda$ 自身であること（三段の鎖: 結合則・約分・$1\cdot\lambda=\lambda$）を示し、
  → は順序の定義の言い換え（すべての共通分母で）を $N=L^2$ で読み、← は定義（ある共通分母で）に $N=L^2$ と証人を入れて閉じた。
  レビューでは前 tick の密度の定義の四層が一致し修正無し。次は「正の有理点での分配多項式の値は 1 以上」。

- **2026-08-16 の tick 310 は、「有限系の自由エントロピー密度（$\Lambda_{\mathbb Q}$ 値）の定義」を本文・SageMath・Lean 具体版まで
  完成させた。** $\Psi_L(q):=\frac{1}{L^2}\cdot\iota_{\Lambda\to\Lambda_{\mathbb Q}}(\Phi_L(q))\in\Lambda_{\mathbb Q}$
  （$L\ge1$、$q\in\mathbb Q_{>0}$）を加法単調性の直後・実数体脱出の宣言の前に置き（`def_finite_free_entropy_density`）、右辺の確定
  （$1/L^2\in\mathbb Q$、$Z_L(q)\in\mathbb Q_{>0}$）と各素数での値 $\Psi_L(q)(p)=\Phi_L(q)(p)/L^2$ の三段の鎖、具体例
  $\Psi_2(1/2)(353)=1/4$・$\Psi_2(1/2)(2)=-7/4$ を書いた。実数値の $\psi_L$ とは記号を分けて併存させる（撤去のセクションで一本化）。
  定義ブロックなので必要十分版は置かない（`def_finite_free_entropy` と同じ）。レビューでは前 tick の順序の保存・反映の四層が
  一致し修正無し。次は「有理数倍と埋め込みを通した順序の移送」。

- **2026-08-16 の tick 309 は、「有限系の実自由エントロピーを畳む」を着手前に対象ブロックを列挙して 16 のセクションへ割り、
  その先頭「正の有理数の対数は順序を保ちかつ反映する」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。**
  補助等式 $\operatorname{rat}_\Lambda(\log q)=q$ を全射性の主張（$\lambda:=\log q$）と単射性で示し、
  $\log q\le_\Lambda\log q'\iff\operatorname{rat}_\Lambda(\log q)\le\operatorname{rat}_\Lambda(\log q')\iff q\le q'$ の二段で閉じた
  （`claim_rational_log_order_iff`、章「有限系の自由エントロピー」の末尾）。これが有理点での分配多項式の値の不等式を $\Lambda$ の
  順序へ移す橋になる。割り方は「$\mathbb R$ 版のブロックをその場で書き換えず、$\mathbb Q$／$\Lambda_{\mathbb Q}$ 版を実数体脱出の
  宣言より前に新設し、$\mathbb R$ 版は『旧実数値経路を撤去する』で消す」。レビューでは前 tick の加法単調性の四層が一致し修正無し。
  次は「有限系の自由エントロピー密度（$\Lambda_{\mathbb Q}$ 値）の定義」。

- **2026-08-16 の tick 308 は、「有理係数の対数順序群の順序の加法単調性」を本文・SageMath・Lean（具体版・必要十分版・導出版）
  まで完成させた。** 三元の共通の共通分母 $N:=N_\lambda N_\mu N_\nu$ で $N\cdot(\lambda+\nu)=N\cdot\lambda+N\cdot\nu
  =\iota(\lambda_N)+N\cdot\nu=\iota(\lambda_N)+\iota(\nu_N)=\iota(\lambda_N+\nu_N)$ の四段（有理数倍の分配則・$\iota$ の加法性）で
  $N$ が $\lambda+\nu$ の共通分母（証人 $\lambda_N+\nu_N$）であることを示し、仮定を $N$ で読んで $\Lambda$ の加法単調性へ落とした
  （`claim_rational_log_order_group_add_monotone`）。レビューでは前 tick の線形順序性の四層が一致し、Lean 具体版ヘッダの
  「二度」を「各元について一度ずつ、計三度」へ直して先に push した。次は「有限系の実自由エントロピーを畳む」。

- **2026-08-16 の tick 307 は、「有理係数の対数順序群の順序の線形順序性と加法単調性」を線形順序性と加法単調性へ割り、
  「有理係数の対数順序群の順序は線形順序である」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。**
  三元の共通の共通分母 $N:=N_\lambda N_\mu N_\nu$ を取り、順序の定義の言い換え（すべての両方の共通分母で）で
  証人の比較へ移して $\Lambda$ の線形順序性へ落とした（`claim_rational_log_order_group_linear_order`）。反対称律は
  $\lambda_N=\mu_N$ から $N^{-1}\cdot(N\cdot\lambda)$ の七段の鎖で $\lambda=\mu$ へ戻した。レビューでは前 tick の順序の
  定義の四層が一致し修正無し。次は「有理係数の対数順序群の順序の加法単調性」。

（これより古い 264 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## セクション台帳

**済んだ範囲**（章ごとの件数。個々の内訳は [auto-loop-archive.md](auto-loop-archive.md) と
MEMORY.md にある。番号で呼ばないので、ここでは章と件数だけを持つ）。

- 固有値の代数性: 128 セクション
- Fisher 零点: 44 セクション
- 分配多項式: 4 セクション
- 転送行列: 4 セクション
- 有限系の自由エントロピー: 11 セクション
- 形式検証の土台: 1 セクション
- 零点の詰め寄り: 5 セクション
- 熱力学極限: 35 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 正の有理点での分配多項式の値は 1 以上 | todo | 定数配位の項が $q^0=1$、他の項は非負（`claim_free_energy_density_nonnegative` の中身を $\mathbb Q$ で。住処 Q） |
| 熱力学極限 | 有限系の自由エントロピー密度は非負である（$\Lambda_{\mathbb Q}$ 版） | todo | $\log1=0$（`claim_free_entropy_at_one` の中身）と対数の順序保存で $0\le_\Lambda\Phi_L(q)$、順序の移送で $0\le_{\Lambda_{\mathbb Q}}\Psi_L(q)$ |
| 熱力学極限 | 正の有理点での分配多項式の値の上界（$\mathbb Q$ 版） | todo | `claim_partition_value_upper_bound` の $t\in\mathbb R$ を $q\in\mathbb Q$ に置いた新ブロック（住処 Q。Lean は ℝ 版を ℚ へ移す） |
| 熱力学極限 | 有限系の自由エントロピー密度の上界（$\Lambda_{\mathbb Q}$ 版） | todo | $\Phi_L(q)\le_\Lambda L^2\ell_2+2L^2\log\max(1,q)$（対数の加法性・冪・順序保存）から $\Psi_L(q)\le\ell_2+2\log\max(1,q)$。実対数の冪の法則は使わない |
| 熱力学極限 | 開矩形の可算な定義群を実数体脱出の前へ移し、正の有理点での値（$\mathbb Q$ 版）を定義する | todo | `def_open_rectangle_*`（住処 N/Z）を宣言より前へ移す（中身は変えない）。$Z^{\mathrm{op}}_{a,b}(q)\in\mathbb Q_{>0}$ の定義と正値性 |
| 熱力学極限 | 接合不等式（$\mathbb Q$ 版） | todo | `claim_open_rectangle_gluing_inequality` を $q\in\mathbb Q$ で新設（順序体の性質だけなので論法は同じ。Lean は ℚ へ） |
| 熱力学極限 | 反復接合の第一（$\mathbb Q$ 版） | todo | 帰納法 1 本 |
| 熱力学極限 | 反復接合の第二（$\mathbb Q$ 版） | todo | 帰納法 1 本 |
| 熱力学極限 | 正方形のブロック敷き詰め（$\mathbb Q$ 版） | todo | 第一・第二の合成 |
| 熱力学極限 | 周期境界と開境界の比較（$\mathbb Q$ 版） | todo | |
| 熱力学極限 | 開境界正方形の自由エントロピー密度（$\Lambda_{\mathbb Q}$ 値）の定義と非負性・上界 | todo | $\Psi^{\mathrm{op}}_L(q):=\frac{1}{L^2}\cdot\iota(\log Z^{\mathrm{op}}_{L,L}(q))$。値の下界 1・上界（$\mathbb Q$ 版）もここで（定義 1・主張 2 なら割る） |
| 熱力学極限 | ブロック敷き詰めの対数化（$\Lambda_{\mathbb Q}$ 版） | todo | $\Psi^{\mathrm{op}}_{ka}$ を $\Psi^{\mathrm{op}}_a$ と $\ell_2$・$\log q$ の有理数倍で二場合に挟む |
| 熱力学極限 | 部分正方形との比較（$0<q\le1$。$\mathbb Q$ 版） | todo | `claim_open_square_subsquare_comparison_le_one` を $q\in\mathbb Q$ で |
| 熱力学極限 | 極限の存在を $\Lambda\otimes\mathbb{Q}$ の Cauchy 性として述べる | todo | 完備性（上限の存在）を使わずに、可算側の主張として収束の速さつきで述べる。各段の比較は有理数の比較なので決定可能 |
| 熱力学極限 | 切断による ℝ への一度きりの脱出 | todo | 「この有理数の列が定める切断として実数が存在する」だけを引く。章頭の「実数体への脱出の宣言」をここへ移し、完備性の宣言は不要になれば畳む |
| 熱力学極限 | 旧実数値経路を撤去する | todo | 可算側の密度・Cauchy 性・切断からの実数化が揃ったあと、$\varphi_L$ と実数値の上下限・上限／下限による極限経路、および対応する SageMath・Lean を削除し、参照と台帳を新経路へ揃える |
| 熱力学極限 | 開境界正方形と部分正方形の値の比較（$1\le t$ の場合） | todo | $1\le a<L$、$c=L-a$ に対し、接合不等式の $1\le t$ 側と値の下界 $1$・配位数による上界 $2^{ab}t^{2ab}$ で挟む。予定: $Z_{a,a}\le Z_{L,L}\le2^{L^2-a^2}t^{a+L+2(L^2-a^2)}Z_{a,a}$（$0<t\le1$ 側は済。Lean は `split_twice_bounds_necSuf` と同型の必要十分版で書ける見込み） |
| 熱力学極限 | 部分正方形との比較の対数化 | todo | $\psi^{\mathrm{op}}_L(t)$ を $\iota(a^2/L^2)\psi^{\mathrm{op}}_a(t)$ と $\log_{\mathbb R}t$・$\log_{\mathbb R}2$ の有理数倍で二場合に挟む |
| 熱力学極限 | 開境界密度の極限（$0<t\le1$ の場合） | todo | 任意近接の $a$ を固定し、$ka\le L<(k+1)a$ で $\psi^{\mathrm{op}}_L$ を $\psi^{\mathrm{op}}_{ka}$ で挟んで、下限 $v$ への $\varepsilon$–$N$ の言明を閉じる |
| 熱力学極限 | 開境界密度の極限（$1\le t$ の場合） | todo | 同じ論法で上限 $u$ への収束を閉じる |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-16（tick 311）: `claim_scaled_embedding_order_transfer` を `def_finite_free_entropy_density` の直後に置き四層で閉じた。準備は
  $L^2\cdot(\frac{1}{L^2}\cdot\iota(\lambda))=(L^2\cdot\frac{1}{L^2})\cdot\iota(\lambda)=1\cdot\iota(\lambda)=\iota(\lambda)$ の三段
  （有理数倍の結合則・$\mathbb Q$ の約分・$1\cdot\lambda=\lambda$）で $L^2$ が共通分母・証人 $\lambda$。両向きは順序の定義の ∀ 形と ∃ 形。
  SageMath `scaled-embedding-order-transfer`（素数 $2,3,5$・係数 4 種の 64 ベクトル、$L\in\{1,2,3\}$、鎖 192 件・共通分母 192 件・
  同値 12288 件・証人の比較の一致 12288 件、`ZZ`/`QQ`。素数 4 個・$L\le6$ の規模は決定手続きの指数が大きく 10 分で終わらなかったので縮めた）。
  Lean 具体版 `ThermodynamicLimit/ScaledEmbeddingOrderTransfer.lean`（`commonDenominator_scaled_toRational`、
  `rationalLogOrderLE_scaled_toRational_iff`）、必要十分版 `NecSuf/ThermodynamicLimit/ScaledEmbeddingOrderTransfer.lean` の
  `indexedLE_iff_of_common_good_index_necSuf`（独立性と、二元に共通の良い添字とそこでの証人が与えられていることだけ。有理数倍・埋め込みは
  本質でない）、導出版。sorry 検査 1147 件。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 310）: `def_finite_free_entropy_density` を `claim_rational_log_order_group_add_monotone` の直後（実数体脱出の
  宣言の直前）に置いた。$\Psi_L(q):=\frac{1}{L^2}\cdot\iota(\Phi_L(q))$、右辺の確定、各素数での値の三段の鎖（有理数倍の定義・$\iota$ の
  定義・$\mathbb Q$ の積）、$\Psi_L$ と $\Psi_L(q)$ の区別、$\psi_L$ との記号の分離、具体例 $L=2$・$q=1/2$。
  `def_rational_log_order_group` 末尾の「密度の住処」に新定義への参照を足した。SageMath `finite-free-entropy-density`
  （$L\in\{1,2,3\}$・正の有理点 7 点で確定・鎖の各段・台の一致・具体例、72 検査、`ZZ`/`QQ`）。Lean 具体版は既存の
  `ThermodynamicLimit/RationalLogOrderGroup.lean` の `scaledFreeEntropy`（docstring を新定義へ）と新補題 `scaledFreeEntropy_apply`
  （三段の鎖と 1 対 1）。定義ブロックのため必要十分版・導出版は無し。sorry 検査 1143 件。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 309）: **割り直し**: 「有限系の実自由エントロピーを畳む」は $\mathbb R$ 版ブロック約 40 件の書き換えを含み論法が多数
  なので、$\mathbb Q$／$\Lambda_{\mathbb Q}$ 版を新設する 16 のセクション（この tick で済ませた先頭を含む）へ割った（表のとおり。$\mathbb R$ 版はその場で書き換えず、
  下流の $\mathbb R$ ブロックが参照を失わないよう併存させ、「旧実数値経路を撤去する」で消す）。先頭として
  `claim_rational_log_order_iff` を `claim_log_order_group_positive_multiple_invariant` の直後に置き四層で閉じた。
  補助等式 $\operatorname{rat}_\Lambda(\log q)=q$（`claim_rational_log_surjective` を $\lambda:=\log q$ へ、`claim_rational_log_injective`）、
  主張は順序の定義と補助等式の二段。SageMath `rational-log-order-iff`（素数 $2,3,5,7$・指数 5 種の正の有理数 625 個、恒等式 625 件、
  同値 390625 件、`ZZ`/`QQ`）。Lean 具体版 `FreeEntropy/RationalLogOrderIff.lean`（`rationalOfLog_logRat`、`logRat_le_iff`）、
  必要十分版 `NecSuf/FreeEntropy/RationalLogOrderIff.lean` の `pullback_order_iff_of_left_inverse_necSuf`（`f∘g=id`、`g` の像が
  述語を満たすこと、述語上の `f` の単射性、関係が `g` を通した引き戻しであることだけ。対数・素数・有理数は本質でない）、導出版。
  sorry 検査 1142 件。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 308）: `claim_rational_log_order_group_add_monotone` を `claim_rational_log_order_group_linear_order` の直後に置き
  四層で閉じた。準備は線形順序性と同じ三元の共通の共通分母 $N$。$N$ が $\lambda+\nu$ の共通分母で証人が $\lambda_N+\nu_N$ であること
  （四段の鎖）を示してから、定義の言い換えで $\lambda_N\le_\Lambda\mu_N$ を得て `claim_log_order_group_add_monotone` を $\nu_N$ で適用。
  SageMath `rational-log-order-group-add-monotone`（素数 $2,3,5$、係数 5 種、125 ベクトル、$\lambda\le\mu$ の組 7875 件と全 $\nu$ の
  三元 984375 件、鎖の段ごとの検査 196875 件、`ZZ`/`QQ`）。Lean 具体版 `ThermodynamicLimit/RationalLogOrderGroupAddMonotone.lean`
  （`commonDenominator_add`、`rationalLogOrderLE_add_right`）、必要十分版 `NecSuf/ThermodynamicLimit/RationalLogOrderGroupAddMonotone.lean`
  の `indexedLE_add_right_necSuf`（三元の共通の良い添字、独立性、同じ添字で `Rep` が加法を保つこと、`le` の加法単調性だけ。
  加法の結合則・可換則は使わない）、導出版。sorry 検査 1137 件。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 307）: 「線形順序性と加法単調性」は論法が二つ（順序の性質を $\Lambda$ へ落とす／和の証人を作る）なので
  線形順序性と加法単調性へ割った。`claim_rational_log_order_group_linear_order` を `def_rational_log_order_group_order` の直後に置き
  四層で閉じた。準備で $N:=N_\lambda N_\mu N_\nu$ が三元すべての共通分母であること（`claim_common_denominator_multiple` を三度）を
  述べ、四性質を `claim_log_order_group_linear_order` へ落とした。反対称律は $N^{-1}$ 倍の七段の鎖。SageMath
  `rational-log-order-group-linear-order`（素数 $2,3,5$、係数 6 種、216 ベクトル、二元 46656 組、三元 5062176 組、証人一致 1610 件、
  代表 12 本の三つ組 1728 件、`ZZ`/`QQ`）。Lean 具体版 `ThermodynamicLimit/RationalLogOrderGroupLinearOrder.lean`
  （`commonDenominator_three_exists`、`eq_of_commonDenominator_witness_eq`、`rationalLogOrderLE_refl/trans/antisymm/total`）、
  必要十分版 `NecSuf/ThermodynamicLimit/RationalLogOrderGroupLinearOrder.lean`（`indexedLE` と四つの `indexedLE_*_necSuf`。
  各性質が使う仮定だけを取る: 反射律は元自身の良い添字と証人の存在と `le` の反射律、推移律は三元の共通添字・独立性・推移律、
  反対称律は二元の共通添字・独立性・反対称律・証人一致→元一致、全順序性は二元の共通添字と全順序性）、導出版
  （`rationalLogOrderLE_eq_indexedLE` は `rfl`。sorry 検査 1133 件）。
（これより古い 275 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

- 2026-08-16（tick 311）: 前 tick の「有限系の自由エントロピー密度（$\Lambda_{\mathbb Q}$ 値）の定義」の本文・SageMath・Lean 具体版を
  突き合わせ、右辺の確定・各素数での値の三段の鎖・具体例・対象ラベル・入口 import・sorry 検査への登録が一致した。本文末尾「この先に書くこと」と
  台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 310）: 前 tick の「正の有理数の対数は順序を保ちかつ反映する」の本文・SageMath・Lean 具体版・必要十分版・
  導出版を突き合わせ、補助等式（全射性を $\lambda:=\log q$ へ・単射性）・二段の同値・対象ラベル・入口 import・sorry 検査への登録が
  一致した。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 309）: 前 tick の「有理係数の対数順序群の順序は加法について単調である」の本文・SageMath・Lean 具体版・必要十分版・
  導出版を突き合わせ、四段の鎖・∀ 形での読み替え・対象ラベル・入口 import・sorry 検査への登録が一致した。修正は無い。

- 2026-08-16（tick 308）: 前 tick の「有理係数の対数順序群の順序は線形順序である」の本文・SageMath・Lean 具体版・必要十分版・
  導出版を突き合わせ、三元の共通の共通分母・∀ 形での読み替え・反対称律の七段の鎖・対象ラベル・入口 import・sorry 検査への登録が
  一致した。Lean 具体版のヘッダコメントだけが「`claim_common_denominator_multiple` を二度」と書いており、本文と実装
  （各元について一度ずつ、計三度）と食い違っていたので直した。

- 2026-08-16（tick 307）: 前 tick の「有理係数の対数順序群の順序」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、
  ∃ 形と ∀ 形の同値・決定手続き・対象ラベル・入口 import・sorry 検査への登録が一致した。`DecidableRel` が `noncomputable` なのは
  `Λ` の順序の判定と同じ（`Finsupp` 由来）で先例どおり。修正は無い。

（これより古い 296 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
