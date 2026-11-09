# MEMORY — 複素行列環とクリフォード代数の同型

## 次回やること

- 状態台帳（`docs/tasks/proof-state.md`）の「次の一歩」の先頭の未着手の行を、runbook（`docs/tasks/proof-runbook.md`）に従って進める。

## 未解決問題・確認事項

- なし（番号の無い有限集合の上の和は、2026-11-01 の研究管理が台帳に行として足した）。

## 完了済み


- 2026-11-09: 商集合への射影が全射であること（ラベル claim_projection_onto_quotient_set_is_surjective）を、商集合の定義で代表をとり π_I(a)=[a]_I=X で示した。次は合同が加法と両立すること。

- 2026-11-09: 商集合への射影の定義（ラベル def_projection_onto_quotient_set、π_I:A→A/I、π_I(a):=[a]_I）を置いた。値が A/I に属することは代表に a 自身をとれば成り立つと本文に書いた。次は射影が全射であること。

- 2026-11-09: 商集合の定義（ラベル def_quotient_set_modulo_two_sided_ideal、A/I:={[a]_I: a∈A}）を置いた。演算は商代数の演算の定義で定め、A から A/I へは射影を通すと本文に書いた。次は射影の定義。

- 2026-11-09: 剰余類が等しいことと合同であることの同値（ラベル claim_residue_classes_are_equal_iff_congruent）を、反射性・対称性・推移性と両包含で示した。次は商集合の定義。

- 2026-11-09: 剰余類の定義（ラベル def_residue_class_modulo_two_sided_ideal、[a]_I:={b∈A: a≡_I b}、A の部分集合）を置いた。a と [a]_I の行き来は射影の定義で名前を付ける写像を通すと本文に書いた。次は剰余類が等しいことと合同であることの同値。

- 2026-11-08: 合同の反射性（ラベル claim_congruence_modulo_two_sided_ideal_is_reflexive）を、a+_A((-1_ℂ)∗_A a)=0_A の四行の鎖と 0_A∈I で示した。次は合同の対称性。
- 2026-11-08: 両側イデアルがスカラー倍で閉じていること（ラベル claim_two_sided_ideal_is_closed_under_scalar_multiplication）を、λ∗_A x=(λ∗_A 1_A)·_A x と左から掛ける条件で示した。次は合同の反射性（a≡_I a）。

- 2026-11-08: 台帳の「商代数の構成と射影」を十七行に割り、両側イデアルを法とする合同の定義（ラベル def_congruence_modulo_two_sided_ideal、a+_A((-1_ℂ)∗_A b)∈I のとき a≡_I b）を置いた。次は両側イデアルがスカラー倍で閉じていること。

- 2026-11-08: 部分集合が生成する両側イデアルは、その部分集合を含むどの両側イデアルにも含まれること（ラベル claim_two_sided_ideal_generated_by_subset_is_contained_in_every_ideal_containing_subset）を、⟨X⟩_A の定義の条件を X を含む両側イデアル J に当てて示した。次は商代数の構成と射影。

- 2026-11-08: 部分集合が生成する両側イデアルがその部分集合を含むこと（ラベル claim_two_sided_ideal_generated_by_subset_contains_subset）を、X を含む各両側イデアルに X の元が入ることと ⟨X⟩_A の定義から示した。次は ⟨X⟩_A が X を含むどの両側イデアルにも含まれること。

- 2026-11-08: 部分集合が生成する両側イデアルが両側イデアルであること（ラベル claim_two_sided_ideal_generated_by_subset_is_two_sided_ideal）を、X を含む各両側イデアルでの四条件から示した。次は ⟨X⟩_A が X を含むこと（X の元は X を含むどの両側イデアルにも入ることを定義に当てる）。

- 2026-11-08: 部分集合が生成する両側イデアルの定義（ラベル def_two_sided_ideal_generated_by_subset、⟨X⟩_A は X を含むすべての両側イデアルに属する A の元の集合）を置いた。次は ⟨X⟩_A が両側イデアルであること（四条件を、X を含む各両側イデアル I での条件から一つずつ示す）。

- 2026-11-08: 台帳の「両側イデアルと、部分集合が生成する両側イデアル」を五行に割り、両側イデアルの定義（ラベル def_two_sided_ideal、0_A∈I・加法で閉じる・A の元を左右から掛けても I に入る）を見出し「両側イデアルと商代数」の下に置いた。次は部分集合が生成する両側イデアルの定義（X を含むすべての両側イデアルに属する元の集合）。

- 2026-11-08: 生成元で一致する二つの準同型は等しいこと（ラベル claim_homomorphisms_agreeing_on_generators_are_equal）を、値が一致する元の集合が部分代数であることと生成することの定義で示した。次は両側イデアルと、部分集合が生成する両側イデアル。

- 2026-11-08: 部分集合が代数を生成することの定義（ラベル def_subset_generates_algebra、X を含む A の部分代数がどれも A であること）を置いた。次は生成元で一致する準同型は等しいこと（値が一致する元の集合が部分代数であることを示し、この定義を当てる）。

- 2026-11-07: 台帳の「部分集合が生成する部分代数と、生成元で一致する準同型は等しいこと」を三行に割り、部分代数の定義（ラベル def_subalgebra）を置いた。次は部分集合が代数を生成することの定義（X を含む A の部分代数が A だけであること）。

- 2026-11-07: Φ(a_T) に当たる行列の逆順の積を E_{∅,∅} に右から掛けると E_{∅,T} になること（ラベル claim_vacuum_matrix_unit_times_reverse_ordered_product_of_selected_annihilation_matrices）を、E_{∅,R}·c_s^T=E_{∅,R∪{s}}（R の元がすべて s+1 以上）の準備と m の帰納法で示し、SageMath（M=1,2,3、ZZ の厳密計算）で検算した。これで Φ∘Ψ が使う行列の側の四行が済んだ。次は部分集合が生成する部分代数と、生成元で一致する準同型は等しいこと。

- 2026-11-07: Φ(a†_S) に当たる行列の番号順の積を E_{∅,∅} に左から掛けると E_{S,∅} になること（ラベル claim_ordered_product_of_selected_creation_matrices_times_vacuum_matrix_unit）を、c_m·E_{R,∅}=E_{R∪{m},∅}（R の元がすべて m+1 以上）の準備と m の帰納法で示し、SageMath（M=1,2,3、ZZ の厳密計算）で検算した。次は Φ(a_T) に当たる行列の逆順の積を E_{∅,∅} に右から掛けると E_{∅,T} になること。

- 2026-11-07: 番号より小さい元を持たない部分集合の個数が 0 であること（ラベル claim_count_below_index_vanishes_without_smaller_elements、T のすべての元が i 以上なら N_i(T)=0）を i の帰納法で示した。次は Φ(P) に当たる行列の積が E_{∅,∅} であること。
- 2026-11-07: 反交換関係 c_i c_j^T + c_j^T c_i = δ_{i,j}∗1_{Mat}（ラベル claim_creation_and_annihilation_operator_matrices_anticommute）を、左右から掛ける補題で二つの積の成分を条件つきの式に開き、i=j と i≠j に分けて示し、SageMath（M=1,2,3、ZZ の厳密計算）で検算した。次は番号より小さい元を持たない部分集合の個数は 0 であること。
- 2026-11-07（研究管理）: 本文 12 ブロック（2 進の番号付け、同型の証明の章の個数 N_i・符号 ς・c_i・c_i^T の定義、反交換関係二つ、成分の補題二つなど）に暗黙の同一視は無かった。台帳の c_i c_j^T + c_j^T c_i の行の後に、Φ∘Ψ が使う行列の側の四行を足した。
- 2026-11-07: 左から生成作用素の行列を掛けた行列の成分の補題（ラベル claim_entry_of_creation_operator_matrix_times_matrix、(c_i A)_{S,U}=ς(N_i(S'))·A_{S',U}（i∈S、S':=S から i を除いた集合）、0_ℂ（i∉S））を示し、SageMath（M=1,2,3、不定元の A）で検算した。次は反交換関係 c_i c_j^T + c_j^T c_i = δ_{i,j}·I。
- 2026-11-07: 台帳の反交換関係 c_i c_j^T + c_j^T c_i = δ_{i,j}·I を三行に割り、符号の自分自身との積 ς(n)·ς(n)=1_ℂ（ラベル claim_sign_of_nonnegative_integer_squares_to_one）を n の帰納法で示した（準備で (-1_ℂ)·(-1_ℂ)=1_ℂ を ℂ の公理から示した）。次は左から生成作用素の行列を掛けた行列の成分の補題（(c_i A)_{S,U}=ς(N_i(S'))·A_{S',U}（i∈S、S':=S から i を除いた集合）、0_ℂ（i∉S））。
- 2026-11-07: 反交換関係 c_i^T c_j^T + c_j^T c_i^T = 0（ラベル claim_annihilation_operator_matrices_anticommute、i=j を含む）を、成分の等式 (c_k^T c_l^T)_{S,U}=(c_l c_k)_{U,S} で生成作用素の行列どうしの反交換関係へ帰着して示し、SageMath（M=1,2,3、ZZ の厳密計算）で検算した。
- 2026-11-07: 反交換関係 c_i c_j + c_j c_i = 0（ラベル claim_creation_operator_matrices_anticommute、i=j を含む）を示し、SageMath（M=1,2,3、ZZ の厳密計算）で検算した。次は反交換関係 c_i^T c_j^T + c_j^T c_i^T = 0。
- 2026-11-07: 台帳の反交換関係 c_i c_j + c_j c_i = 0 を二行に割り、右から生成作用素の行列を掛けた行列の成分の補題（ラベル claim_entry_of_matrix_times_creation_operator_matrix、(A c_j)_{S,U}=A_{S,U∪{j}}·ς(N_j(U))（j∉U）、0_ℂ（j∈U））を示し、SageMath（M=1,2,3）で検算した。次は反交換関係 c_i c_j + c_j c_i = 0。
- 2026-11-06: 個数 N_i(T) に一元を足したときの値（ラベル claim_count_below_index_after_adding_one_element、j<i なら N_i(T∪{j})=N_i(T)+1、j≥i なら N_i(T)）を i の帰納法で示した。次は反交換関係 c_i c_j + c_j c_i = 0。
- 2026-11-06: 消滅作用素の行列の定義を置いた（ラベル def_annihilation_operator_matrix。(c_i^T)_{S,T}:=(c_i)_{T,S}。転置の一般の定義は置かない）。npm run check と build:pdf は通った。次は個数 N_i(T) に一元を足したときの値の主張。
- 2026-11-06: 生成作用素の行列 c_i の定義（ラベル def_creation_operator_matrix、(c_i)_{S,T}:=ς(N_i(T))（i∉T かつ S=T∪{i}）、他は 0_ℂ、M≥1）を同型の証明の章に置いた。次は消滅作用素の行列 c_i^T の定義（成分 (c_i^T)_{S,T}:=(c_i)_{T,S} で直接定める）。
- 2026-11-06: 台帳の「c_i の定義」を二行に割り、非負整数の偶奇による符号 ς(n)（ラベル def_sign_of_nonnegative_integer、ς(0):=1_ℂ、ς(n):=(-1_ℂ)·_ℂς(n-1)）を置いた。次は生成作用素の行列 c_i の定義（(c_i)_{S,T}:=ς(N_i(T))（i∉T かつ S=T∪{i}）、他は 0_ℂ）。
- 2026-11-06: 同型の証明の章のファイル isomorphism.ts を作り、生成作用素の符号に使う個数 N_i(T) の帰納的な定義（ラベル def_count_of_subset_elements_below_index、N_1(T):=0、N_i(T):=N_{i-1}(T)+[i-1∈T]）を置いた。次は生成作用素の行列 c_i の定義（(-1)^{N_i(T)} を ℂ の中の積で帰納的に書く）。クリフォード代数の章のファイルは main-text.ts の複素行列環と同型の証明の間に足す。
- 2026-11-06: 論文の HTML の URL を https://hexcomp-artifacts.web.app/masaori/math/clifford-matrix-isomorphism/ に直した（math/clifford-matrix-isomorphism/ は not found。この論文は API から初めて公開したので masaori/math/ の URL だけを持つ）。README・リポジトリ直下の CLAUDE.md と AGENTS.md の報告の URL の決まり・定時実行「クリフォード代数の同型: 研究管理」の指示文を直した。
- 2026-11-06: (2^M,e_M) が P_M の番号付けであり P_M が有限集合であること（ラベル claim_binary_numbering_is_numbering_of_power_set）を M の帰納法で示し、検算 sagemath/check/binary-numbering-of-power-set/ を置いた（M=0..8 で通過）。次は生成作用素の符号に使う個数 N_i(T) の帰納的な定義（同型の証明の章。章のファイル isomorphism.ts を新しく作り main-text.ts に足す）。
- 2026-11-06: 「VM に SageMath が無い」は誤りだった（SageMath 10.9 は micromamba の環境 `sage` に在り、PATH に無いだけ）。runbook の SageMath の手順に実行コマンドを書き、検算 2 件（行列単位の積の規則・単位行列の分解）を SageMath で実行し直して通過を overview.md に書いた。
- 2026-11-06: 2 進の番号付けの写像 e_M:{1..2^M}→P_M の帰納的な定義（ラベル def_binary_numbering_of_power_set）を置いた。次は (2^M,e_M) が P_M の番号付けであること（M の帰納法。単射は k≤2^{M-1} と k>2^{M-1} の場合で M の所属を比べ、全射は M∈T か否かで T∖{M} の逆像を引く見込み）。
- 2026-11-06（研究管理）: 台帳に、個数 N_i(T) に一元を足したときの値（j<i なら 1 増え、j≥i なら変わらない）の行を、三つの反交換関係の前に足した（三つの関係の符号の打ち消しがどれも使うため）。
- 2026-11-06: 台帳の「P_M の定義と有限集合であること」を三行に割り、{1..M} の部分集合全体 P_M の定義（ラベル def_power_set_of_first_m_positive_integers）を置いた。次は 2 進の番号付け e_M:{1..2^M}→P_M の帰納的な定義（値が P_M に入ることを本文に書く）。
- 2026-11-06: 単位行列の分解 Σ_{x∈X} 1_ℂ∗E_{x,x}=1_{Mat_X}（ラベル claim_decomposition_of_identity_matrix_into_matrix_units）を示し、検算 sagemath/check/identity-matrix-decomposition-into-matrix-units/ を置いた（python3 で実行）。次は {1..M} の部分集合全体 P_M の定義と、P_M が有限集合であること（2 進の番号付け e:{1..2^M}→P_M を構成する）。
- 2026-11-06: 台帳の「単位行列の分解」の前に、行列の (p,q) 成分を取り出す写像 ent_{p,q} が線型写像であることの行を割り出して示した（ラベル claim_matrix_entry_map_is_linear_map）。次は単位行列の分解 Σ_x 1_ℂ∗E_{x,x}=1_{Mat_X}（(p,q) 成分を ent_{p,q} と claim_linear_map_maps_sum_over_finite_set_to_sum_of_values で Σ_x 1_ℂ·(E_{x,x})_{p,q} に開き、各項を δ_{x,p}·δ_{x,q} の形に直してから claim_sum_over_finite_set_with_kronecker_delta_picks_term で δ_{p,q} を取り出す見込み）。
- 2026-11-06: 行列単位の積の規則（ラベル claim_product_of_matrix_units、E_{x,y}·E_{z,w}=δ_{y,z}∗E_{x,w}）を示し、検算 sagemath/check/matrix-unit-product-rule/ を置いた（SageMath が無いので python3 で実行）。次は単位行列の分解 Σ_S E_{S,S}=I（成分 (Σ_s 1·E_{s,s})_{p,q} を開くには、行列の線型空間の中の有限集合の上の和の成分を取り出す写像が線型写像であることと claim_linear_map_maps_sum_over_finite_set_to_sum_of_values を当てる見込み）。
- 2026-11-06: 行列単位の定義（ラベル def_matrix_unit、(E_{x,y})_{u,v}:=δ_{x,u}·_ℂδ_{y,v}）を置いた。次は行列単位の積の規則 E_{S,T}E_{U,R}=δ_{T,U}E_{S,R}（成分を行列の積の定義で開き、claim_sum_over_finite_set_with_kronecker_delta_picks_term で一項を取り出す見込み）。
- 2026-11-05: Mat_X(ℂ) が ℂ-代数であること（ラベル claim_matrices_indexed_by_finite_set_form_complex_algebra）を示した。次は行列単位の定義。
- 2026-11-05: スカラー倍と行列の積の両立の右の因子 λ∗(AB)=A(λ∗B)（ラベル claim_scalar_multiple_is_compatible_with_matrix_product_in_right_factor）を示した。次は Mat_X(ℂ) が ℂ-代数であること（線型空間の公理・結合法則・左右の分配法則・左右の単位元・左右のスカラー倍との両立の八行を ℂ-代数の定義 def_complex_algebra の条件に当てる）。
- 2026-11-05: 「スカラー倍と行列の積の両立」を台帳で左右の二行に割り、左の因子 λ∗(AB)=(λ∗A)B（ラベル claim_scalar_multiple_is_compatible_with_matrix_product_in_left_factor）を示した。次は右の因子 λ∗(AB)=A(λ∗B)（claim_scalar_multiple_of_sum_over_finite_set のあと、各項 (λ·A_{x,z})·B_{z,y} を ℂ の乗法の結合法則・交換法則で A_{x,z}·(λ·B_{z,y}) に書き直し、claim_sum_over_finite_set_depends_only_on_terms を引く）。
- 2026-11-05: 単位行列を右から掛けても行列が変わらないこと（ラベル claim_identity_matrix_is_right_unit_of_matrix_product、A·1=A）を示した。次はスカラー倍と行列の積の両立（左の因子・右の因子。claim_scalar_multiple_of_sum_over_finite_set と、右の因子では claim_sum_over_finite_set_depends_only_on_terms を引く）。
- 2026-11-05: 「単位行列が行列の積の単位元であること」を台帳で左右の二行に割り、単位行列を左から掛けても行列が変わらないこと（ラベル claim_identity_matrix_is_left_unit_of_matrix_product、1·A=A）を示した。次は右から掛ける A·1=A（各項 A_{x,z}·δ_{z,y} を ℂ の乗法の交換法則と δ_{z,y}=δ_{y,z} で δ_{y,z}·A_{x,z} に書き直し、claim_sum_over_finite_set_with_kronecker_delta_picks_term を x:=y で当てる）。
- 2026-11-05: 行列の積が左の因子の和に分配すること（ラベル claim_matrix_product_distributes_over_sum_in_left_factor、(A+B)C=AC+BC）を示した。次は単位行列が行列の積の単位元であること（デルタが一項を取り出す主張 claim_sum_over_finite_set_with_kronecker_delta_picks_term を引く）。
- 2026-11-05（研究管理）: 台帳に行列単位の定義の行を足し、「生成作用素の行列 c_i と、その反交換関係」を五行に割った（c_i^T は成分で直接定め、転置の一般論を置かない）。build:pdf が地の文の ℂ で落ちていたのを、プリアンブルで ℂ を \mathbb{C} で組む形にして直し、runbook の検証に build:pdf を足した。
- 2026-11-05: 「行列の積の分配法則」を台帳で二行に割り、行列の積が右の因子の和に分配すること（ラベル claim_matrix_product_distributes_over_sum_in_right_factor、A(B+C)=AB+AC）を示した。次は左の因子の和への分配（(A+B)C=AC+BC。各 z の項の (A+B)_{x,z} を A_{x,z}+_ℂB_{x,z} に書き直し、同じ族の二つの和の和の主張 claim_sum_of_sums_over_finite_set_with_same_family を v_z:=C_{z,y} で逆向きに当てる）。
- 2026-11-05: 行列の積の結合法則（ラベル claim_matrix_product_is_associative）を示した。次は行列の積の分配法則（A(B+C)=AB+AC は族ごとの和、(A+B)C=AC+BC は係数ごとの和の主張を、各項の値だけで決まることと合わせて引く）。
- 2026-11-05: 有限集合の上の和が各項の値だけで決まること（ラベル claim_sum_over_finite_set_depends_only_on_terms）を、行列の積の結合法則の前に台帳の行として割り出して示した。次は行列の積の結合法則。
- 2026-11-05: 「有限集合で添字づけた行列の代数」を台帳で七行に割り、新しい章のファイル complex-matrix-algebra.ts（複素行列環の章）に行列の集合と演算の定義（ラベル def_matrices_indexed_by_finite_set、Mat_X(ℂ)、演算 +_{Mat_X}・·_{Mat_X}・∗_{Mat_X}・0_{Mat_X}・1_{Mat_X}）を置いた。次は行列の集合が成分ごとの和とスカラー倍で ℂ-線型空間であること（双対空間の公理の確認と同じく成分の等式で確かめ、加法の逆元は成分ごとの逆元を選んだ行列で与える）。
- 2026-11-04: 代数の中の番号順の積の定義（ラベル def_ordered_product_in_algebra、Π_0:=1_A・Π_m:=Π_{m-1}·_A x_m、記号 ∏_{A,k=1}^{n} x_k。逆順の積は y_k:=x_{n+1-k} の番号順の積として書く）を置いた。次は有限集合で添字づけた行列の代数（複素行列環の章。章のファイル complex-matrix-algebra.ts を新しく作り main-text.ts に足す）。
- 2026-11-04: 代数から環と線型空間を取り出す対応と記号の規則（ラベル def_underlying_ring_and_vector_space_of_algebra、U_ring(A)・U_vec(A)）を置いた。環・線型空間の主張を代数に当てるときはこのラベルを引き、スカラー倍は ∗_A と書く。次は代数の中の番号順の積の定義（空の積は 1_A。ℂ の中の番号順の和 def_ordered_sum_in_complex_numbers と同じ帰納的な形）。
- 2026-11-04: ℂ-代数の準同型の定義（ラベル def_complex_algebra_homomorphism、環の組の環の準同型かつ線型空間の組の線型写像で、条件は加法・乗法・1_A・スカラー倍 ∗_A を保つこと）を置いた。次は代数から環・線型空間を取り出す写像と記号の規則（U_ring(A)・U_vec(A) に名前を付け、以後はこの写像を通してだけ行き来する）。
- 2026-11-04: 「ℂ-代数と代数の準同型の定義」を二行に割り、ℂ-代数の定義（ラベル def_complex_algebra、組 (A,+_A,·_A,∗_A,0_A,1_A)、乗法 ·_A とスカラー倍 ∗_A）を置いた。次は代数の準同型の定義（環の組の準同型 def_ring_homomorphism かつ線型空間の組の線型写像 def_linear_map であるもの）。
- 2026-11-04: 二つの有限集合の上の二重和の順序交換（ラベル claim_interchange_of_double_sum_over_finite_sets、等式 Σ_{x∈X} 1_ℂ·_V(Σ_{y∈Y} λ_{x,y}·v_{x,y})=Σ_{y∈Y} 1_ℂ·_V(Σ_{x∈X} λ_{x,y}·v_{x,y})）を示した。外側の係数は 1_ℂ に固定したので、行列の積の結合法則などで外側に係数が付く形は、有限集合の上の和のスカラー倍とスカラー倍の単位元で書き直してから引く。次は ℂ-代数と代数の準同型の定義。
- 2026-11-04: 有限集合の上の和でクロネッカーのデルタが一項を取り出すこと（ラベル claim_sum_over_finite_set_with_kronecker_delta_picks_term、等式 Σ_{y∈X} δ_{x,y}·_V v_y=v_x）を示した。番号付けで開いて claim_family_member_is_kronecker_delta_linear_combination に帰着した。次は二重和の順序交換（Σ_{x∈X}Σ_{y∈Y}=Σ_{y∈Y}Σ_{x∈X}。内側の和を外側の和の族として持つ形で、番号付けで開き、係数ごとの和・族ごとの和の主張と帰納法で示す見込み）。
- 2026-11-04: 線型写像が有限集合の上の和を値の有限集合の上の和へ移すこと（ラベル claim_linear_map_maps_sum_over_finite_set_to_sum_of_values、等式 f(Σ_x λ_x·_V v_x)=Σ_x λ_x·_U f(v_x)）を示した。次は有限集合の上の和でクロネッカーのデルタが一項を取り出すこと（Σ_y δ_{x,y}·v_y=v_x。番号付けで開き、線型結合の段の主張が本文に無いので証明の中で L_m の帰納法を行う見込み。claim_ordered_sum_with_kronecker_delta_picks_term の V 版）。
- 2026-11-04（研究管理）: 台帳に、P_M が有限集合であることの行と符号の個数 N_i(T) の定義の行を c_i の前に足し、Mat(2^M,ℂ) への同型の行を Jordan–Wigner の系の直前へ移した。runbook に、元の個数 # と部分集合の元を並べる写像を定義しないことを書いた。
- 2026-11-04: 同じ係数の二つの有限集合の上の和の和が族ごとの和による和であること（ラベル claim_sum_of_sums_over_finite_set_with_same_coefficients、等式 Σ_x λ_x·v_x+Σ_x λ_x·w_x=Σ_x λ_x·(v_x+w_x)）を示した。次は線型写像が有限集合の上の和を値の有限集合の上の和へ移すこと（線型写像と線型結合の交換も本文に無いので、同じく証明の中で L_m の帰納法を行い、線型写像の二条件で閉じる見込み）。
- 2026-11-04: 有限集合の上の和のスカラー倍（ラベル claim_scalar_multiple_of_sum_over_finite_set、等式 ρ·_V Σ_x λ_x·v_x=Σ_x (ρ·_ℂλ_x)·v_x）を示した。次は同じ係数の二つの有限集合の上の和の和が族ごとの和による和であること（線型結合の段の主張が本文に無いので、主張の証明の中で L_m の帰納法を行い、加法の結合法則・交換法則とベクトルの加法についての分配法則で閉じる見込み）。
- 2026-11-04: 「有限集合の上の和の性質」を台帳で六行に割り、同じ族の二つの有限集合の上の和の和が係数ごとの和による和であること（ラベル claim_sum_of_sums_over_finite_set_with_same_family）を示した。次は有限集合の上の和のスカラー倍（ρ·Σλ_x·v_x=Σ(ρ·λ_x)·v_x。同じく番号付けで開き、claim_scalar_multiple_of_linear_combination を当てる見込み）。その次の族ごとの和と線型写像との交換は、線型結合の段の主張が本文に無いので、主張の証明の中で L_m の帰納法を行う。
- 2026-11-04: 番号の付いていない有限集合の上の和の定義（ラベル def_sum_over_finite_set、記号 Σ_{x∈X} λ_x·_V v_x）を置いた。ℂ の中の和は V:=ℂ^vec に当て、係数の無い和は係数 1_ℂ で書く（係数を省いた記号は置かない）。次は有限集合の上の和の性質（二重和の順序交換、スカラー倍と積の分配）。主定理の経路で引くもの（行列の積の成分 Σ_U A_{S,U}·B_{U,T}、Σ_{S,T} の二重和、Ψ の線型性）だけに割ってから進める見込み。
- 2026-11-04: 番号を全単射で付け替えても線型結合が変わらないこと（ラベル claim_reindexing_linear_combination_by_bijection、等式 Σ_{k=1}^n μ_{σ(k)}·y_{σ(k)}=Σ_{i=1}^{n'} μ_i·y_i、(n,σ) は {1..n'} の番号付け）を示した。次は番号の付いていない有限集合の上の和の定義（番号付け (n,e) で Σ_k λ_{e(k)}·v_{e(k)} と定め、別の番号付け (n',e') との一致は σ:=e'^{-1}∘e に本主張を当てる。e=e'∘σ を e'(e'^{-1}(x))=x で確かめる）。
- 2026-11-03: 線型結合の第 j 項を最後へ移しても値が変わらないこと（ラベル claim_moving_term_of_linear_combination_to_last、写像 ρ_j:{1..n-1}→{1..n}、詰めた族 x̃_k・λ̃_k）を示した。次は全単射 σ:{1..n}→{1..n'} による番号の付け替え（n の帰納法。n'≥1 を示し、σ^{-1}(n') の項を本主張で最後へ移し、残りの族に τ:=σ∘ρ_{σ^{-1}(n')} を当てて帰納法の仮定を引く見込み。τ の値が {1..n'-1} に入り全単射であることを示す必要がある）。
- 2026-11-03: 「番号の付いていない有限集合の上の和」を四行に割り、新しい節「有限集合の上の和」に有限集合の番号付けの定義（ラベル def_numbering_of_finite_set、組 (n,e)、逆写像 e^{-1}）を置いた。次は線型結合の第 j 項を最後へ移しても値が変わらないこと（ρ_j(k)=k（k<j）、k+1（k≥j）で第 j 項を除いて詰めた族を作り、L_m を m<j と m≥j に分けて帰納法で示す見込み）。その次の全単射 σ:{1..n}→{1..n'} の主張では n=n' を別に示さず、n の帰納法の中で n'≥1 と τ の全単射性を示す。
- 2026-11-03: ℂ^vec が ℂ-線型空間であること（ラベル claim_complex_numbers_as_vector_space_is_complex_vector_space）を示した。次は番号の付いていない有限集合の上の和（番号付けを一つ選んで線型結合で定め、番号付けによらないこと）。
- 2026-11-03: 「ℂ に ℂ-線型空間の構造を与える組」の行を定義と公理の二行に割り、組の定義（ラベル def_complex_numbers_as_complex_vector_space、記号 ℂ^vec=(ℂ,+_{ℂ^vec},·_{ℂ^vec},0_{ℂ^vec})）を置いた。次は ℂ^vec が ℂ-線型空間であること（八つの公理を、演算の定義で ℂ の加法・乗法へ開き、ℂ の結合・交換・分配法則と単位元で閉じる。加法の逆元は (-1_ℂ)·_ℂ x を使う。双対空間の公理の確認 claim_dual_space_is_complex_vector_space と同じ形）。
- 2026-11-03: 直和の元が二つの埋め込み写像の像の和であること（ラベル claim_direct_sum_element_is_sum_of_embedded_components、等式 (x,y)=in_1(x)+in_2(y)）を示した。次は ℂ に ℂ-線型空間の構造を与える組に名前を付け、公理を満たすこと。
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
- 2026-11-04: 代表の依頼で Jordan–Wigner 行列と同型の関係を解説した。Jordan–Wigner の系で使う等長写像と共役の行列（K^{⊗M}）を、構成案の系の段落に書き足した（M=1,2,3 の行列計算で確認済み）。
- 2026-11-05: 行列の集合が成分ごとの和とスカラー倍で ℂ-線型空間であること（ラベル claim_matrices_indexed_by_finite_set_form_complex_vector_space）を示した。次は行列の積の結合法則。
- 2026-11-07: Φ(P) に当たる行列の積 ∏ c_i^T c_i が E_{∅,∅} であること（ラベル claim_ordered_product_of_annihilation_times_creation_matrices_is_vacuum_matrix_unit）を示し、SageMath で M=1,2,3 を検算した。次は Φ(a†_S) に当たる行列の番号順の積を E_{∅,∅} に左から掛けると E_{S,∅} になること。
- 2026-11-08: 合同の対称性（ラベル claim_congruence_modulo_two_sided_ideal_is_symmetric）を、b+_A((-1_ℂ)∗_A a)=(-1_ℂ)∗_A x の六行の鎖とイデアルのスカラー倍での閉性で示した。次は合同の推移性。
- 2026-11-08: 合同の推移性（ラベル claim_congruence_modulo_two_sided_ideal_is_transitive）を、((-1_ℂ)∗_A b)+_A b=0_A の準備と a+_A((-1_ℂ)∗_A c)=x+_A y の五行の鎖、両側イデアルが加法で閉じていることで示した。次は剰余類の定義。
