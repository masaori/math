# MEMORY — 複素行列環とクリフォード代数の同型

## 次回やること

- 状態台帳（`docs/tasks/proof-state.md`）の「次の一歩」の先頭の未着手の行を、runbook（`docs/tasks/proof-runbook.md`）に従って進める。

## 未解決問題・確認事項

- なし（番号の無い有限集合の上の和は、2026-11-01 の研究管理が台帳に行として足した）。

## 完了済み

- 2026-11-03: 直和の第二成分への埋め込み写像が線型写像であること（ラベル claim_embedding_into_second_component_is_linear_map）を示した。次は直和の元が二つの埋め込み写像の像の和であること（(x,y)=in_1(x)+in_2(y)。直和の加法の定義と V_1・V_2 の加法の単位元で閉じる見込み）。
- 2026-11-03: 零ベクトルのスカラー倍が零ベクトルであること（ラベル claim_scalar_multiple_of_zero_vector_is_zero_vector、等式 λ·_V0_V=0_V）を示した。次は直和の第二成分への埋め込み写像が線型写像であること（claim_embedding_into_first_component_is_linear_map と同じ形。V_1 の中の λ·0_{V_1}=0_{V_1} は導き直さず本主張を V=V_1 で引く）。
- 2026-11-03: 研究管理。台帳に、零ベクトルのスカラー倍（λ·0_V=0_V。以後は導き直さずに引く）の行と、直和の元が二つの埋め込み写像の像の和であること（(x,y)=in_1(x)+in_2(y)）の行を足した。次は λ·0_V=0_V。
- 2026-11-03: 直和の第二成分への埋め込み写像の定義（ラベル def_embedding_into_second_component_of_direct_sum、記号 in_2、in_2(y)=(0_{V_1},y)）を置いた。次は in_2 が線型写像であること（claim_embedding_into_first_component_is_linear_map と同じ形で、準備として V_1 の中の λ·0_{V_1}=0_{V_1} を示し、加法は第一成分を 0_{V_1}+0_{V_1} に書き直して閉じる）。
- 2026-11-03: 直和の第一成分への埋め込み写像が線型写像であること（ラベル claim_embedding_into_first_component_is_linear_map）を示した。次は直和の第二成分への埋め込み写像の定義（in_2(y):=(0_{V_1},y)。第一成分の定義 def_embedding_into_first_component_of_direct_sum と同じ形で書く）。
- 2026-11-03: 「直和の成分への埋め込み写像とその線型性」を四行に割り、直和の第一成分への埋め込み写像の定義（ラベル def_embedding_into_first_component_of_direct_sum、記号 in_1、in_1(x)=(x,0_{V_2})）を置いた。次は in_1 が線型写像であること（加法とスカラー倍を保つことを、直和の演算の定義と V_2 の 0+0=0・λ·0=0 で示す。λ·0_{V_2}=0_{V_2} は claim_zero_scalar_multiple_is_zero_vector とスカラー倍の結合法則で示した前例がある）。
- 2026-11-03: 二つの線型空間の直和が ℂ-線型空間であること（ラベル claim_direct_sum_of_two_vector_spaces_is_complex_vector_space）を示した。次は直和の成分への埋め込み写像（W→W⊕W^*、W^*→W⊕W^* に名前を付け、線型写像であることを示す。値は (w,0_{W^*})・(0_W,f)）。
- 2026-11-03: 「二つの線型空間の直和」を二行に割り、直和の定義（ラベル def_direct_sum_of_two_vector_spaces、V_1⊕V_2 は順序対の集合、演算と零は成分ごと）を置いた。次は直和が ℂ-線型空間であること（八つの公理を、順序対の等しさ＝成分ごとの等しさで V_1・V_2 の公理へ帰着する。加法の逆元は各成分の逆元の組）。
- 2026-11-02: 双対基底が双対空間を線型結合で張ること（ラベル claim_dual_basis_spans_dual_space、等式 g=Σ_k g(b_k)·_{V^*}f_k）を示した。次は二つの線型空間の直和（組の集合と成分ごとの演算）。
- 2026-11-02: ℂ の中の番号順の和で第 k 項に δ_{k,j} を掛けた和が α_j になること（ラベル claim_ordered_sum_with_kronecker_delta_picks_term、等式 Σ_{ℂ,k} α_k·_ℂδ_{k,j}=α_j）を示した。次は双対基底が双対空間を線型結合で張ること（g∈V^* について h:=Σ_k g(b_k)·f_k と置き、claim_value_of_linear_combination_in_dual_space と双対基底の条件 f_k(b_j)=δ_{k,j} と本主張で h(b_j)=g(b_j) を出し、claim_linear_form_maps_linear_combination_to_ordered_sum と基底が張ることで各点 x で h(x)=g(x) を示す）。
- 2026-11-02: 研究管理。経路の行列の等式を M=1,2,3 で厳密に確かめた。双対基底の定義・代数の中の番号順の積・a†_S・a_T・P の定義の行を足し、使わない双対基底の一意性の行を消し、a_i P=0 と P a†_i=0 を割って前へ移した。
- 2026-11-01: 研究管理の初回。本文を `content/chapters/` の章ファイルと、章の並びを持つ `content/main-text.ts` に分けた。台帳に、直和の成分への埋め込み・ℂ の線型空間の構造・有限集合の上の和・可算個の直和の行を足し、複素行列環の章と生成作用素の行列を商代数・テンソル積より先へ移した。

- 2026-10-31: 代表が構成案（`docs/tasks/structure-proposal.md`）を承認した。主定理は分裂した二次空間のクリフォード代数と行列環の同型で、逆写像を明示した全単射として示す。
- 2026-10-31: README・runbook・状態台帳・構造化テキストの雛形を作り、定期実行を二つ立てた（証明の積み上げ: 連続実行で前回の終了から2時間あける／研究管理: 毎日の定時実行）。
- 2026-10-31: 道具立ての章に環の準同型の定義（ラベル def_ring_homomorphism）を置いた。
- 2026-10-31: 道具立ての章に ℂ-線型空間の定義（ラベル def_complex_vector_space）を置いた。
- 2026-10-31: 道具立ての章に線型写像の定義（ラベル def_linear_map）を置いた。次は線型結合の定義。
- 2026-10-31: 道具立ての章に線型結合の定義（ラベル def_linear_combination）を置いた。次は双対空間と双対基底。
- 2026-11-01: 「双対空間と双対基底」を七行に割り、道具立ての章に線型形式の定義（ラベル def_linear_form）を置いた。次は線型形式の各点ごとの和とスカラー倍が線型形式であること。
- 2026-11-01: 「線型形式の各点ごとの和とスカラー倍」を二行に割り、各点ごとの和が線型形式であること（ラベル claim_pointwise_sum_of_linear_forms_is_linear_form）を示した。次は各点ごとのスカラー倍が線型形式であること。
- 2026-11-01: 各点ごとのスカラー倍が線型形式であること（ラベル claim_pointwise_scalar_multiple_of_linear_form_is_linear_form）を示した。次は双対空間の定義。
- 2026-11-01: 零写像が線型形式であること（ラベル claim_zero_map_is_linear_form）を示した。次は双対空間の定義（加法は s_{f,g}、スカラー倍は m_{μ,f}、加法の単位元は z_V で与える）。
- 2026-11-01: 双対空間の定義（ラベル def_dual_space）を置いた。次は双対空間が ℂ-線型空間であること（ℂ-線型空間の八つの公理を、写像の等しさ＝各点での値の等しさで確かめる。加法の逆元は m_{-1,f} で与えられる）。
- 2026-11-01: 双対空間が ℂ-線型空間であること（ラベル claim_dual_space_is_complex_vector_space）を示した。次は基底の定義（番号付けた族の一次独立性と、線型結合で張ること）。
- 2026-11-01: 基底の定義を三行に割り、一次独立の定義（ラベル def_linear_independence）を置いた。次は番号付けた族が線型結合で張ることの定義。
- 2026-11-01: 線型結合で張る族の定義（ラベル def_spanning_family）を置いた。次は基底の定義（一次独立で、かつ張る族）。
- 2026-11-01: 基底の定義（ラベル def_basis）を置いた。次は双対基底の存在と一意性。
- 2026-11-01: 「双対基底の存在と一意性」を八行に割り、零のスカラー倍が零ベクトルであること（ラベル claim_zero_scalar_multiple_is_zero_vector）を示した。次は同じ族の二つの線型結合の和が係数ごとの和による線型結合であること（線型結合の帰納的な定義 L_m について m の帰納法で示す）。
- 2026-11-01: 同じ族の二つの線型結合の和が係数ごとの和による線型結合であること（ラベル claim_sum_of_linear_combinations_of_same_family）を示した。次は線型結合のスカラー倍が係数のスカラー倍による線型結合であること（同じく L_m についての m の帰納法。ベクトルの加法についての分配法則とスカラー倍の結合法則を使う）。
- 2026-11-01: 線型結合のスカラー倍が係数のスカラー倍による線型結合であること（ラベル claim_scalar_multiple_of_linear_combination）を示した。次は基底による線型結合の係数の一意性（二つの線型結合の差を、和とスカラー倍の主張で一つの線型結合にまとめ、一次独立の定義を引く）。
- 2026-11-02: 一次独立な族による線型結合の係数の一意性（ラベル claim_uniqueness_of_coefficients_of_linear_combination）を示した。次は基底についての座標の写像（x の第 i 係数）が線型形式であること（係数の一意性の主張で写像が well-defined になることを本文に書き、和とスカラー倍の主張で線型性を示す）。
- 2026-11-02: 基底についての座標の写像が線型形式であること（ラベル claim_coordinate_map_is_linear_form）を示した。座標の写像は β^b_k と書く。次は線型形式が線型結合を、係数と値の積の ℂ の中の番号順の和へ移すこと（L_m についての m の帰納法。ℂ の中の番号順の和は線型結合の定義を ℂ へ写さず、ℂ の加法で帰納的に直接定める必要がある）。
- 2026-11-02: ℂ の中の番号順の和の定義（ラベル def_ordered_sum_in_complex_numbers、記号 \sum_{\mathbb{C},\,k=1}^{n}）を置いた。次は線型形式が線型結合を、係数と値の積の ℂ の中の番号順の和へ移すこと（L_m と S_m についての m の帰納法。m=0 の段は f(0_V)=0_ℂ を、零のスカラー倍の主張を x=0_V で引いて f(0_ℂ·0_V)=0_ℂ·f(0_V) と書き直して示す）。
- 2026-11-02: 線型形式が線型結合を係数と値の積の ℂ の中の番号順の和へ移すこと（ラベル claim_linear_form_maps_linear_combination_to_ordered_sum）を示した。次は双対基底の存在（座標の写像 β^b_k が β^b_k(b_j)=δ_kj を満たすこと。b_j を係数 δ_kj の線型結合として書き、係数の一意性で読み取る）。
- 2026-11-02: 「双対基底の存在」を三行に割り、クロネッカーのデルタの定義（ラベル def_kronecker_delta、記号 δ_{i,j}、任意の集合 X の二元について定める）を置いた。次は番号付けた族の第 j 元が係数 δ_{k,j} の線型結合であること（L_m について、m<j なら L_m=0_V、m≥j なら L_m=b_j を m の帰納法で示す。k≠j の項は零のスカラー倍の主張で 0_V、k=j の項はスカラー倍の単位元で b_j）。
- 2026-11-02: 番号付けた族の第 j 元が係数 δ_{k,j} の線型結合であること（ラベル claim_family_member_is_kronecker_delta_linear_combination）を示した。次は双対基底の定義（V^* の元の番号付けた族 f で f_i(b_j)=δ_{i,j} を満たすもの）。
- 2026-11-02: 双対基底の定義（ラベル def_dual_basis）を置いた。次は双対基底の存在（座標の写像の族 β^b が b の双対基底であること。claim_family_member_is_kronecker_delta_linear_combination で b_j を係数 δ_{k,j} の線型結合に書き、claim_uniqueness_of_coefficients_of_linear_combination で β^b_k(b_j)=δ_{k,j} を読み取る）。
- 2026-11-02: 双対基底の存在（ラベル claim_coordinate_maps_form_dual_basis、族 β^b:{1..n}→V^*）を示した。次は双対基底が双対空間を線型結合で張ること（f=Σ_k f(b_k)·f_k。各点 x で両辺の値を比べ、claim_linear_form_maps_linear_combination_to_ordered_sum と双対空間の演算の定義を使う見込み）。
- 2026-11-02: 「双対基底が双対空間を線型結合で張ること」の前に二行を足し、双対空間の元の線型結合の点 x での値が係数と値の積の ℂ の中の番号順の和であること（ラベル claim_value_of_linear_combination_in_dual_space）を示した（帰納法の添字は写像 m_{μ,f} と衝突しないよう r とした）。次は ℂ の中の番号順の和で第 k 項に δ_{k,j} を掛けた和が α_j になること（S_r についての帰納法。r<j・r=j・r>j に分ける。ℂ の中の積 α·_ℂ0_ℂ=0_ℂ・α·_ℂ1_ℂ=α は ℂ の性質として行末に書く）。その後、双対基底が張ることを h:=Σ_k g(b_k)·f_k が h(b_j)=g(b_j) を満たすことと、claim_linear_form_maps_linear_combination_to_ordered_sum で示す。
