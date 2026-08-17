# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地
- **2026-08-18 の tick 403 は、台帳の先頭行「$R$ の空でない有限集合は最小元をちょうど 1 つ持つ」の前提として欠けていた狭義順序の推移律を四層で閉じた（住処 Qbar、脱出なし）。**
  着手時の確認: `claim_real_algebraic_order_trichotomy` は「場合分けの網羅性だけを与える。順序が加法・乗法と両立することはここでは主張しない」と本文に明記されており、**推移律は本文にもなかった**（前 tick の MEMORY に確認せよと書いた点）。最小元の議論は推移律を要するので先に置いた。
  `claim_real_algebraic_order_transitive`（`claim_two_is_square_in_real_closed` の直後）: $a<_Rb$ かつ $b<_Rc$ ならば $a<_Rc$。証明は $c-a=(c-b)+(b-a)=u\cdot u+v\cdot v$ の一続き三段のあと、tick 400 の `claim_real_closed_sum_of_two_squares_is_square` で $u\cdot u+v\cdot v=w\cdot w$ と書き直し、$w\ne0$ を tick 399 の `claim_real_closed_sum_of_two_squares_zero` から出す。**直近 2 tick の補題がそのまま効いた。**
  SageMath `check/real-algebraic-order-transitive/`（3 節。`AA` のモデルで三つ組すべて・鎖の各段と証人の非零性・反射的でないことと非対称性。通過）。Lean 具体版 `FisherZero/RealAlgebraicOrderTransitive.lean`（`realAlgebraicLt_trans`）、必要十分版（可換環で「平方の和が平方」「平方の和が零なら各項が零」の 2 つを仮定に取るだけの形）、導出版。sorry 検査 1394 件・check 494 ブロック・verify-check-linkage 277 件・build:pdf 268 ページ通過。
- **2026-08-18 の tick 402 は、台帳の先頭行「臨界点への距離の二乗の定義」を本文と Lean 具体版で閉じた（定義ブロックなので必要十分版と SageMath は置かない。住処 Qbar、脱出なし）。**
  `def_distance_squared_to_critical_point`（`def_distance_squared_to_rational` の直後）: $\xi=a+b\omega$ の一意表示と、前 tick の `claim_critical_point_mem_real_closed` が与える $x_c\in R$ を用い、$\mathrm{dsq}_c(\xi):=(a-x_c)(a-x_c)+b\cdot b\in R$ を直接定義した。初稿にあった一般写像 $\mathrm{dsq}_R$ と有理点一致補題は、1 ブロックで 2 つの定義を置くことになり、後続も使わないため削除した。
  Lean 具体版 `FisherZero/DistanceSquaredToCriticalPoint.lean`（`criticalPointRealClosed`（`Classical.choose`）とその値 `criticalPointRealClosed_val`・`distanceSquaredToCriticalPoint`）。lake build・sorry 検査 1391 件・check 493 ブロック・verify-check-linkage 276 件・build:pdf 267 ページ通過。
- **2026-08-18 の tick 401 は、台帳の先頭行「$x_c$ が実閉部分体 $R$ の元であること」を四層で閉じた（住処 Qbar、脱出なし）。主定理の印を付けた。**
  `claim_critical_point_mem_real_closed`（`claim_two_is_square_in_real_closed` の直後）: $s\cdot s=2$ を満たす $s\in\overline{\mathbb Q}$ は $R$ の元であり、したがって $x_c=-1+s\in R$。証明は第 4 条件で $s=a+b\omega$ と一意表示し、展開と一意性から $a\cdot a-b\cdot b=2$、$2ab=0$ を読み、$b=0$ の枝は $s=a\in R$、$a=0$ の枝は $-2=b\cdot b$（$b\ne0$）となって前 tick の `claim_two_is_square_in_real_closed` の後半に反するので起きない。最後に部分体の加法で $-1+s\in R$。
  SageMath `check/critical-point-mem-real-closed/`（5 節。$R$ のモデルは `AA`、$\omega$ は `QQbar(I)`。2 根がどちらも `AA` の元であること・一意表示の 2 等式・$a=0$ の枝が起きないこと・$x_c$ が自己双対方程式の根であること・$-2$ の平方根は `AA` の外。通過）。Lean 具体版 `FisherZero/CriticalPointMemRealClosed.lean`（`sqrtTwo_mem_realClosed`・`criticalPoint_mem_realClosed`）。定義でなく主張だが、必要十分版は前 tick の Gauss の恒等式と三分法に尽きているので新しくは置かない。sorry 検査 1390 件・check 492 ブロック・verify-check-linkage 276 件・build:pdf 267 ページ通過。
- **2026-08-18 の tick 400 は、台帳の先頭行「$R$ では $2$ が平方である（$-2$ は平方でない）」を四層で閉じた。前 tick で「唯一の未固めの論点」と書いた箇所であり、これで最終章の $x_c\in R$ へ進める（住処 Qbar、脱出なし）。**
  `claim_real_closed_sum_of_two_squares_is_square`（`claim_real_closed_sum_of_two_squares_zero` の直後）: 任意の $x,y\in R$ にある $c\in R$ が存在して $x\cdot x+y\cdot y=c\cdot c$。**証明の鍵は順序ではなく代数閉性である**——$\overline{\mathbb Q}$ の代数閉性で $u\cdot u=x+y\omega$ を満たす $u$ を取り、第 4 条件で $u=a+b\omega$ と一意表示すると $x=a\cdot a-b\cdot b$、$y=2ab$ が読め、Gauss の恒等式 $(a^2-b^2)^2+(2ab)^2=(a^2+b^2)^2$ から $c:=a\cdot a+b\cdot b$ が取れる。平方の集合が加法で閉じることを、順序の議論なしに出せた。
  `claim_two_is_square_in_real_closed`: 上を $x:=1$、$y:=1$ に当てて $s\cdot s=2$（$2:=1+1$）を満たす零でない $s\in R$ を得る。三分法の第 2 の場合が成り立つので第 3 の場合（$-2$ が平方）は成り立たない。
  SageMath `check/real-closed-sum-of-two-squares-is-square/`（4 節。$R$ のモデルは `AA`、$\omega$ は `QQbar(I)`、代数閉性は `QQbar` の平方根。恒等式・一意表示から読む成分・$2$ の平方性と $-2$ の非平方性・$R$ の外では $-2$ も平方になること。通過）。Lean 具体版 `FisherZero/RealClosedSumOfTwoSquaresIsSquare.lean`（`realClosed_sum_of_two_squares_is_square`・`two_is_square_in_realClosed`・`neg_two_not_square_in_realClosed`）、必要十分版（Gauss の恒等式そのもの。可換環だけを要求）、導出版。sorry 検査 1388 件・check 491 ブロック・verify-check-linkage 275 件・build:pdf 266 ページ通過。
  Lean の注意: 部分体の数値リテラルは `↑(2 : ↥carrier)` が `push_cast` で `(2 : Qbar)` へ落ちないので、$2$ は `1 + 1` と書く（人手証明の $2:=1+1$ と同じ約束）。
- **2026-08-18 の tick 399 は、章「臨界指数を零点列で書く」の先頭行「$x_c$ が実閉部分体 $R$ の元であること」の前提を固めるため、その手前に必要な補題「実閉部分体の二つの平方の和が零なら、両方が零である」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_real_closed_sum_of_two_squares_zero`（`claim_real_algebraic_order_trichotomy` の直後）: $x,y\in R$、$x\cdot x+y\cdot y=0$ ならば $x=y=0$。証明は $(x+y\omega)(x-y\omega)=x\cdot x+y\cdot y=0$ の一続き五段（`def_real_closed_subfield` の第 3 条件 $\omega\cdot\omega=-1$ を使う）と、$\overline{\mathbb Q}$ が体で零因子を持たないこと、第 4 条件（一意表示）を $0=0+0\cdot\omega$ へ当てる二つの場合分け（組 $(x,y)$ と組 $(x,-y)$）。
  理由: $x_c\in R$ の証明は $s=a+b\omega$ と分解して $2ab=0$ を出したあと、$a=0$ の枝（$b\cdot b=-2$）を潰す必要がある。そこには「$R$ の平方の和についての事実」が要り、三分法（1 つの元についての言明）だけでは足りない。まずその土台をこの補題で置いた。
  SageMath `check/real-closed-sum-of-two-squares-zero/`（5 節。$R$ のモデルは `AA`、$\omega$ は `QQbar(I)`。鎖の各段・結論・一意表示の使い方・$R$ の外では平方の和が零になりうること（仮定が本質であることの確認）。厳密。通過）。Lean 具体版 `FisherZero/RealClosedSumOfTwoSquaresZero.lean`（`zero_decomposition_unique`・`realClosed_sq_add_sq_eq_zero`）、必要十分版 `NecSuf/FisherZero/RealClosedSumOfTwoSquaresZero.lean`（`sq_add_sq_eq_zero_factor_necSuf`。部分体も一意表示も落とし、可換整域で「どちらかの因子が零」まで）、導出版。sorry 検査 1383 件・check 489 ブロック・verify-check-linkage 274 件・build:pdf 266 ページ通過。
  台帳のセクション表に「$R$ では $2$ が平方である（$-2$ は平方でない）」の行を $x_c\in R$ の前へ足した。**ここが唯一の未固めの論点である。**
- **2026-08-18 の tick 398 は、最終章「臨界指数を零点列で書く」の唯一のセクション「先頭零点の列と有限サイズスケーリング」を論法単位の 7 行へ割り直し、着工計画を確定した（前進は割り直しのみ。数学ブロックは足していない）。**
  内訳: $x_c$ が実閉部分体 $R$ の元であること／臨界点への距離の二乗 $\mathrm{dsq}_c$ の定義／$R$ の空でない有限集合の最小元／$\mathcal F_L$ が空でないこと（$L\ge2$）／先頭距離 $d_1(L)$ の定義と正値性／詰め寄りの述語との接続／有限サイズスケーリングの読み（ここだけ ℝ 脱出）。割った理由: 先頭距離 $d_1(L):=\min_{\xi\in\mathcal F_L}\mathrm{dsq}_c(\xi)$ の定義には「臨界点への距離」「最小元の存在」「零点集合の非空性」という独立の論法が前置きに要り、さらに着手時の確認で、距離の成分分解の前提になる $x_c\in R$ が本文にも Lean にも未確立だと分かったため（$s=a+b\omega$ の $\omega$ 成分と平方の三分律で示す計画を備考に書いた）。$L=1$ は辺が両方自己ループで $Z_1$ が定数になり $\mathcal F_1=\varnothing$ なので、非空性は $L\ge2$ に限る。
  レビュー: tick 397 の挟み込み（本文の定義 1 つ・主張 2 つ・SageMath `check/fisher-zero-mult-count-squeeze/`・Lean `FisherZeroMultCountSqueeze.lean`）を突き合わせ、一致した。修正 1 件 — 本文末尾「この先に書くこと」に済んだ「零点密度の挟み込み」の項目が残っていたので消した（check 488 ブロック通過を確認して先に push 済み）。
- **2026-08-17 の tick 397（launchd の即時起動で走った 23:28 の tick が使用量クレジット切れで異常終了したため、その残骸を人手のセッションが拾って完成させた）は、台帳の先頭行「零点密度の挟み込み $N_L\le N^{\mathrm{mult}}_L\le2L^2$」を四層で閉じた。これで章「熱力学極限」の todo は尽きた（住処 Qbar、脱出なし）。**
  `claim_fisher_zero_count_le_mult_count`: $N_L(c,r)\le N^{\mathrm{mult}}_L(c,r)$（円板内の各零点で $\mathrm{aev}_\xi(\widehat{Z_L}^{\,F})=0$ から重複度が 1 以上、有限和の単調性）。`claim_fisher_zero_mult_count_le_edge_bound`（**主定理の印**）: $N^{\mathrm{mult}}_L(c,r)\le2L^2$（`claim_qbar_finite_root_multiplicity_sum_le_coeff_bound` を $n:=2L^2$ で当てる。非零性と係数の上界は `claim_partition_polynomial_qbar_lift_nonzero_coeff_bound`）。
  SageMath `check/fisher-zero-mult-count-squeeze/`（4 節。$L=1,2$、中心 3 × 半径 3 の有理円板 9 組。重複度は割り切る指数の最大元として計算し、密度の上界 2 も確認。`QQbar`・`AA` 厳密。通過）。Lean 具体版 `ThermodynamicLimit/FisherZeroMultCountSqueeze.lean`（`one_le_fisherZeroMultiplicity`・`fisherZeroCount_le_fisherZeroMultCount`・`fisherZeroMultCount_le_edge_bound`）、必要十分版 `NecSuf/.../FisherZeroMultCountSqueeze.lean`（`card_le_sum_of_one_le_necSuf`。零点も重複度も落として「各点で 1 以上なら和は個数以上」だけにした）、導出版。`Finset.sum_const` は `ℕ` では `smul` になるので `Finset.card_eq_sum_ones` を使う。sorry 検査 1380 件・check 488 ブロック・verify-check-linkage 273 件・build:pdf 265 ページ通過。
  レビュー: 本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致を確認した。「何も言っていない主張」の観点で、Lean にだけあった二つの不等式を論理積へ包む未参照定理を削除した。式変形統一は姉妹側「$B_1(\theta)B_2B_1(\theta)=A(\theta)$」の Step 5 で、散文内の $\gamma_2(-\theta)$ の二段の等式を一続きの鎖と行末根拠へ揃えた（内容は不変）。
  運用: 23:28 の tick は専用アカウント（coding-agent-0001）で 3 分半ほど実際に作業してから「You're out of usage credits.」で落ちた（モデル単位の上限ではなくクレジット切れ）。**アカウント固定そのものは効いている**。残骸は目印どおり拾い、目印を消した。
- **2026-08-17 の tick 396 は、台帳の先頭行「零点密度: 重複度付きの個数 $N^{\mathrm{mult}}_L(c,r)$ の定義」を本文と Lean 具体版で閉じた（定義ブロックなので必要十分版と SageMath は置かない。住処 Qbar、脱出なし）。**
  `def_fisher_zero_mult_count_in_rational_disc`（「この先に書くこと」の直前）: $N^{\mathrm{mult}}_L(c,r):=\sum_{\xi\in\mathcal F_L\cap D(c,r)}\mathrm{mult}_\xi(\widehat{Z_L}^{\,F})\in\mathbb N$。和を取る集合が有限であることは `def_fisher_zero_count_in_rational_disc` で見たとおりで、各点の重複度が定まる根拠は前 tick の `claim_partition_polynomial_qbar_lift_nonzero_coeff_bound`（持ち上げが零でない）。和を取る集合の元の個数はちょうど $N_L(c,r)$ であり、$N_L$ との違いは「各元を 1 と数えるか重複度と数えるか」だけである。
  Lean 具体版 `ThermodynamicLimit/FisherZeroMultCountInRationalDisc.lean`（`fisherZeroMultCountIndex`（有限集合を `Finset` として読む）・`fisherZeroMultCountInRationalDisc`（`Finset.sum`）・`mem_fisherZeroMultCountIndex`・`fisherZeroMultCount_index_card`（`Set.ncard_eq_toFinset_card`。`ncard_eq_toFinset_card'` は `Fintype` を要求して通らない））。`Ising2DLambda.lean` に import 追加。lake build・sorry 検査 1376 件・check 486 ブロック・verify-check-linkage 272 件・build:pdf 264 ページ通過。
  併せて、tick の Claude 実行をこのループ専用アカウント（coding-agent-0001）へ固定した（コミット 2ca942c9）。共有の既定設定ディレクトリを使っていたため、共有アカウントが Fable 5 のモデル単位の上限に達した 23:05 の tick が exit 1 になっていた。モデル（claude-fable-5 / medium）も CLI も変えていない。資格情報が無ければ既定アカウントへ落ちずエラーで終える。
- **2026-08-17 の tick 395 は、台帳の先頭行「零点密度: 重複度付きの個数と挟み込み」を三行へ割り（持ち上げた分配多項式が零でなく係数の上界が $2L^2$ であること／$N^{\mathrm{mult}}_L$ の定義／挟み込み）、その最初を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_partition_polynomial_qbar_lift_nonzero_coeff_bound`（`claim_fisher_zero_finset_card_bound` の直前、住処 Qbar）: $L\ge1$ について、(1) $\mathrm{ac}_k(\widehat{Z_L}^{\,F})=\Omega_L(k)$（$k\le2L^2$）・$=0$（$2L^2<k$）、(2) $\widehat{Z_L}^{\,F}\ne0$、(3) $2L^2<k$ で係数が零。理由: 重複度 $\mathrm{mult}_\xi(\widehat{Z_L}^{\,F})$ が定まるには持ち上げが零でないことが要り、和の上界には係数の上界が要る。どちらも `claim_fisher_zero_finset_card_bound` の証明の中に埋まっていて引けなかったので、独立の主張へ持ち上げ、元の証明はこの主張を引く形へ直した（議論の重複を作らない）。
  SageMath `check/partition-polynomial-qbar-lift-nonzero-coeff-bound/`（3 節。$L=1,2,3$。分配多項式は配位から作り、多重度の列は独立に数える。係数の総和が $2^{L^2}$ であることも確認。`QQbar` 厳密。通過）。Lean は既存の `integerPolynomialQbarLift_partitionPolynomial_ne_zero` と `..._coeff_eq_zero_of_lt` を引くので新規ファイルは無し。check 485 ブロック・verify-check-linkage 272 件・build:pdf 264 ページ通過。
  式変形統一: 姉妹側「$c_2^*=s_2^*c_2$」（`008_TV1_hatZ_hatY_part1.ts`）で、散文中の一行の鎖 $c_2^*=\frac{c_2}{s_2}=c_2\cdot\frac1{s_2}=c_2s_2^*=s_2^*c_2$ を一続き四段（行末根拠つき）へ揃えた（内容は不変）。姉妹側 check・PDF 325 ページ通過。
  レビュー: 前 tick の `claim_qbar_finite_root_multiplicity_sum_le_coeff_bound` の本文（係数上界の帰納法）と Lean を突き合わせ、一致した。修正なし。
- **2026-08-17 の tick 394 は、台帳の先頭行「零点密度: 有限集合上の根の重複度の和は係数の上界を超えない」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_qbar_finite_root_multiplicity_sum_le_coeff_bound`: $f\ne0$ かつ $n<i\Rightarrow\mathrm{ac}_i(f)=0$ ならば、任意の有限集合 $s\subset\overline{\mathbb Q}$ について $\sum_{w\in s}\mathrm{mult}_w(f)\le n$。係数上界 $n$ の帰納法で、正の重複度を持つ一点 $w_0$ の一次因子を割り出し、$w_0$ には `claim_qbar_root_multiplicity_le_quotient_succ`、残りの点には `claim_qbar_other_root_multiplicity_le_quotient` を当てた。
  SageMath `check/qbar-finite-root-multiplicity-sum-le-coeff-bound/`、Lean 具体版・有限和比較だけへ落とした必要十分版・導出版を追加。check 484 ブロック、verify-check-linkage 271 件、sorry 検査 1376 件、PDF 264 ページ通過。式変形統一は姉妹側「$T$ の（定数倍を除いた）単射性」の Step 4 冒頭の二つの同値を、一続き二段・行末根拠つきへ揃えた（内容は不変）。姉妹側 check 300 ブロック・PDF 325 ページ通過。
  レビュー: 前 tick の `claim_qbar_other_root_multiplicity_le_quotient` の本文・SageMath・Lean 具体版・必要十分版からの導出版を突き合わせ、一致したので修正なし。「何も言っていない主張」の観点では、$g\ne0$ は重複度の well-defined 性を担い、主不等式は今 tick の帰納法が残りの各点へ繰り返し使うため、いずれも残す。
- 全章（何も言っていない主張の一掃）: 1 セクション
- 零点の詰め寄り・固有値の代数性（本文の lean: から引かれていない Lean の配線）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 臨界指数を零点列で書く | $R$ の空でない有限集合は最小元をちょうど 1 つ持つ | todo | 推移律は tick 403 で用意した（`claim_real_algebraic_order_transitive`）。三分法と推移律と有限集合の帰納法。先頭距離の well-defined 性に要る。`claim_row_config_min_unique` と同じ骨組み |
| 臨界指数を零点列で書く | $\mathcal F_L$ が空でないこと（$L\ge2$） | todo | 定数でないこと（1 スピンだけ反転した配位に破れボンドがあるので $\exists m\ge1,\ \Omega_L(m)\ge1$）と `def_algebraic_numbers` の代数閉性。$L=1$ は両辺とも自己ループで $Z_1$ が定数になるので除く（着手時に SageMath で確認してから書く） |
| 臨界指数を零点列で書く | 先頭距離 $d_1(L)$ の定義と正値性 | todo | $d_1(L):=\min_{\xi\in\mathcal F_L}\mathrm{dsq}_c(\xi)\in R$。正値性は $x_c\notin\mathcal F_L$（係数が自然数で $x_c$ が正錐 $P_s$ の元なので値が正錐に入る。`claim_positive_rational_not_fisher_zero` と同じ論法） |
| 臨界指数を零点列で書く | 先頭距離の列と詰め寄りの述語の接続（可算な言明） | todo | $\{d_1(L)\}_{L\ge2}$ と `def_zero_pinching_predicate` を結ぶ。量化は $\mathbb Q$ 上 |
| 臨界指数を零点列で書く | 有限サイズスケーリングの読み（ℝ 脱出） | todo | 距離列の増大率と指数 $\nu$ の読み取り。実対数・極限を使うのでここだけ脱出を宣言する。厳密に言える範囲は討議ノート「何が厳密で何が非厳密か」に従って絞る |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-18（tick 403）: 最小元の行の前提として欠けていた狭義順序の推移律を四層で閉じ、`claim_real_algebraic_order_transitive` を `claim_two_is_square_in_real_closed` の直後に置いた（本文の三分法は網羅性だけで、推移律は無かった）。直近 2 tick の 2 補題（平方の和が平方・平方の和が零なら各項が零）から出る。SageMath 3 節、Lean 具体版・必要十分版（2 性質を仮定に取る可換環の形）・導出版。sorry 検査 1394 件・check 494 ブロック・PDF 268 ページ通過。
- 2026-08-18（tick 402）: 台帳の先頭行「臨界点への距離の二乗の定義」を本文と Lean 具体版で閉じた（定義ブロック）。第 2 引数を $R$ の元へ広げた $\mathrm{dsq}_R$ を定義し、有理点の場合が既存の $\mathrm{dsq}$ と一致することを明記して、$\mathrm{dsq}_c(\xi):=\mathrm{dsq}_R(\xi,x_c)$ と置いた。check 493 ブロック・PDF 267 ページ通過。
- 2026-08-18（tick 401）: 台帳の先頭行「$x_c$ が実閉部分体 $R$ の元であること」を四層で閉じ、`claim_critical_point_mem_real_closed`（主定理の印）を `claim_two_is_square_in_real_closed` の直後に置いた。$s=a+b\omega$ の一意表示から $2ab=0$ を読み、$a=0$ の枝を前 tick の $-2$ の非平方性で潰した。SageMath 5 節、Lean 具体版（`sqrtTwo_mem_realClosed`・`criticalPoint_mem_realClosed`）。sorry 検査 1390 件・check 492 ブロック・PDF 267 ページ通過。
- 2026-08-18（tick 400）: 台帳の先頭行「$R$ では $2$ が平方である（$-2$ は平方でない）」を四層で閉じた。前 tick が「唯一の未固めの論点」と記録した箇所。鍵は順序ではなく代数閉性で、$u\cdot u=x+y\omega$ の一意表示と Gauss の恒等式から平方の和が平方であることを出し、$x=y=1$ で $2$ の平方性を得た。SageMath 4 節、Lean 具体版・必要十分版（Gauss の恒等式のみ。可換環）・導出版。sorry 検査 1388 件・check 491 ブロック・PDF 266 ページ通過。
- 2026-08-18（tick 399）: 章「臨界指数を零点列で書く」の先頭行の前提として「実閉部分体の二つの平方の和が零なら両方が零である」を四層で閉じ、`claim_real_closed_sum_of_two_squares_zero` を三分法の直後に置いた（$(x+y\omega)(x-y\omega)$ の因数分解と一意表示。三分法だけでは和について何も言えないため）。SageMath 5 節（`AA` と `QQbar(I)` のモデル）、Lean 具体版・必要十分版（可換整域で因子が零まで）・導出版。sorry 検査 1383 件・check 489 ブロック・PDF 266 ページ通過。セクション表に「$R$ では $2$ が平方である」の行を $x_c\in R$ の前へ足した。
- 2026-08-18（tick 398）: 最終章「臨界指数を零点列で書く」の唯一のセクションを論法単位の 7 行へ割り直した（$x_c\in R$／$\mathrm{dsq}_c$ の定義／$R$ の有限集合の最小元／$\mathcal F_L\ne\varnothing$（$L\ge2$）／$d_1(L)$ の定義と正値性／詰め寄りの述語との接続／スケーリングの読み（ℝ 脱出））。理由: 先頭距離の定義に独立の前置きが 4 つ要り、うち $x_c\in R$ は未確立だと着手時の確認で分かったため。数学ブロックは足していない。
- 2026-08-17（tick 397）: 台帳の先頭行「零点密度の挟み込み」を四層で閉じ、章「熱力学極限」の todo が尽きた。$N_L\le N^{\mathrm{mult}}_L$（各項 1 以上と有限和の単調性）と $N^{\mathrm{mult}}_L\le2L^2$（重複度の和の上界。主定理の印）。SageMath 4 節（$L=1,2$・円板 9 組）、Lean 具体版・必要十分版（「各点で 1 以上なら和は個数以上」だけへ落とした）・導出版。sorry 検査 1380 件・check 488 ブロック・PDF 265 ページ通過。launchd 即時起動の tick がクレジット切れで残した書きかけを拾って完成させた。
- 2026-08-17（tick 396）: 台帳の先頭行「重複度付きの個数 $N^{\mathrm{mult}}_L(c,r)$ の定義」を本文と Lean 具体版で閉じた（定義ブロック）。和を取る有限集合は $\mathcal F_L\cap D(c,r)$、重複度が定まる根拠は前 tick の持ち上げの非零性。Lean は `Finset.sum` と `Set.ncard_eq_toFinset_card`。check 486 ブロック・PDF 264 ページ通過。併せて tick の Claude 実行をこのループ専用アカウントへ固定（モデルは claude-fable-5 のまま。共有アカウントの上限でループが止まっていたため）。
- 2026-08-17（tick 395）: 台帳の先頭行「零点密度: 重複度付きの個数と挟み込み」を三行へ割り（持ち上げの非零性と係数の上界／$N^{\mathrm{mult}}_L$ の定義／挟み込み。理由: 重複度が定まる前提と和の上界の前提が、既存の証明の中に埋まっていて引けなかったため）、その最初 `claim_partition_polynomial_qbar_lift_nonzero_coeff_bound` を四層で閉じた。既存 `claim_fisher_zero_finset_card_bound` の証明からその議論を持ち上げ、元の証明はこの主張を引く形へ直した。SageMath 3 節（$L=1,2,3$）、Lean は既存定理を引くので新規なし。check 485 ブロック・linkage 272 件・PDF 264 ページ通過。式変形統一: 姉妹側 $c_2^*=s_2^*c_2$ の一行の鎖を一続き四段（行末根拠つき）へ揃えた。姉妹側 check・PDF 325 ページ通過。
- 2026-08-17（tick 394）: 台帳の先頭行「零点密度: 有限集合上の根の重複度の和は係数の上界を超えない」を四層で閉じた。係数上界の帰納法で正の重複度を持つ一点の一次因子を割り出し、その点の重複度は高々 1 だけ減ること、他の各点の重複度は失われないこと、商の係数上界が 1 下がることを組み合わせた。式変形統一は姉妹側「$T$ の（定数倍を除いた）単射性」Step 4 冒頭の同値の鎖を揃えた。
## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

- 2026-08-18（tick 402）: 姉妹側のフェルミオン証明（`008_TV1_hatZ_hatY_part2.ts`）で、a) の係数の括弧を因数分解する三段の式を、一続きの式変形と行末根拠へ揃えた（内容・参照は不変）。姉妹側 check・PDF 325 ページ通過。

- 2026-08-18（tick 398）: 姉妹側「行列の内積とノルム」（`005_exp_conjugation_proof.ts` の Step 4）で、散文中に埋まっていた鎖 $\sum_{i,j}|a_{ij}|^2=\|A\|^2$ すなわち $\langle A,A\rangle=(\|A\|^2)_{\mathbb C}$ を、一続き二段（行末根拠つき。上の鎖／ノルムの定義）へ揃えた（内容・参照は不変）。姉妹側 check・PDF 325 ページ通過。姉妹側の残りは 004 のその他・005 の Step 3 以降の残り・008 系の以降の節。005 の `ad`・内積の同値の鎖（1183 行・463 行付近）は statement の記法注記なので対象外と確認した（対象は証明の散文中の鎖）。

### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録
- 2026-08-18（tick 402）: tick 401 の「臨界点が実閉部分体の元であること」の本文・SageMath・Lean を突き合わせ、論法の一致を確認した。この主張は値の住処を確定し、今 tick の定義が直接引くため「何も言っていない主張」ではない。修正なし。今 tick の初稿は 1 ブロック内の二定義と未使用の一致補題を削除した。
- 2026-08-18（tick 398）: tick 397 の「零点密度の挟み込み」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。修正 1 件: 本文末尾「この先に書くこと」に済んだ「零点密度の挟み込み」の項目が残っていたので消した（runbook「項目が済んだら消す」）。
- 2026-08-17（tick 394）: 前 tick の「相異なる点の重複度は、一次因子を割り出した商へ引き継がれる」の本文・SageMath・Lean 具体版・必要十分版からの導出版を突き合わせ、一致した。修正なし。「何も言っていない主張」の観点では、$g\ne0$ は重複度の well-defined 性を担い、主不等式は今 tick の帰納法が残りの各点へ繰り返し使うため残す。
- 2026-08-17（tick 393）: 前 tick の「一次因子を 1 つ割り出すと、その点の重複度は 1 しか下がらない」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 前 tick の主張は重複度の和の帰納法が割り出した点へ使い、今 tick の主張は同じ帰納法が残りの各点へ繰り返し使うので、いずれも独立した内容を持つ。$g\ne0$、$M=0$ の場合、$M'+1\le\mathrm{mult}_w(g)$ からの読み替えは証明内に置き、独立ブロックにしていない。
- 2026-08-17（tick 390）: 前 tick の「Bezout 恒等式は、もう一方の元の冪についても構成できる（帰納法）」の本文（帰納法。出発点五段・一歩七段）と Lean 具体版（`qbarBezoutPowerPropagation`）・必要十分版（`bezout_power_propagation_necSuf`。可換環のみ）を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の主張（二度適用で $(t-\widehat w)^{k+1}$ と $(t-\widehat{w'})^{m+1}$ を結ぶ）は次の「互いに素な整除からの商への整除の遺伝」が直接引く構成的な結果であり、単なる言い換えではないので独立ブロックとして残す。入れ替えた組 $(a',b',p',q')$ の読み替えは証明中の一行に置き、独立ブロックにしなかった。
- 2026-08-17（tick 389）: 前 tick の「相異なる代数的数に対応する一次因子は互いに素である（明示的な Bezout 恒等式）」の本文（一続き六段）と Lean 具体版（`qbarDistinctLinearFactorsBezout`）・必要十分版（`distinct_linear_factors_bezout_necSuf`。環の分配則 1 本）を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の主張（Bezout 恒等式の冪への伝播）は、次の「一次因子の冪どうしが互いに素であること」が $a,b$ を入れ替えて二度引く形で使う一般補題であり、単独では何も新しい情報を持たない散文ではなく、構成的な帰納法そのものが主張の中身なので独立ブロックとして残す。$P_{n+1},Q_{n+1}$ の定め方は独立ブロックにせず証明中の一行に置いた。
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

停止・再開・頻度変更は、**自分で `launchctl` を叩かず** tmux セッション `local-pc-management` の
ウィンドウ `tick窓口` へ依頼する（2026-08-16 に経路が固定された。`launchd-tick-loop` skill）。
