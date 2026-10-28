# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-10-28（連続実行）、分散因子の自己双対性を四層で示した。** 次は研究管理が先頭に置いた分散因子の定義と Kac--Ward 行列式のモード積公式を進める。

行列式の乗法性とスカラー倍を支える道具の五節、完全マッチングと対合の対応・符号の独立性・Pfaffian の平方展開・不動点項の消去・不変部分集合上の反転・反転と反復の対応・軌道の台と長さの保存・台の不変性・始点変更による台の一致・奇数軌道の最小元による選択不変性・選んだ軌道の反転による対合・その非自明性・反転の符号保存・反対称成分の積の符号反転・奇数軌道を持つ置換の符号付き和の相殺・交互の二色付けからの完全マッチングの構成の十六節、端末行列の行列式一致への根拠の接続、および対角相似とスカラー倍による行列式の保存が完了（内訳は MEMORY と保管庫）。有限写像の反復の加法則、有限置換の反復の単射性と正の最小周期と最小周期未満の反復回数の一意性、軌道の巡回表示と長さの一致、偶数軌道の最小元を起点とする二色付け、ゲージ重みの非零性も四層で完了。

ブロックを保つ置換の符号の積は四層で完了した。

終点と方向による向き付き辺の全単射は四層で完了した。

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| Onsager 閉形式への接続 | 分散因子の定義と Kac--Ward 行列式のモード積公式 | 未着手 | 分散因子を名前の付いた定義ブロックにする: $\Delta(x;\varpi,\varsigma):=(1+x^2)^2-x(1-x^2)(\varpi+\varpi^{-1}+\varsigma+\varsigma^{-1})\in\overline{\mathbb Q}[x]$（多項式）と、その $q\in\overline{\mathbb Q}$ での値 $\Delta(q;\varpi,\varsigma)$ を区別して書く。そのうえで $D^{a,b}_L(x)=\prod_{(\varpi,\varsigma)\in\mathcal U_a\times\mathcal W_b}\Delta(x;\varpi,\varsigma)$ を、`claim_fourier_similarity_preserves_determinant`・`claim_fourier_block_fiber_determinant_product`・`claim_fourier_fiber_direction_determinant`・`claim_mode_small_matrix_determinant_dispersion` の合成として一つの定理にし、有限 Fourier 分解の章の主定理（`standing: \"mainTheorem\"`）にする（章に主定理が一つも無い。README「各章には主定理が少なくとも 1 つ」）。全単射 $\kappa$ に依らない形で述べる。`claim_untwisted_mode_zero_condition` は文中で $\Delta(q;1,1)$ を定義し直しているので、新しい定義を引く形へ直す。記号 $\Delta$ は「低温展開の自明セクター表示」の証明の中で全単射 $\Delta_L$ にも使われているので、その証明内の名前を別の文字へ替える（1 記号 1 意味）。指示書 `assemble-finite-volume-closed-product.md` の 3 が引く等式であり、軌道ごとの明示積・正値性・Riemann 和の全てがこの形を使う（2026-10-28 の研究管理）。 |
| Onsager 閉形式への接続 | 分散因子の正値性の分解 | 未着手 | $\overline{\mathbb Q}[x]$ で $\Delta(x;\varpi,\varsigma)-(x^2+2x-1)^2=x(1-x^2)\bigl((2-\varpi-\varpi^{-1})+(2-\varsigma-\varsigma^{-1})\bigr)$ を示す。直前の分散因子の定義を引く。指示書 `prove-twists-share-thermodynamic-limit.md` の 2。 |
| Onsager 閉形式への接続 | 分散因子の特殊モードでの平方分解 | 未着手 | $(1,1)$、$(1,-1)$、$(-1,1)$、$(-1,-1)$ の四つを評価し、それぞれの平方因子を示す。直前の分散因子の定義を引く。指示書 `assemble-finite-volume-closed-product.md` の 4。 |
| Onsager 閉形式への接続 | 平方恒等式: 閉歩道の位相と二次符号の一般形 | 未着手（記述・SageMath を先に行う） | 台の辺が相異なる閉歩道について $-(\prod\varepsilon_{a,b})\zeta_8^{t_\circ}=\chi_{a,b}(h,v)(-1)^{t}$。頂点単純の場合は済（`claim_vertex_simple_orbit_quadratic_sign`）。横断消去と接触点分割で落とす。混合横断数の偶奇と交差形式の補題が新しく要る。指示書の節 6。 行「頂点単純な置換軌道の位相因子はトーラスの巻き付き二次符号に等しい」の主張を、この節で使う「台の辺が相異なる閉歩道」の言葉で引けるかを先に確かめ、必要なら言い換えの主張を記述と SageMath で足す。 **記述と SageMath までをここで行い、Lean 二版は離散 Whitney 系の Lean 配線の後の行「平方恒等式の節 6〜9 の Lean 二版」で書く**（2026-10-28 の研究管理）。 |
| Onsager 閉形式への接続 | 平方恒等式: マッチングの符号と基準マッチングの比較 | 未着手（記述・SageMath を先に行う） | $\operatorname{sgn}(\mathcal D)\prod K^{\mathrm{as}}$ を閉路ごとの寄与へ分解し、$U$ と $\zeta_8^{\,2}$ の因子が閉路に沿って打ち消すことを示す。指示書の節 7。 節 7 の等式は、研究管理（2026-10-07）が辺長 1〜3・四つのスピン構造の全ての標識付きマッチングについて厳密計算で確かめた。$t(\mathcal D)$ の定義は指示書の節 7（同じ頂点の二つの短い対が、ともに逆向きの二辺の対で軸が異なる組の個数）。 **記述と SageMath までをここで行い、Lean 二版は離散 Whitney 系の Lean 配線の後の行「平方恒等式の節 6〜9 の Lean 二版」で書く**（2026-10-28 の研究管理）。 |
| Onsager 閉形式への接続 | 平方恒等式: 局所対合の符号付き和 | 未着手（記述・SageMath を先に行う） | 各偶部分グラフの上で $\sum(-1)^{t(\mathcal D)}=1$（次数 4 の頂点で $1+1-1$）。指示書の節 8。 辺長 1〜3 の全ての偶部分グラフで確認済み（研究管理 2026-10-07）。 **記述と SageMath までをここで行い、Lean 二版は離散 Whitney 系の Lean 配線の後の行「平方恒等式の節 6〜9 の Lean 二版」で書く**（2026-10-28 の研究管理）。 |
| Onsager 閉形式への接続 | 平方恒等式の合成: 符号付き偶部分グラフ多項式は Kac--Ward 行列式の多項式平方根 | 未着手（記述・SageMath を先に行う） | $\operatorname{Pf}(K^{\mathrm{as}})=Q^{a,b}_L$（線型順序を $(e,d)$ の辞書式に取れば符号は $+1$。指示書の節 9。辺長 1〜3 で確認済み、研究管理 2026-10-07）、$D^{a,b}_L=(Q^{a,b}_L)^2$、$Q^{a,b}_L(0)=1$ と 台帳の先頭で整備する多項式平方根の一意性から $Q^{a,b}_L$ は $D^{a,b}_L$ の定数項 1 の多項式平方根。有限トーラス公式の行と合わせて $Z_L=\frac12\sum_{(a,b)}\sqrt{D^{a,b}_L}$（四項とも符号は正）。**Arf 符号付き四項和と高温展開の恒等式は使わない**（2026-10-09 の研究管理）。指示書 `assemble-finite-volume-closed-product.md` の 2・3。 **記述と SageMath までをここで行い、Lean 二版は離散 Whitney 系の Lean 配線の後の行「平方恒等式の節 6〜9 の Lean 二版」で書く**（2026-10-28 の研究管理）。 |
| 全章 | Lean 具体版の必要十分版への委譲を外す: 平方恒等式の経路以外 | 未着手 | `lean:` に登録された具体版のうち、証明の中で必要十分版の定理を呼ぶもの: 道具の章の `matchingPair_evenColor_eq`・`qbarPolynomial_noninjective_inner_sum_zero`、Kac--Ward 章の `reversal_involutive`・`reversal_ne`・`spinStructures_card`・`transitionEntry_mem_mu8`・`kacWardDeterminantEntryProduct_ne_zero_iff`・`signedEvenSubgraphPolynomial_eq_sectorSum`・`walkTwistSign_product`・`vertexIncidentEdgeTraversal_even`・`firstHitConnectingStaircase_meets_lifts_only_at_ends`・`iteratedTransverseStaircase_ne_periodicPlaneLift_of_band_top`、置換展開の章の `movedEdgeOrbitSet_partition`・`kacWardSignedPermutationTerm_orbit_product`・`kacWardEntryProduct_orbit_factorization`・`kacWardSignedPermutationTerm_orbit_phase_twist`・`reversalFreeMovedSupport_even`・`reversalFreeOrbitSupportEdges_distinct`・`reversalFreeOrbit_vertexSimpleDecomposition`・`crossingFreeSignCounterexample`、臨界指数の `criticalPoint_exists_positiveRational_squareDiff_lt`・`leadingDistance_pinching_implies_predicate`。平方恒等式の節 6 と離散 Whitney 系の Lean 配線が引くものから先に直す。 **主張が必要十分版の定義で述べられているものも同じ扱いにする**: 道具の章の $\overline{\mathbb Q}$ 係数多項式行列式の具体版（約 40 ファイル）は置換の符号を必要十分版の `NecSuf.AlgebraicEigenvalue.sign` で述べている。具体版の符号の定義を置き（整数行列の具体版の `permSign` と同じ形）、必要十分版の符号との一致は導出版へ寄せる（2026-10-27 の研究管理）。「直接比較経路の退避」で参照用ノートへ移すブロックの Lean は、退避で片付けるので直さない（依存で確かめてから判断する）。一つの論法ごとに行を割ってから着手する。 **直す対象の正本は `lean/concrete-necsuf-delegations.txt`（委譲検査の既知の例外。2026-10-28 時点で 46 件）である。** 上の列挙に無いものも含む: ブロック対角行列の行列式の具体版五件（`blockDiagonal_*`。主張が必要十分版の置換の符号で述べられている）、`qbarPolynomial_det_*` など道具の章の多項式行列式の五件、標識付き対称差と活動点の七件（`taggedDifference_*`・`taggedActive*`。必要十分版の `taggedPairAt` を使う）、`localPairingMatching`・`localPairingMatching_mate`（必要十分版の `splicePairings` を使う）、`matchingPairOrientationProduct`・`matchingPairSecondOrientationProduct`、`directionNumber_reversal`、`polynomialOrientedIdentity_determinant`。2026-10-26・27 の研究管理が足した行は台帳から消えたが、これらは例外の台帳に残っており、委譲は解消していない。この行を消してよいのは例外の台帳が空になったときだけである（2026-10-28 の研究管理）。 |
| Onsager 閉形式への接続 | Kac--Ward 章の定義の Lean 対応を揃える | 未着手 | Lean に定義があるのに `lean:` を宣言していない定義ブロック（向き付き辺の集合、向き付き辺の方向番号、四つの Kac--Ward 多項式行列 など）へ宣言を足す。Lean に無い定義（閉じた非後退辺列、一歩の回転数、向き付き辺の行変位と列変位、閉歩道の向き付き切断線横断数、非後退辺列の平面持ち上げ など）を、実際の閉歩道から構成する形で定義する。離散 Whitney 系の Lean は点列 `base` を仮定で受ける形なので、この定義群が無いと具体版が本文の対象について述べていない（2026-10-04 の研究管理の判定。2026-10-05 の実測では、Kac--Ward 章の定義 109 件のうち 76 件、主張 176 件のうち 57 件に `lean:` が無い。2026-10-04 以降に置いた節の定義・主張は全て Lean 付き）。 |
| Onsager 閉形式への接続 | 一歩は方向番号を回転数だけ進める | 記述・SageMath 済。Lean 二版は未着手 | 本文ブロックに `lean:` が無い。既存の Lean に対応物があれば宣言を足し、無ければ具体版・必要十分版を書く。実際の閉歩道・持ち上げについて述べる形にする。 |
| Onsager 閉形式への接続 | 整数巻き付き数の偶奇は切断線偶奇に等しい | 記述・SageMath 済。Lean 二版は未着手 | 本文ブロックに `lean:` が無い。既存の Lean に対応物があれば宣言を足し、無ければ具体版・必要十分版を書く。実際の閉歩道・持ち上げについて述べる形にする。 |
| Onsager 閉形式への接続 | 剰余類を一つ進めたときの代表 | 記述・SageMath 済。Lean 二版は未着手 | 本文ブロックに `lean:` が無い。既存の Lean に対応物があれば宣言を足し、無ければ具体版・必要十分版を書く。実際の閉歩道・持ち上げについて述べる形にする。 |
| Onsager 閉形式への接続 | 辺ごとの代表座標の差は変位と切断線補正の和である | 記述・SageMath 済。Lean 二版は未着手 | 本文ブロックに `lean:` が無い。既存の Lean に対応物があれば宣言を足し、無ければ具体版・必要十分版を書く。実際の閉歩道・持ち上げについて述べる形にする。 |
| Onsager 閉形式への接続 | 閉歩道の変位の総和は巻き付き数の L 倍である | 記述・SageMath 済。Lean 二版は未着手 | 本文ブロックに `lean:` が無い。既存の Lean に対応物があれば宣言を足し、無ければ具体版・必要十分版を書く。実際の閉歩道・持ち上げについて述べる形にする。 |
| Onsager 閉形式への接続 | 頂点単純閉路の巻き付きベクトルは零または原始的である | 記述・SageMath 済。Lean 二版は未着手 | 本文ブロックに `lean:` が無い。既存の Lean に対応物があれば宣言を足し、無ければ具体版・必要十分版を書く。実際の閉歩道・持ち上げについて述べる形にする。 |
| Onsager 閉形式への接続 | 平面変位は方向番号の方向単位ベクトルである | 記述・SageMath 済。Lean 二版は未着手 | 本文ブロックに `lean:` が無い。既存の Lean に対応物があれば宣言を足し、無ければ具体版・必要十分版を書く。実際の閉歩道・持ち上げについて述べる形にする。 |
| Onsager 閉形式への接続 | 持ち上げた隣接二歩は逆ベクトルにならない | 記述・SageMath 済。Lean 二版は未着手 | 本文ブロックに `lean:` が無い。既存の Lean に対応物があれば宣言を足し、無ければ具体版・必要十分版を書く。実際の閉歩道・持ち上げについて述べる形にする。 |
| Onsager 閉形式への接続 | 持ち上げ点の座標は終点の代表座標と切断線の部分和で書ける | 記述・SageMath 済。Lean 二版は未着手 | 本文ブロックに `lean:` が無い。既存の Lean に対応物があれば宣言を足し、無ければ具体版・必要十分版を書く。実際の閉歩道・持ち上げについて述べる形にする。 |
| Onsager 閉形式への接続 | 頂点単純閉路の一周期の持ち上げ点は相異なる | 記述・SageMath 済。Lean 二版は未着手 | 本文ブロックに `lean:` が無い。既存の Lean に対応物があれば宣言を足し、無ければ具体版・必要十分版を書く。実際の閉歩道・持ち上げについて述べる形にする。 |
| Onsager 閉形式への接続 | 持ち上げの終点は始点と巻き付きベクトルの L 倍だけ違う | 記述・SageMath 済。Lean 二版は未着手 | 本文ブロックに `lean:` が無い。既存の Lean に対応物があれば宣言を足し、無ければ具体版・必要十分版を書く。実際の閉歩道・持ち上げについて述べる形にする。 |
| Onsager 閉形式への接続 | 一側閉包の周期数差を実際の閉歩道へ接続する | 記述・SageMath 済。条件付き Lean 二版・導出版は済。具体的定義からの仮定の充足は未了 | 閉歩道から平面持ち上げ・周期延長・一側閉包を構成し、有限点列の漸化式・端点条件と非後退条件を満たすことを示して、周期数差の条件付き定理へ代入する。条件を充足する補題と組で本文の `lean:` に登録する。 |
| Onsager 閉形式への接続 | 周期単純路の循環総回転数は零 | 記述・SageMath 済。Lean 二版は未着手 | 周期数差と三周期比較の整数補題を合成する。 |
| Onsager 閉形式への接続 | 頂点単純閉路の循環総回転数は切断線偶奇で決まる | 記述・SageMath 済。Lean 二版は未着手 | 零巻き付きと非零巻き付きの結果を切断線偶奇へ接続する。 |
| Onsager 閉形式への接続 | 頂点単純な置換軌道の位相因子はトーラスの巻き付き二次符号に等しい | 記述・SageMath 済。Lean 二版は未着手 | 平方恒等式の節 6 が直接引く。旧経路の言葉（非後退置換の軌道）で書かれているので、節 6 で使う「台の辺が相異なる閉歩道」の言葉で引けるかを確かめ、必要なら言い換えの主張を足す。 |
| Onsager 閉形式への接続 | 平方恒等式の節 6〜9 の Lean 二版 | 未着手 | 先に記述・SageMath まで進めた四行（閉歩道の位相と二次符号の一般形、マッチングの符号と基準マッチングの比較、局所対合の符号付き和、平方恒等式の合成）の Lean 具体版・必要十分版を書く。具体版は実際の閉歩道・標識付きマッチングについて述べ、直前までの離散 Whitney 系の Lean 配線を引く。一つの論法ごとに行を割ってから着手する（2026-10-28 の研究管理）。 |
| Onsager 閉形式への接続 | 符号付き偶部分グラフ多項式の軌道ごとの明示積 | 未着手 | $\Delta$ は $\varpi+\varpi^{-1}$ と $\varsigma+\varsigma^{-1}$ だけで決まるので、$(\varpi,\varsigma)\mapsto(\varpi^{-1},\varsigma),(\varpi,\varsigma^{-1})$ の軌道 $O$（$|O|\in\{1,2,4\}$）の上で定数。$P^{a,b}_L:=\prod_{|O|=1}\sqrt{\Delta_O}\prod_{|O|=2}\Delta_O\prod_{|O|=4}\Delta_O^2$（$\sqrt{\Delta_O}$ は $1-2x-x^2$, $1+x^2$, $1+2x-x^2$）は平方が $D^{a,b}_L$ で定数項 1 なので $Q^{a,b}_L=P^{a,b}_L$。平方恒等式と Fourier 分解の後に進める。指示書 `assemble-finite-volume-closed-product.md` の 4（辺長 1〜3 で確認済み、研究管理 2026-10-09）。 |
| Onsager 閉形式への接続 | 1 の冪根の逆元は共役であり、分散因子は有理点で正である（実閉部分体の順序） | 未着手 | $\zeta=\alpha+\beta\omega\in\mu_n$（`def_real_closed_subfield` の一意表示）について $\zeta^{-1}=\alpha-\beta\omega$（$\tau(\alpha+\beta\omega)=\alpha-\beta\omega$ が $R$ を固定する環自己同型、ノルム $\zeta\tau(\zeta)=\alpha^2+\beta^2$ は $\ge_R0$ で $n$ 乗が 1 なので 1）。帰結 $2-\varpi-\varpi^{-1}=(1-\alpha)^2+\beta^2$ は $R$ の平方（`claim_real_closed_sum_of_two_squares_is_square`）。正値性の分解と合わせて $q\in\mathbb Q_{(0,1)}$ で $\Delta(q;\varpi,\varsigma)\ge_R(q^2+2q-1)^2>_R0$。**$|\varpi|=1$ や $\cos$ を使わない。** 指示書 `prove-twists-share-thermodynamic-limit.md` の 1・2。 |
| Onsager 閉形式への接続 | 符号付き偶部分グラフ多項式の自己双対性 | 未着手 | $\overline{\mathbb Q}[x]$ の等式 $(1+x)^{2L^2}Q^{a,b}_L(\mathrm{KW}(x))=\eta_{a,b}2^{L^2}Q^{a,b}_L(x)$（$\eta_{0,0}=-1$、他は $+1$）。分散因子の自己双対性から両辺の平方が等しく、整域で $f=\pm g$。符号は $(a,b)\ne(0,0)$ では自己双対点 $x_{\mathrm{sd}}$（$(1+x_{\mathrm{sd}})^2=2$、$Q^{a,b}_L(x_{\mathrm{sd}})\ne0$）で、$(0,0)$ では $\sum_{(a,b)}Q^{a,b}_L(1)=2^{L^2+1}$ で決める。指示書 `assemble-finite-volume-closed-product.md` の 6（辺長 1〜3 で確認済み、研究管理 2026-10-09）。 |
| Onsager 閉形式への接続 | 分配多項式の値の四つの平方根による両側評価（Λ の鎖） | 未着手 | $q\in\mathbb Q_{(0,1)}$ で $\frac14\max_{(a,b)}|Q^{a,b}_L(q)|\le Z_L(q)\le2\max_{(a,b)}|Q^{a,b}_L(q)|$、すなわち $\Lambda$ で $\log\max|Q^{a,b}_L(q)|-2\ell_2\le\Phi_L(q)\le\log\max|Q^{a,b}_L(q)|+\ell_2$。低温側 $q^2+2q-1<0$ は軌道ごとの明示積で四つとも $Q^{a,b}_L(q)>0$（下界 $\frac12$）。高温側 $q^2+2q-1>0$ は $t=\mathrm{KW}(q)$ が $t^2+2t-1=-2(q^2+2q-1)(1+q)^{-2}<0$ を満たすので、`claim_partition_value_dual_factorization`・$\sum_{(c,d)}G^{c,d}_L(t)\ge G^{0,0}_L(t)=\frac12Z_L(t)$・低温側の評価・自己双対性で $Z_L(q)\ge\frac14\max|Q^{a,b}_L(q)|$。上界は三角不等式。ねじれ間の密度差を直接評価しない。**実数への脱出は無い。** 指示書 `prove-twists-share-thermodynamic-limit.md` の 3〜6（辺長 1〜3・有理点 6 箇所で確認済み、研究管理 2026-10-09）。 |
| Onsager 閉形式への接続 | 実閉部分体の有理数による挟み込み | 未着手 | $R\subset\overline{\mathbb Q}$ の各元が満たす有理係数多項式から有理上下界を示し、Archimedes 性と任意精度の挟み込みを導く。可算側で閉じる。指示書 `pass-from-mode-sums-to-integral.md` の「実現写像の存在とモード集合の対応」。 |
| Onsager 閉形式への接続 | 実閉部分体の順序を保つ実現の構成（実数体への脱出） | 未着手 | 前節の有理数による下集合の実数上限で $\rho_R$ を構成し、四則・単位元・狭義順序の保存、有理数上の一致、単射性を示す。`def_real_closed_realization` は条件付きデータの定義なので存在証明の代用にしない。「実数体への脱出と熱力学極限」の章に置く。指示書 `pass-from-mode-sums-to-integral.md`。 |
| Onsager 閉形式への接続 | 複素実現とモード集合の全単射（複素数と指数評価への脱出） | 未着手 | $\rho_{\mathbb C}(a+b\omega)=\rho_R(a)+i\rho_R(b)$ の四則保存と単射性から、モード集合の像を $z^L=(-1)^a$ の複素根全体と同定する。直積の全単射で和を再添字付けする。固定原始根の像は指定しない。指示書 `pass-from-mode-sums-to-integral.md`。 |
| Onsager 閉形式への接続 | 実対数と Riemann 和: 四つのモード格子の極限は同じ積分（実数体への脱出） | 未着手 | 前三節で存在を証明した実現写像とモード集合の全単射を使う。正の分散因子へ実対数を適用し、半格子ずれた四つの Riemann 和が同じ積分へ収束することを示す。$\lim L^{-2}\log|Q^{a,b}_L(q)|=\frac{1}{8\pi^2}\iint_{[0,2\pi]^2}\log[(1+q^2)^2-2q(1-q^2)(\cos\theta_1+\cos\theta_2)]$。指示書 `pass-from-mode-sums-to-integral.md`。 |
| Onsager 閉形式への接続 | 下組の実現像の上限は実現した列の実数極限に等しい（実数体への脱出: 連続極限） | 未着手 | 一般の列 $(\lambda_L)_{L\ge1}\subset\Lambda_{\mathbb Q}$ と実数 $I$ について、$\rho_{\mathbb R}(\lambda_L)\to I$ なら $\sup\rho_{\mathbb R}(A((\lambda_L)))=I$（`def_rational_log_order_group_sequence_lower_set`）。上から: $0\le\varepsilon$ と `claim_rational_log_order_group_add_monotone`、`claim_rational_log_order_group_realization_monotone`、極限の順序保存。下から: $\mathbb R$ の Archimedes 性で $\iota(\ell_2)$ の有理数倍 $(k/n)\iota(\ell_2)$・$(1/n)\iota(\ell_2)$ を証人に取り、`claim_rational_log_order_group_realization_smul`・`claim_log_order_group_realization_real_log`・全順序性で $\mu+\varepsilon\le_{\Lambda_{\mathbb Q}}\lambda_L$ を出す（実現写像の加法性は本文に無いが、この取り方なら要らない。足さない）。既存の密度 `def_periodic_free_energy_density_le_one`（下組の実現像の上限）と Riemann 和の極限を結ぶ唯一の橋。Ising を参照しないが実数体へ脱出するので「実数体への脱出と熱力学極限」の章（`def_open_square_free_energy_density` の近く）に置く。両包含 1 組（一つの論法）。指示書 `identify-onsager-closed-form-and-critical-point.md` の「密度との同定の橋」（2026-10-10 の研究管理）。 |
| Onsager 閉形式への接続 | Onsager 閉形式との同定と臨界点 | 未着手 | 両側評価と Riemann 和から、既存の実数値密度 `def_periodic_free_energy_density_le_one` が上の積分に等しいことを示す。代数的略記 $\cosh2K=(1+q^2)/(2q)$、$\sinh2K=(1-q^2)/(2q)$ で $\log2+\log q+\frac{1}{8\pi^2}\iint\log[\cosh^22K-\sinh2K(\cos\theta_1+\cos\theta_2)]$ と書き直す（実数側で $q=e^{-2K}$ と対応させると物理の分配関数は $q^{-L^2}Z_L(q)$ なので、本文の密度には $+\log q$ が残る）。臨界点は被対数の最小値 $(1-2q-q^2)^2$ の零条件 $=$ 自己双対方程式、`claim_self_dual_positive_root_unique`。非解析性は実数側で別ブロック。指示書 `identify-onsager-closed-form-and-critical-point.md`。 |
| Kac--Ward 行列式の置換展開／置換展開と偶部分グラフ対の直接比較 | 直接比較経路の退避 | 未着手（平方恒等式が閉じてから） | 置換展開と偶部分グラフ対の直接比較だけが使う本文ブロック（鍵ごとのファイバー、選択和、接触平滑化の対合、経路反転の軌道、切断旗の復元など）を、新経路が引かないことを依存で確かめてから参照用ノートへ退避し、採用しなかった理由を書く。SageMath と Lean の対応物も一緒に片付ける。 |
| 全章 | 行き止まりの主張 18 件の切り分け | 未着手 | 引用漏れか不要かを 1 件ずつ読んで判断する。判定は `ref()` と `\blkref{}` の両方を数えること（数え違いの実績あり）。まず転送行列章の 4 件（トレース定理の証明が引いていない可能性）。 |
| 全章 | 道具の節を割って道具の章へ移す | 未着手 | 章の外に残る二次体と正錐・実閉部分体・有理係数の対数順序群などについて、格子・配位を参照しないブロックを依存から特定する。節の中に本論が混ざる場合はブロック単位で分割する。 「巡回移動は隣接二項の整数和を保つ」は 2026-10-21 に道具の章の節「整数の有限列と等差項についての補題」へ移した。 多項式環・定数多項式の写像・多項式行列・行列式・互換の符号の五ブロックも移動済みなので、この行の対象から除く。残る候補は実際の依存を調べてから分割する。 |
| 臨界指数を零点列で書く | 先頭距離の列の可算な命題 | 保留 | $L=2,\dots,8$ の七点では定義多項式の次数も実対数へ脱出した読みも一般則・収束先を一意に定めない。命題候補が立つまで本文へ項目を追加しない。 |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

固定原始特徴の多項式探索とそれに続く有限データへの当てはめは 2026-09-20 に終了し、2026-10-03 の研究管理が平方恒等式の経路を Pfaffian 経路へ切り替えた（「現在地」の先頭と runbook「Kac--Ward 平方恒等式の経路」）。有限データへの当てはめは再開しない。

## レビュー記録

- 2026-10-28: 「低温変数での有限トーラス公式」の四項和と SageMath・独立な Lean 二版を照合し、修正不要だった。
- 2026-10-28: 「無ねじれモードの零条件」の平方因子・零条件と SageMath・独立な Lean 二版を照合し、修正不要だった。
- 2026-10-28: 「分散因子と Onsager 表示の代数的対応」の本文・SageMath・独立な Lean 二版を照合し、修正不要だった。
- 2026-10-28: 「四方向小行列式は分散因子に等しい」の本文・SageMath・独立な Lean 二版を照合し、修正不要だった。
- 2026-10-28: 「九つの置換項の符号付き和を分散因子へ整理する」を本文・SageMath・独立な Lean 二版と照合し、修正不要だった。

## 式変形の書き方の統一

- 2026-10-28（連続実行の書式統一）: 姉妹プロジェクトの「二階微分の対数発散」で、総合評価の数値積と加法へ行末根拠を付けた。次は同じ証明の続き。
- 2026-10-28（連続実行の書式統一）: 姉妹プロジェクトの「二階微分の対数発散」で、対数を含む第二項の絶対値上界を行末根拠付きの式鎖にした。次は同じ証明の続き。
- 2026-10-28（連続実行の書式統一）: 姉妹プロジェクトの「二階微分の対数発散」で、双曲線余弦の差と対数を含む積の上界を行末根拠付きの式鎖にした。次は同じ証明の続き。
- 2026-10-28（連続実行の書式統一）: 姉妹プロジェクトの「二階微分の対数発散」で、対数の分解と補正項の上界を行末根拠付きの式鎖にした。次は同じ証明の続き。
- 2026-10-28（連続実行の書式統一）: 姉妹プロジェクトの「二階微分の対数発散」で、κ/δ と対数の上下界を行末根拠付きの式鎖にした。次は同じ証明の続き。

## 前進の記録

- 2026-10-28: 分散因子の複合項目を自己双対性・正値性・特殊モードに割り、自己双対性を有理関数体で四層に示した。研究管理が新たに先頭へ置いた分散因子の定義とモード積公式は未着手。
- 2026-10-28（研究管理）: 分散因子の定義とモード積公式の行を先頭に足し、平方恒等式の節 6〜9 の記述・SageMath を Lean 配線の前へ移し（Lean 二版は配線の後の新しい行）、委譲を外す行の対象を例外の台帳 46 件に合わせた。
- 2026-10-28: 低温変数の有限トーラス公式を、四つの符号係数の和と有限和の順序交換で四層に示した。
- 2026-10-28: 無ねじれモードの分散因子を平方に分解し、自己双対方程式と零条件の同値を四層で示した。
- 2026-10-28: 分散因子の評価値と設計ノートの略記の対応を、有理関数の恒等式として本文・SageMath・独立な Lean 二版で示した。
