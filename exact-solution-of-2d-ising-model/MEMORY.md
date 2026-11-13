2026-11-13: Lean の通しの証明のゴールラインの確認の四百四十五個目として、状態台帳の (d4c44p15e) を行った。人手 Z_Y_linearly_independent の Step 2（tensor_basis (2) を Step 1 の基底に当てはめ、𝓔 は張り線型独立: pauliKroneckerFamily_spans_and_independent）と Step 6（多重添字を並べた単射 x を仮定に取り、係数の族 zyCoeffOnPauliKroneckerFamily で Σ_p d_pE_p を ζ・η 側の和に直し、𝓔 の線型独立性から α_m=β_m=0: sum_zyCoeff_smul_pauliKroneckerFamily・zy_step6_coeffs_eq_zero）の Lean を ClaimZYLinearlyIndependent.lean に置いた。Step 1 の結論の線型独立の側を tensor_basis (2) の仮定の形にした。必要十分版の扱いは (cl7f) で決めると書いた。人手・SageMath は不変。レビュー 2 回。人手 Step 6 が係数の並べ替えを日本語 1 文で済ませている件を (d4c44p15f) として登録した（部分集合の上の和の経路は「有限和の添字の付け方」の件に依り、デルタの経路は小さい主張 3 つを足せば書ける）。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (d4c44p15f)。
2026-11-13: Lean の通しの証明のゴールラインの確認の四百四十四個目として、状態台帳の (d4c44p15d) を行った。tensor_basis (3) の一般の基底 {u_1,u_2} の側は本文のどこからも使われない（004 章は標準基底の (f_I) だけを使う）ので、計画の「Step 5 を張る＋線型独立の形にする」ではなく、(3) を「(f_I) は基底、次元 2^M」に絞り、一般の基底の前半・Step 5・Step 5 だけが使う Step 3（張る族の元数は次元以上、という未証明の一般論）を notes/claims_unused_by_chapter_goals_not_adopted.ts へ退避した。旧 Step 4 を Step 3 に。SageMath 172_tensor_basis/check_02 から Step 5 の検算を外した（225 件 PASS）。Lean はコメントの Step 番号だけ。レビュー 2 回（2 回目 指摘なし）。npm run check・verify-check-linkage・verify-every-proof-has-check・lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (d4c44p15e)。
2026-11-13: Lean の通しの証明のゴールラインの確認の四百四十三個目として、状態台帳の (d4c44p15c) を行った。人手 tensor_basis の証明の Step 4（(2)）を、元数と次元の一致・Step 3 (b) から「kronecker_family_of_spanning_family_spans で張り、kronecker_family_of_independent_family_is_independent で線型独立なので基底」に書き直した（主張は不変）。Step 5 は「Step 4 と同じ議論」と書いていたので、書き直す前の議論（展開の表示式・帰納法・元数と次元と Step 3 (b)）を数ベクトルについて自分で述べる形にした。Lean は TheoremTensorBasisKroneckerFamilyOfBasis.lean の tensor_basis_kronecker_family_of_basis（Step 4 と 1 対 1、張る ∧ 線型独立、必要十分版は置かない）。mathlib の Basis.piTensorProduct を移しただけの kroneckerTensorPowBasisOf を削除した。SageMath 172_tensor_basis/check_02_kronecker_family_of_basis.sage（259 件 PASS）。レビュー 2 回。npm run check・verify-check-linkage・verify-every-proof-has-check・lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (d4c44p15d)。
2026-11-13: Lean の通しの証明のゴールラインの確認の四百四十二個目として、状態台帳の (d4c44p15b) を行った。人手 kronecker_family_of_independent_family_is_independent の必要十分版を置くと判断し、NecSuf/ProductFamilyOfIndependentFamilyIsIndependent.lean（係数は可換と限らない半環、b_a は任意の型 κ の上の関数。具体版の「積の可換律」の段は χ・δ の値が 0・1 なのでどの元とも交換することに置き換わり、乗法の可換則は効かない）と導出 ClaimKroneckerFamilyOfIndependentFamilyIsIndependentFromNecSuf.lean（具体版と同じ型）を足した。レビュー 2 回（任意 4 件を直し、2 回目は指摘なし）。次は (d4c44p15c)（tensor_basis (2) の Step 4 を張ることと線型独立性で書き直し、Lean の (2) を人手と 1 対 1 にする）。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百四十一個目として、状態台帳の (d4c44p15) を (d4c44p15a)〜(d4c44p15e) に割り、(d4c44p15a) を行った。人手に主張 kronecker_family_of_independent_family_is_independent（線型独立な b_1..b_4 のクロネッカー積の族は線型独立。成分の比較と、P^{(s)}・χ^{(s)} を置いた A(s) の下げる帰納法）を足し、Lean 具体版 ClaimKroneckerFamilyOfIndependentFamilyIsIndependent.lean（1 対 1 の calc）と SageMath（174855 件 PASS）を置いた。レビュー 2 回。全検査通過。tensor_basis (2) の Step 3 (b) 依存を外すための第一歩。次は (d4c44p15b)（必要十分版の要否）。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百四十個目として、状態台帳の (d4c44p14) を行った。必要十分版 NecSuf.xl_mul_string_comm・string_mul_self の Monoid から結合則を外すと偽になることを、6 元の単位的マグマ SixElementUnitalMagma の反例（xl_mul_string_comm_false_without_assoc・string_mul_self_false_without_assoc、decide）で示し、仮定は Monoid のままとした。docs・README・check-no-sorry の targets を合わせた。人手・SageMath・通しの定理の型は不変。次は (d4c44p15)。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百三十九個目として、状態台帳の (d4c44p13) を行った。人手 Z_Y_generate_algebra の Step 3 後半の E_1⋯E_M の接頭積を P_s から Q_s（Q_1 := E_1・Q_{s+1} := Q_sE_{s+1}）へ改名し、Step 2 の P_r（σ^x の接頭積）との文字の重なりを解いた。Lean のコメント・lean/docs/necsuf-zy-generate.md・lean/README.md・SageMath check_03（1144 件 PASS）を合わせた。主張・Lean のコード・通しの定理の型は不変。次は (d4c44p14)。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百三十八個目として、状態台帳の (d4c44p12) を行った。人手 def_jordan_wigner_Z_matrices・def_jordan_wigner_Y_matrices に、因子 F_j（m を固定、σ_j^x (j<m)・σ_m^z/σ_m^y）と def_finite_product_of_matrices の有限積としての読み方（サイト番号の昇順に左から）を書き、未定義の空積に頼っていた m = 1 を r = 1 の式から Z_1 = σ_1^z が出る形にした。Z_Y_generate_algebra Step 2 と、空積を引いていた本文 3 か所を定義の参照に揃えた。Lean は sigmaZ_zero_eq_Z・sigmaY_zero_eq_Y を人手の m = 1 の 3 段の calc にし、コメントを合わせた。通しの定理の型は不変。次は (d4c44p13)。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百三十七個目として、状態台帳の (d4c44p11c) を行った。人手 Z_Y_generate_algebra Step 2 の Z_m = P_{m-1}σ_m^z・Y_m = P_{m-1}σ_m^y（m ≥ 2）の 4 行の鎖と 1 対 1 の calc で Z_eq_sigmaXPrefixProduct_mul・Y_eq_sigmaXPrefixProduct_mul を書き直し（Z_eq_finiteMatrixProduct → finiteMatrixProduct_succ → jwFactor の定義 → sigmaXPrefixProduct_eq_finiteMatrixProduct）、人手どおり m ≥ 2 の形に狭めた（sigmaZ/Y_eq_…・sigma_mem_adjoin_of_previous_sigmaX・導出の _of_necSuf も同じ。NecSuf.local_mem の n = 0 は sigmaZ_zero_eq_Z ほかで補った）。人手・SageMath・通しの定理の型は不変。次は (d4c44p12)。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百三十六個目として、状態台帳の (d4c44p11b) を行った。人手 site_pauli_prefix_product_kronecker_form の Lean 具体版（ClaimSitePauliPrefixProductKroneckerForm.lean。左辺は finiteMatrixProduct、s = 1 の 2 行と s → s+1 の 6 行の calc）、Lean の Z・Y が人手の定義の積 ∏F_j^{(z)}・∏F_j^{(y)} に等しいこと（Z_eq_finiteMatrixProduct・Y_eq_finiteMatrixProduct）、必要十分版 NecSuf.prefix_product_eq_map_prefixFamily（MulOneClass、積を保つ写像、行き先は Mul だけ）と導出を足した。人手・SageMath・通しの定理の型は不変。新しい件 (d4c44p20)（Z・Y・ε・G のクロネッカー積表示の段を rfl で済ませている箇所を 1 対 1 に）。次は (d4c44p11c)。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百三十五個目として、状態台帳の (d4c44p11) を (d4c44p11a)〜(d4c44p11c) に割り、(d4c44p11a) を行った。行列の有限積 finiteMatrixProduct の添字を一般の有限型 ι に広げ（Mat(n,ℂ) は ι := Fin n、Mat(2^M,ℂ) は ι := Conf M）、人手 Z_Y_generate_algebra Step 2 の積の表示 P_r = ∏σ_j^x に 1 対 1 の具体版 sigmaXPrefixProduct_eq_finiteMatrixProduct（r = 1 の 4 行・一段の 3 行の calc）、必要十分版 NecSuf.string_eq_finProdLeft（* と 1、1 * x 0 = x 0 だけ）と導出を足した。人手・SageMath・通しの定理の型は不変。新しい件 (d4c44p19)（具体版が NecSuf.finProdLeft を直に使う箇所を finiteMatrixProduct へ）。次は (d4c44p11b)（site_pauli_prefix_product_kronecker_form の Lean 具体版）。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百三十四個目として、状態台帳の (d4c44p10) を行った。人手 kronecker_multilinear の具体版 ClaimKroneckerMultilinear.lean（成分の鎖 5 行と 1 対 1 の siteProd_update_sum_smul_apply、siteProd_update_sum_smul・siteProd_update_smul、数ベクトルの vecKron_update_*）、必要十分版 NecSuf/KroneckerMultilinear.lean（可換半環。3 段目の可換則は反例で外せない）、導出 ClaimKroneckerMultilinearFromNecSuf.lean を足し、使う側の MultilinearMap.map_update_sum・map_update_smul（5 ファイル）を新しい具体版へ替えた。人手・SageMath・主張の型は不変。新しい件 (d4c44p17)（map_smul_univ の 3 箇所）・(d4c44p18)（siteOp の線型写像の map_smul）。次は (d4c44p11)。

2026-11-12: Lean の通しの証明のゴールラインの確認の四百三十三個目として、状態台帳の (d4c44p9) の判断と (cl7a) を行った。tensor_basis の証明の Step 3 (a)（張る族の元数は次元以上）は証明せず、基底は線型独立性を直接示す側を採ると決めた。人手 Z_Y_linearly_independent の Step 1 を、𝓑 = {I,σ^x,σ^y,σ^z} の線型独立性を成分の比較（4 成分の鎖、(p)〜(s) の 3 行の鎖、係数が零の 5 本の鎖）で示す形にし（主張は不変）、Lean に 1 対 1 の pauliComb_* と pauliFamily_linearIndependent を足し、SageMath check_02（126 件 PASS）を足した。レビュー 2 回。全検査通過。新しい件 (d4c44p15)（Step 2 の tensor_basis (2) が Step 3 (b) に依ったまま）・(d4c44p16)（def_zero_matrix の 0 と 0_ℂ）。次は (d4c44p10)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百三十二個目として、状態台帳の (d4c44p8) を行った。人手 Z_Y_generate_algebra Step 2 の P_{m-1}P_{m-1} = I を、P_0 := I・P_r := P_{r-1}σ_r^x の積の表示（def_finite_product_of_matrices）・可換の式・二乗の式の r の帰納法の鎖にし、P_{m-1} ∈ 𝒜 と Z_m = P_{m-1}σ_m^z・Y_m = P_{m-1}σ_m^y・P_{m-1}Z_m = σ_m^z の鎖をラベル参照で書いた（主張は不変）。Lean は再帰の sigmaXPrefixProduct の上に各鎖と 1 対 1 の calc と外側の帰納法を置き、必要十分版 NecSuf.xl_mul_string_comm・string_mul_self（モノイド・対合・相異なる番号の可換性）と導出を足した。SageMath check_05（211 件 PASS）。新しい件 (d4c44p11)〜(d4c44p14)。レビュー 6 回。次は (d4c44p9)。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百三十一個目として、状態台帳の (d4c44p6) を行った。人手 Z_Y_generate_algebra Step 3 は 𝓑^{⊠M} が張ることしか使わないので、基底を経由せず（tensor_basis の証明の Step 3 (a) は本文で未証明、Lean は mathlib の基底の一般論に委ねていた）「張る」で結ぶ形に直し、主張 kronecker_family_of_spanning_family_spans（張る族のクロネッカー積の族は全体を張る）を本文・Lean 具体版・必要十分版・導出・SageMath（1950 件 PASS）で足した。Z_Y_linearly_independent の Step 1 の参照を合わせた。(d4c44p7) は文ごと無くなった。新しい件 (d4c44p9)（Z_Y_linearly_independent が未証明の Step 3 (a) に依る）・(d4c44p10)（kronecker_multilinear の Lean 具体版）。次は (d4c44p8)。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百三十個目として、状態台帳の (d4c44p5) を行った。Lean の siteProd_mem を、有限集合の帰納法から人手 Z_Y_generate_algebra Step 3 後半の P_1 := E_1・P_{s+1} := P_sE_{s+1} の帰納法（siteFactorPrefixProduct・siteFactorPrefixProduct_eq_and_mem。一段は kronecker_product_rule (1)・右単位・左単位 2 回の鎖）へ書き直し、必要十分版 NecSuf.map_mem_of_mulSingle_mem も同じ手順の prefixProduct_eq_and_mem にした（仮定は MulOneClass・MulHom・部分半群・Fin n・0 < n）。M = 0 は人手に無く siteProd_one と (ii) で別に閉じる。人手証明・SageMath は不変。次は (d4c44p6)。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百二十九個目として、状態台帳の (d4c44p4) を行った。人手 Z_Y_generate_algebra の Step 1 の鎖のラベルの無い根拠を、pauli_matrix_products・mat_mult・complex_zero_times_is_zero・multiply_by_minus_one・double_negation_in_cc・def_matrix_scalar_multiple・scalar_multiple_by_one・scalar_multiple_is_associative・kronecker_product_rule (1)(2)・identity_matrix_is_left_unit_of_mat_mult・kronecker_multilinear・distinct_site_pauli_matrices_commute の参照と 1 行 1 事実の鎖にした（準備 (f)(g) を Step 1 の冒頭へ移した）。Lean の pauliY_mul_pauliZ・pauliX_eq・siteOp_mul_same・sigmaX_mul_self・sigmaX_eq を各鎖と 1 段ずつの calc にし、zy_prep_I_mul_I・zy_prep_neg_I_mul_I を DefinitionTransferMatrixSymbols.lean へ移した（型は不変）。SageMath check_04（308 件 PASS）。レビュー 2 回。全検査通過。新しい件 (d4c44p8)（Step 2 のラベルの無い根拠）。次は (d4c44p5)。注意: lake build を 2 本同時に走らせると .olean が読めずに落ちる。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百二十八個目として、状態台帳の (d4c44p3) を行った。人手 Z_Y_generate_algebra の証明の冒頭が Pauli 行列を pauli_matrix_products を引かずに成分で置き直し、σ_k^a の出典を def_transfer_matrix_symbols としていたので、冒頭・Step 1 の鎖・クロネッカー積への持ち上げの鎖・Step 3 の R の 4 成分の鎖の根拠を pauli_matrix_products と def_site_pauli_matrices のラベル参照に揃えた（主張と計算は不変。Lean はコメントだけ）。レビュー 2 回。npm run check・verify-check-linkage・lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (d4c44p4)。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百二十七個目として、状態台帳の (d4c44p2) を行った。人手 Z_Y_generate_algebra の主張から、抽象テンソル冪を廃したときの名残で中身の無い括弧書き「def_kronecker の同一視により Mat(2^M,ℂ) = Mat(2^M,ℂ) であり、S の元はいずれも 2^M 次の複素行列である」を削った（主張の中身は不変）。Lean の ClaimZYGenerateAlgebra.lean・ClaimZYGenerateAlgebraFromNecSuf.lean のコメントと SageMath の overview.md に残っていた Mat(2,ℂ)^{⊗M} の表記も直した。レビュー 2 回。npm run check・verify-check-linkage・lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (d4c44p3)。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百二十六個目として、状態台帳の (d4c44p1) を行った。Lean の Z_Y_generate_algebra の Step 3 後半を行列単位の基底の経路から人手の経路（𝓑={I,σ^x,σ^y,σ^z} の基底 pauliBasis、tensor_basis (2) のクロネッカー積の形 kroneckerTensorPowBasisOf、各 E_k ∈ 𝒜 の場合分け、siteProd_mem）へ揃え、必要十分版からの導出も同じ手順にした（定理の型は不変）。新しい件 (d4c44p5)〜(d4c44p7)（siteProd_mem の帰納法の向き、mathlib へ委ねた 2 か所、人手の dim=4 の根拠）を台帳に足した。次は (d4c44p2)。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百二十五個目として、状態台帳の (d4c44p) を行った。人手 Z_Y_generate_algebra の Step 3 後半の未定義の σ_k^{a_k} を E_k := I⊠⋯⊠e_k⊠⋯⊠I に置き直し、E_k ∈ 𝒜 を場合分けで、E_1⋯E_M = e_1⊠⋯⊠e_M を P_s の帰納法（kronecker_product_rule (1)・右単位・左単位）で書き、P_s ∈ 𝒜 も同じ帰納法で示した。SageMath check_03（1144 件 PASS）を足し、Lean のコメント 2 か所を合わせた（主張・証明は不変）。レビュー 2 回。全検査通過。新しい件 (d4c44p1)〜(d4c44p4)（Lean の Step 3 後半が行列単位の基底という別経路、主張の中身の無い同一視の文、Pauli 行列の出典、Step 1 のラベルの無い根拠）を足した。次は (d4c44p1)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。164 の check_01 は run-all-checks.sh からだと _shared の読み込みで落ちる。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百二十四個目として、状態台帳の (d4c44o4) を行った。人手 check_number_operator_is_hermitian (3) の β を def_check_fermi の Y̌ の係数と同じ ℂ の商 1_ℂ/u として読み、準備 (f)（conj(β) = β の 8 行）を足して (ψ̌_μ^†)^* の鎖の 4 行目の根拠にした。Lean star_checkQ を push_cast; ring から準備 (f) と 1 段ずつの calc に直した（引数 hM を追加）。SageMath に準備 (f) の鎖を足した（等号 6206 件、PASS）。次は (d4c44p)。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百二十三個目として、状態台帳の (d4c44o3) を行った。人手 check_number_operator_is_hermitian (3) の (ψ̌_μ^†)^* の鎖の 3 行目（(2) と β ∈ ℝ を束ねていた）を、(2) の行と complex_conjugate_of_real_inclusion（r → β）の行に割った（鎖 7 行）。Lean checkPsiDag_conjTranspose の calc を同じく 7 段にし、SageMath（等号 6056・否定 47、PASS）・overview・lean/docs を合わせた。主張の型は不変。レビュー 1 回。全検査通過。次は (d4c44o4)（新しい 4 行目の β_ℂ も同じ回に揃える）。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin（負荷が高いと (3)(4) の検算に 1 時間近くかかる）。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百二十二個目として、状態台帳の (d4c44o2) を行った。人手 check_number_operator_is_hermitian (3) に準備 (e)（r_ℂ/d_ν = −α_ν の 5 行）を足し、(ψ̌_μ^†)^* の鎖の最後を「準備 (e) を右辺から左辺へ」「def_check_fermi (μ→ν)」の 2 行に割った。Lean checkPsiDag_conjTranspose を人手の 6 行と 1 段ずつの calc にし（2 行目に必要十分版の特殊化 conjTranspose_add_smul_tensorPow を足した）、SageMath（等号 6041・否定 47、PASS）と lean/docs を合わせた。主張の型は不変。レビュー 2 回。全検査通過。新しい件 (d4c44o3)（鎖の 3 行目の束ね）・(d4c44o4)（β の ℝ と ℂ の商の一致、star_checkQ）を足した。次は (d4c44o3)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-12: Lean の通しの証明のゴールラインの確認の四百二十一個目として、状態台帳の (d4c44o) を行った。Lean の checkPsi（ψ̌_μ）を人手 def_check_fermi の定義式どおり Ž の係数 checkPPlus := r_ℂ/d で定義し直し（旧 (-checkP)•Ž + …。checkPsi_eq は rfl に）、下流が使う (-p)Ž + qY̌ の形へは人手の主張を 1 段ずつ引く橋 checkPPlus_eq_neg_checkP・checkPsi_eq_neg_checkP で渡した。下流 4 ファイル・ch016-formalization.md・check-no-sorry.sh を合わせた。人手・SageMath は不変。レビュー 1 回（必須なし、任意 4 件を直した）。人手 check_number_operator_is_hermitian (3) の最後の行の根拠不足を新しい件 (d4c44o2) にした。次は (d4c44o2)
2026-11-12: Lean の通しの証明のゴールラインの確認の四百二十個目として、状態台帳の (d4c44n) を行った。必要十分版 NecSuf.det_of_cols（列 c(∓s,b) から ring で値を出していた）を、具体版 det_checkPmat の 29 行の鎖と 1 段ずつ同じ det_of_quotient_entries_eq_mul_inv・det_of_quotient_entries・det_of_quotient_entries_ne_zero（体 F、仮定は u,d ≠ 0・d u = 2q・ρ ≠ 0。q ≠ 0 は仮定から出す）に置き換え、導出 *_of_necSuf を特殊化にした（field_simp・ring を外した）。人手・SageMath は不変。レビュー 2 回（必須 1 件・任意 5 件を直した）。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (d4c44o)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百十九個目として、状態台帳の (d4c44m) を行った。diagonalization_check_P_D の Step 1 の √M_col > 0 の根拠（sqrt_nonnegative_existence_uniqueness は存在と一意性だけ）を、inclusion_zz_to_rr_of_positive_is_at_least_one と新しい主張 sqrt_of_positive_real_is_positive（000_calculation_formulae_20_29.ts）の参照にした。Lean は具体版・必要十分版 NecSuf.pos_of_nonneg_of_sq_eq_pos（Monoid・Zero・PartialOrder と 0·0 = 0 だけ）・導出を置き、sqrtM_ne_zero の段 1 を合わせた。relation_of_gamma_2_theta_tilde (4) の |γ_2| > 0 の具体版 absGamma2_pos_of_ne_zero を足し、absGamma2_thetaTilde_pos・checkR_pos をそれ経由にし、NecSuf.absOf_pos も同じ 3 段にした。SageMath 2 本（新設 35 等号、048 check_06 54/54）。レビュー 2 回（1 回目 必須 3 件・任意 4 件、2 回目 必須 1 件・任意 1 件を直した）。全検査通過。次は (d4c44n)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。048_claim_A_theta_tilde は run-all-checks.sh からだと _prelude.sage の読み込みで落ちるので、そのディレクトリで sage を直に回す。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百十八個目として、状態台帳の (d4c44l) を行った。diagonalization_check_P_D の Step 2 の A P̌ = P̌ Ď の 3 行（ラベルなしの根拠）を、前置き（P̌ = [v_+ v_-]、Ď が対角行列）と mat_columnwise・eigenvector_of_A_theta_tilde・Ď の定義・新しい主張 column_matrix_times_diagonal_matrix_scales_columns（004_transfer_matrix.ts。[b_1 ⋯ b_p] D = [D_11 b_1 ⋯ D_pp b_p]）を引く 6 行の鎖にした。Lean は新しい主張の具体版・必要十分版（AddCommMonoid・Mul と x0 = 0・積の可換性だけ）・導出を置き、AMat_mul_checkPmat と NecSuf.skew2_mul_of_cols を simp から人手と 1 段ずつの 6 段の calc にした。SageMath 2 本（279 件・190/190、厳密）。レビュー 2 回。全検査通過。次は (d4c44m)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百十七個目として、状態台帳の (d4c44k5) を行った。人手 anticommutator_of_check_psi の準備 4 の -(-z) = z を double_negation_in_cc の参照 1 行にし、それだけが引いていた旧 (i)（(-1_C)(-1_C) = 1_C）を消して旧 (ii)〜(ix) を (i)〜(viii) に繰り上げた。値と主張は不変。SageMath・Lean のコメントの番号を合わせた。レビュー 2 回（2 回目は指摘なし）。全検査通過。次は (d4c44l)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百十六個目として、状態台帳の (d4c44k4) を行った。必要十分版 NecSuf.eq_conj_of_mul_eq（diagonalization_check_P_D の Step 4）を、IsUnit P.det と mathlib の Matrix.mul_nonsing_inv から、モノイドで AP = PD と右逆元 PQ = 1 から A = PDQ を示す 4 段の calc に替え（具体版の 4 行と 1 対 1。行列式・可換性・左逆元は効かない）、導出は具体版の 2 段目と同じ inv_eq_detInv_smul_adjTwo・mul_detInv_smul_adjTwo で hQ を渡す形にした。レビュー 2 回（任意 6 件を直し、2 回目は指摘なし）。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (d4c44k5)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百十五個目として、状態台帳の (d4c44k3) を行った。余因子行列の 2 主張の準備 (a)(b)(c) を主張 complex_times_negation_is_negation_of_product_in_cc・negation_times_complex_is_negation_of_product_in_cc・negation_plus_self_is_zero_in_cc（000_calculation_formulae_30_44.ts）にして成分の鎖から引き、anticommutator_of_check_psi の準備 4 (ii)(iii) も同じ参照にした（値と主張は不変）。Lean は 3 補題を ClaimNegationInProductAndNegationPlusSelfInCC.lean へ移し、必要十分版 NecSuf/NegationInProductAndNegationPlusSelf.lean と導出を置いた。SageMath 3 件（厳密）。レビュー 1 回（必須なし）。次は (d4c44k4)・(d4c44k5)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百十四個目として、状態台帳の (d4c44k2) を行った。人手に def_adjugate_two_by_two・matrix_times_adjugate_two_by_two・adjugate_times_matrix_two_by_two・two_sided_inverse_of_two_by_two_with_nonzero_det（det ≠ 0 の 2×2 行列は (det)^{-1} adj を両側逆元に持つ）を足し、diagonalization_check_P_D の Step 4 冒頭の可逆性をこれと def_invertible_elements_of_R の逆元の一意性から出した。Lean は具体版 ClaimTwoSidedInverseOfTwoByTwo.lean（mathlib の B⁻¹ = h は一意性の鎖。接点は nonsing_inv_mul の 1 段）、必要十分版 NecSuf/TwoByTwoAdjugateInverse.lean（可換環と u·det = 1 だけ）、特殊化を置き、Step 4 の 2 段目から Matrix.mul_nonsing_inv を外した。SageMath 3 件と check_08（185/185）を足した。新しい件 (d4c44k3)（(a)(b)(c) を主張にする）・(d4c44k4)（必要十分版 eq_conj_of_mul_eq の逆行列）。次は (d4c44k3)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百十三個目として、状態台帳の (d4c44k) を行った。diagonalization_check_P_D の Step 4 の鎖を、identity_matrix_is_right_unit_of_mat_mult・def_invertible_elements_of_R（M → 1）の gg^{-1} = I・mat_mult_associative・Step 2 の 4 行にし（ラベルなしの根拠と、右辺の読み方にすぎない最後の行を除いた）、statement に P̌^{-1} の出典と (P̌Ď)P̌^{-1} の読み方を書いた。Lean の具体版 AMat_thetaTilde_eq_checkPmat_mul_checkDmat_mul_inv と必要十分版 eq_conj_of_mul_eq を同じ 4 段の calc にした。SageMath に check_08_step4_chain.sage（167/167 PASS）。新しい件 (d4c44k2)（det ≠ 0 なら 2×2 行列は可逆、の主張を足す）。次は (d4c44k2)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百十二個目として、状態台帳の (d4c44j) を行った。3 か所で重複していた i(2_ℂi)^{-1} = 2_ℂ^{-1} の 6 行の鎖を主張 i_times_inverse_of_two_i_is_inverse_of_two_in_cc にし、exp_of_negative_i_real_as_cos_minus_i_sin・relation_of_gamma_2_theta_tilde・periodicity_of_check_fermi から引くようにした（後の 2 つの鎖は 27 行 → 22 行）。Lean は ClaimITimesInverseOfTwoIIsInverseOfTwoInCC.lean に鎖と非零性の補題を移して内容の名前に替え（complex_I_mul_inv_two_mul_I ほか）、real_inclusion_cos_add_I_mul_sin を 22 段にした。SageMath は検算を新ラベルへ移し、2 つの鎖の検算を 22 行に合わせた（PASS）。レビュー 1 回（必須は空のログで、流し直した）。npm run check・verify-check-linkage・verify-every-proof-has-check（未検算 0 件）・lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (d4c44k) 以降。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百十一個目として、状態台帳の (d4c44i5) を行った。periodicity_of_check_fermi の主張の前置きの整数の像の記号 a_ℝ := ι_{ℤ→ℝ}(a) の文字を j に替え、根拠で引く real_inclusion_preserves_sum・inclusion_rr_to_cc_is_injective の ℝ の変数 a との重なりを解消した。主張・式・値は不変。Lean・SageMath は不変。レビュー 1 回（必須なし）。次は (d4c44j)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百十個目として、状態台帳の (d4c44i4) を行った。periodicity_of_check_fermi (2)(3) の根拠の欄の ℝ の一般の恒等式の変数 u, v を、同じブロックで使われていない p, q に替えて代入を添え（固定の u := 2_ℂ(√M_col)_ℂ との重なりを解消）、(2) の -(2πk_ℝ)・(3) の -(2π) に括弧を補った。主張と値は不変。Lean DefinitionCheckFermi.lean のコメントを合わせた。レビュー 2 回（必須なし。任意はすべて直すか新しい件にした）。npm run check・verify-check-linkage・verify-every-proof-has-check（未検算 0 件）・lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。新しい件 (d4c44i5)（主張の a と根拠で引くブロックの a の重なり）を足した。次は (d4c44i5)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百九個目として、状態台帳の (d4c44i3) を行った。conjugate_index_of_check_Z_Y (1) の θ̃_{M+1−μ} の鎖の「分数の差」「約分」「差への分配法則」を def_real_quotient の商 y z^{-1} で 1 行 1 操作に開き（20 → 26 等号）、Lean thetaTilde_conj を同じ 26 段の calc に、SageMath check_angle_chain.sage を同じ行に合わせた。主張は不変。次は (d4c44i4)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百八個目として、状態台帳の (d4c44i2) を行った。periodicity_of_check_fermi (3) の P̌_{M+1−μ} の分数が def_complex_quotient の商であること（分母 (2_ℂ(√M_col)_ℂ)γ_2(θ̃_μ)・2_ℂ(√M_col)_ℂ）を主張に書き、分母が ℂ^× に属することを diagonalization_check_P_D の Step 1 を ν で読んだ u, d_ν ∈ ℂ^× と 2 行の鎖 d_ν = uγ_2(−θ̃_ν) = uγ_2(θ̃_μ) で証明に書いた（値と鎖は不変）。Lean に具体版 ClaimCheckPmatConjugateIndex.lean（checkPmat_conj: 人手の 3 行と 1 対 1 の calc、checkPmat_conj_denominator_ne_zero）を足した（必要十分版は等しい元の代入だけなので置かない）。SageMath に分母の検算を足した（PASS）。レビュー 2 回（必須なし。任意 6 件のうち 5 件を直し、1 件を (d4c44i4) にした）。npm run check・verify-check-linkage・verify-every-proof-has-check（未検算 0 件）・lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (d4c44i3)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百七個目として、状態台帳の (d4c44i) を (d4c44i1)・(d4c44i2) に割り、(d4c44i1) を行った。定義 def_real_quotient（ℝ の商 y/z := y z^{-1}）を def_real_difference の直後に足し、periodicity_of_check_fermi (2) の θ̃_{μ+kM} の鎖の「分数の和」「約分」をその商で 1 行 1 操作に開いた（12 → 17 行。5・7 行目の差の定義も参照にした）。Lean thetaTilde_add_int_mul を人手の 17 行と 1 段ずつの calc にした。SageMath・lean/docs を合わせた。主張の型は不変。レビュー 2 回（必須なし。任意 3 件を直した）。npm run check・verify-check-linkage・verify-every-proof-has-check（未検算 0 件）・lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。新しい件 (d4c44i3)（conjugate_index_of_check_Z_Y (1) の分数の差と約分）を足した。次は (d4c44i2)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百六個目として、状態台帳の (d4c44h2) を行った。euler_formula_cos_sin の「i sin θ を足して引いた」「cos θ を足して引いた」の行を、新しい主張 sum_plus_difference_is_twice_first_in_cc（(a+b)+(a-b) = 2_ℂa、11 行）・sum_minus_difference_is_twice_second_in_cc（(a+b)-(a-b) = 2_ℂb、17 行。exp_of_negative_i_real_as_cos_minus_i_sin の準備の第一の鎖を移した）の参照に替え（第 2 の等式の鎖は積の結合律の 1 行を足した）、準備の鎖の根拠の無かった cos θ + i(-sin θ) = cos θ - i sin θ を i_times_negated_real_is_negation_of_i_times と def_complex_difference の 2 行に割った。exp_of_negative_i_real_as_cos_minus_i_sin は主鎖 6 行目を新しい主張の参照にし、準備の鎖を 1 つにした（結合律を右辺から左辺へ当てる 2 行に向きを書き添えた）。Lean に具体版 ClaimSumPlusAndMinusDifferenceInCC.lean・必要十分版 NecSuf/SumPlusAndMinusDifference.lean・導出を足し、exp_neg_I_prep_add_sub_sub を complex_sum_sub_difference に置き換えた。SageMath に 2 件の検算と euler の check_difference_lines.sage を足した。次は (d4c44i)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百五個目として、状態台帳の (d4c44h) を (d4c44h1)・(d4c44h2) に割り、(d4c44h1) を行った。体であることだけを根拠にしていた `-(-z) = z`（negation_of_i_times_negated_real_is_i_times）と `b - a = -(a - b)`（sin_of_negated_real）を、新しい主張 double_negation_in_cc・reversed_difference_is_negation_of_difference_in_cc（000_calculation_formulae_30_44.ts）の参照に替えた。Lean に具体版・必要十分版・導出を足し、SageMath に 2 件の検算を足した。次は (d4c44h2)（euler_formula_cos_sin の足し引きの行）。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百四個目として、状態台帳の (d4c44g) を行った。i/2 を各自で i·2_ℂ^{-1} と置いていた def_V1_plus_square_root・symmetrized_transfer_matrix_on_sectors・cosh_sinh_coefficient_conversion_for_check・V1_plus_square_root_property を def_complex_quotient（z→i, w→2_ℂ）の参照に替え、2_ℂ ∈ ℂ^× と逆元の出典を inclusion_rr_to_cc・multiplicative_group_of_cc で書いた。主張と鎖の式・Lean の証明・SageMath は不変（Lean は対応コメントだけ直した）。z/k! の局所記法は ℂ の商ではないので範囲外の新件 (d4c44w) にした。範囲外の件は (d4c44w)〜(d4c44y)。次は (d4c44h)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百三個目として、状態台帳の (d4c44f) を行った。frobenius_inner_product_axioms の Step 5 場合 2 の t := ū/(‖B‖²)_ℂ を β := ‖B‖² と def_complex_quotient で t = ū(β_ℂ)^{-1} と開いた。新しい主張 real_inclusion_preserves_inverse（Lean の具体版 real_inclusion_inv）を足し、三つの積の項と合わせる鎖を、ラベル参照付きの一ステップ一定理にした。SageMath は check_chain（49 件）と check_03（648 件）。範囲外の件は (d4c44t)〜(d4c44v) とした。次は (d4c44g)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百二個目として、状態台帳の (d4c44e2) を行った。check_number_operator_is_hermitian (3) の conj(α_μ) = −α_ν の鎖を、def_complex_quotient の商と d_μ := u b_μ・d_ν := u b_ν で開き、準備 (a)〜(d) と主鎖 13 行にした。逆元の共役を新しい主張 complex_conjugate_of_inverse として足した（SageMath・Lean 具体版つき）。Lean の star_checkP を map_div₀ の rw から人手と 1 段ずつの calc にし、引数を IsingParam にした（通しの定理の型は不変）。範囲外の件は (d4c44q)〜(d4c44s) に書いた。次は (d4c44f)。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百一個目として、状態台帳の (d4c44e) を (d4c44e1)・(d4c44e2) に割り、(d4c44e1) を行った。Z_Y_linearly_independent の Step 1 の A の展開（「同分母の和」「約分」の名前だけの根拠）を、def_complex_quotient の商で開いた Z_Y_generate_algebra の証明の Step 3 前半の参照に替えた。Lean・SageMath は不変。次は (d4c44e2)（check_number_operator_is_hermitian (3) の α_μ の共役の鎖）。
2026-11-11: Lean の通しの証明のゴールラインの確認の四百個目として、状態台帳の (d4c44d4) を行った。Z_Y_generate_algebra の Step 3 の展開の係数の /2 を def_complex_quotient の商 /2_ℂ と読み（2_ℂ ∈ ℂ^×）、準備 (a)〜(g) と R_11〜R_22 の鎖に開いた。Lean の matrix_two_decomp を simp; ring から 1 段ずつの calc（zy_prep_*・kappa0 ほか・pauliDecompRhs_apply_*）に、SageMath に 164_Z_Y_generate_algebra/check_02_pauli_decomposition_chains.sage（132/132 PASS）を足した。新しい件 (d4c44p)（Step 3 後半の a_k が未定義で a_{11} と文字が重なる）。次は (d4c44e)。
2026-11-11: Lean の通しの証明のゴールラインの確認の三百九十九個目として、状態台帳の (d4c44d3) を行った。def_check_fermi の「定義が意味をもつ」段落で係数の分数を def_complex_quotient の商と読み、分母を diagonalization_check_P_D の d・u、分子を −(r_C)・r_C・1_C と書き、分母 ≠ 0 を同 Step 1 の u, d ∈ ℂ^× の参照にした（r > 0 は relation_of_gamma_2_theta_tilde (4)）。Lean の sqrtM_ne_zero を √M > 0 と第 1 成分の比較の 2 段にした（simp を外した）。主張の型は不変。レビュー 2 回（必須なし）。新しい件 (d4c44o)（checkPsi の定義が −checkP で人手の +r/(2√M b) と 1 対 1 でない）。次は (d4c44d4)。
2026-11-11: Lean の通しの証明のゴールラインの確認の三百九十八個目として、状態台帳の (d4c44d2) を行った。diagonalization_check_P_D の statement に行列式の右辺の分数を def_complex_quotient の商と読むこと（分母 (2_ℂ ℓ)γ_2(−θ̃_μ)、ℓ := (ι_{ℤ→ℝ}(M_col))_ℂ、分子 −|γ_2|_ℂ）と √M_col の根号の中を書き、Step 3 の「(2√M)^2 = 4M」「ℂ の四則」「同類項の統合」の 5 行を、前置き (a) s s = ℓ（5 行）・(b) ℓ, 2_ℂ ℓ, q ∈ ℂ^×・(c) 1_ℂ + 1_ℂ = 2_ℂ（4 行）・(d) d u = 2_ℂ q（12 行）と det P̌_μ = (−ρ)/q の 29 行の鎖にし、det ≠ 0 を成分の比較と群の積にした。Step 1 の c = d^{-1} を 3 行の鎖に、Step 2 のスカラー倍に def_matrix_scalar_multiple を引いた。Lean は sqrtM_mul_sqrtM・checkM_ne_zero・checkW_ne_zero・one_add_one_eq_two_complex・checkD_mul_checkU・checkC_eq_inv・checkC_ne_zero・det_checkPmat_eq_mul_inv を足し、det_checkPmat・det_checkPmat_ne_zero を人手と 1 段ずつに（field_simp・ring を外した）。SageMath に 048_claim_A_theta_tilde/check_07_det_chain.sage（160/160 PASS）。主張の型は不変。レビュー 2 回（1 回目 必須 1 件を直した。2 回目 必須なし）。npm run check・verify-check-linkage・verify-every-proof-has-check・lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。範囲外の指摘は (d4c44k)〜(d4c44n)。次は (d4c44d3)
2026-11-11: Lean の通しの証明のゴールラインの確認の三百九十七個目として、状態台帳の (d4c44d) を (d4c44d1)〜(d4c44d4) に割り、(d4c44d1) を行った。diagonalization_check_P_D の statement に c と P̌ の成分の分数を def_complex_quotient の商と読むこと（分母 (2_ℂ(√M)_ℂ)b・2_ℂ(√M)_ℂ）を書き、Step 1 の分母 ≠ 0 を inclusion_rr_to_cc の成分の比較と multiplicative_group_of_cc の群の積で示し、Step 2 の第 1 成分 c x = x/d（5 行）と第 2 成分 cb = 1_ℂ/u（13 行）を体の公理と逆元を 1 行に 1 つずつ当てる鎖にした（u := 2_ℂ s、d := u b。e は exp の検査に反応するので u）。Lean は checkU_ne_zero・checkD_ne_zero・checkC_mul を足し checkC_mul_b を 13 段の calc に（field_simp を外した）。SageMath は 048_claim_A_theta_tilde/check_06_quotient_chains.sage。主張の型は不変。次は (d4c44d2)（同じブロックの Step 3 の det の鎖）。
2026-11-11: Lean の通しの証明のゴールラインの確認の三百九十六個目として、状態台帳の (d4c44c) を行った。relation_of_gamma_2_theta_tilde・periodicity_of_check_fermi の準備の第一の cos θ + i sin θ = exp(iθ) の鎖の分数の行（体だけを根拠にした x(y/z) = (xy)/z・(xa)/(ya) = x/y・x/z + y/z = (x+y)/z・(2a)/2 = a）を def_complex_quotient の zw^{-1} に開き、体の公理と multiplicative_group_of_cc の逆元を 1 行 1 つずつの 27 行にし、前置きの「分数は定まる」を参照にした。Lean は共有の real_inclusion_cos_add_I_mul_sin（DefinitionThetaGamma.lean）を 27 段の calc に。SageMath の 2 つの鎖を合わせ、逆元の取り違えの対照を足した。主張の型は不変。範囲外の指摘は (d4c44i)・(d4c44j)。次は (d4c44d)。
2026-11-11: Lean の通しの証明のゴールラインの確認の三百九十五個目として、状態台帳の (d4c44b) を行った。euler_formula_cos_sin の分母 2・2i を def_complex_quotient の商と読むことと 2_ℂ・i・2_ℂ i ∈ ℂ^× を主張に書き、根拠の無かった cos θ = (2cos θ)/2・sin θ = (2i sin θ)/(2i) を 5 行ずつに割った。cos_of_negated_real・sin_of_negated_real の「分数は定まる」を def_complex_quotient の参照にし、sin の (-x)/y = -(x/y) を 5 行に割った（Lean の real_inclusion_sin_neg も 5 段に）。SageMath を足した。範囲外の指摘は (d4c44h) にした。次は (d4c44c)。
2026-11-11: Lean の通しの証明のゴールラインの確認の三百九十四個目として、状態台帳の (d4c44) を (d4c44a)〜(d4c44g) に割り、(d4c44a) を行った。det_A_theta_tilde・anticommutator_of_check_psi の前置きで各自に置いていた商 z/w := zw^{-1} と「準備の商」の根拠、arg_of_quotient_of_complex_numbers の z_1/z_2 = z_1 z_2^{-1} の根拠（multiplicative_group_of_cc の記法を一般の商に使っていた）を def_complex_quotient の参照にした。Lean はコメントだけ。主張の型・SageMath は不変。ほかの証明に残る ℂ の商は (d4c44b)〜(d4c44g) として台帳に書いた。次は (d4c44b)。
2026-11-11: Lean の通しの証明のゴールラインの確認の三百九十三個目として、状態台帳の (d4c43) を行った。exp_of_negative_i_real_as_cos_minus_i_sin の前置きの 2_ℂ ≠ 0_ℂ・i ≠ 0_ℂ を、mathlib の two_ne_zero・Complex.I_ne_zero ではなく、人手の成分の比較（第 1 成分 2 ≠ 0、第 2 成分 1 ≠ 0）と 1 対 1 の補題 exp_neg_I_prep_two_ne_zero・exp_neg_I_prep_I_ne_zero で受けるようにした。主張の型・人手・SageMath は不変。レビュー 1 回（必須なし）。次は (d4c44)（def_complex_quotient の参照への置き換え）。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百九十二個目として、状態台帳の (d4c42b) を行った。主張・定義の前置きが各自で i := (0,1) を置く箇所と i を出典なしに使う箇所（006 の Pauli 行列の主張、計算公式の章の Euler 公式と i の符号の 3 主張・sin_of_negated_real・exp_of_negative_i_real_as_cos_minus_i_sin、射影と Jordan–Wigner の章の 8 ブロック、A_θ への帰着の章の antiperiodic_exp_sum・commutator_of_H_and_check_Z_Y・def_B1_theta_B2 ほか、V_plus・対角化・熱力学極限の章）を def_imaginary_unit の参照に替えた。計算・主張は不変。Lean・SageMath は不変。レビュー 3 回（3 回目 指摘なし）。次は (d4c43)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百九十一個目として、状態台帳の (d4c42) を (d4c42a)・(d4c42b) に割り、(d4c42a) を行った。計算公式の章に虚数単位の定義 def_imaginary_unit（i := (0_ℝ,1_ℝ) ∈ ℂ）を足し、009 の conjugate_transpose_of_pauli_y と対角化の章の relation_of_gamma_2_theta_tilde・det_A_theta_tilde が後ろの章の antiperiodic_exp_sum の前置きを i の根拠に引いていた箇所をこの定義の参照に替えた。Lean・SageMath はコメントと対応表だけ。計算・主張の型は不変。レビュー 2 回。次は (d4c42b)（ほかの前置きの i と、pauli_matrix_products の出典の無い i）。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百九十個目として、状態台帳の (d4c41c) を行った。人手 check_number_operator_is_hermitian (1) の Z_j^* の 5 行の鎖と 1 対 1 の calc jw_conjTranspose_of_siteOp_conjTranspose_eq（ClaimPositiveDefinite.lean。(XW)^* の反復適用・各因子の (σ^x)^* = σ^x・相異なるサイトの可換性の反復適用を r の帰納法で書いた。逆順の積は revSiteProduct）を足し、Z_conjTranspose・Y_conjTranspose をその系にした。人手・SageMath・主張の型は不変。レビュー 2 回（1 回目 任意 5 件を直し、2 回目 指摘なし）。次は (d4c42)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百八十九個目として、状態台帳の (d4c41b) を行った。人手 check_number_operator_is_hermitian (1) の (σ_k^a)^* = σ_k^a の 5 行の鎖と 1 対 1 の calc siteOp_conjTranspose_of_conjTranspose_eq（ClaimPositiveDefinite.lean。第 k 因子 A と A^* = A について 1 回書き、a = x, y, z は sigmaX/Y/Z_conjTranspose）を足した。人手・SageMath・主張の型は不変。対応表（ch009・ch018・ClaimCheckQHermitian.lean）と check-no-sorry.sh を合わせた。レビュー 2 回（1 回目 任意 3 件を直し、2 回目 指摘なし）。次は (d4c41c)（Z_conjTranspose・Y_conjTranspose を人手の Z_j^* の鎖と 1 対 1 にする）。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百八十八個目として、状態台帳の (d4c41) を (d4c41a)〜(d4c41c) に割り、(d4c41a) を行った。人手 check_number_operator_is_hermitian (1) が文で述べていた Pauli 行列と 2 次の単位行列の共役転置を、成分の鎖の主張 conjugate_transpose_of_identity_matrix_of_order_two・conjugate_transpose_of_pauli_x/z/y（009_eigenvalues_of_V.ts）として足して参照に替え、(σ_k^a)^* の鎖の束ねた行を 2 行に割った。Lean は ClaimConjugateTransposeOfPauliMatrices.lean（1 段ずつの calc）に置き、ClaimPositiveDefinite.lean の旧証明を外した。SageMath conjugate_transpose_of_*/ を足した。主張の型は不変。レビュー 3 回（3 回目は必須なし）。全検査通過。次は (d4c41b)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百八十七個目として、状態台帳の (d4c40) を行った。人手 det_A_theta_tilde の (x − iy)(x + iy)・(x − y)^2・第 3 の等式の鎖で、分配律を外側の積に当ててから内側の 2 つの積へ当てていた 1 行を、外側の行と内側の 2 箇所への同時の行に割った（一ステップ一定理は同時の適用だけを 1 行にまとめてよい）。Lean ClaimDetATilde.lean の 3 つの calc・SageMath det_A_theta_tilde・ch015 を合わせた。主張の型は不変。レビュー 2 回（必須 1 件・任意 2 件を直した）。全検査通過。同じブロックの第 2 の等式の鎖の 16・40 行目を (d4c57) として台帳に足した。次は (d4c41)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百八十六個目として、状態台帳の (d4c39) を行った。Lean の relation_of_gamma_2_theta_tilde (2)（gamma2_mul_gamma2_neg_eq_neg_absSq）の右辺を人手と同じ (−|γ_2|^2)_ℂ にし、使う側（lambda_mul_lambda_thetaTilde・gamma2_mul_gamma2_neg_eq_neg_absGamma2_sq）を合わせた。人手 det_A_theta_tilde の最後の等式の鎖を、(2) をその形のまま当てる 12 行に書き直し（0_ℂ = (0)_ℂ、ℝ の加法逆元、和の像を経る）、向きの書き漏れ 3 行を直した。Lean gamma1R_sq_thetaTilde を 1 段ずつの calc にし、SageMath・ch015 を合わせた。レビュー 2 回（必須 1 件・任意 1 件を直し、2 回目は指摘なし）。全検査通過。次は (d4c40)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百八十五個目として、状態台帳の (d4c38) を行った。人手 det_A_theta_tilde の冪の行の根拠「def_power_of_complex_number より z^2 = (1_ℂz)z = zz」等（12 行。冪の定義と積の単位元を 1 行で当てていた）を、新しく足した主張 square_of_complex_number_is_product（z^2 = zz の 4 行の鎖。000_calculation_formulae_20_29.ts）の参照にした。Lean は具体版 ClaimSquareOfComplexNumberIsProduct.lean と必要十分版 NecSuf.sq_eq_mul_self' からの導出を足し、ClaimDetATilde.lean の sq を新しい主張に替えた。SageMath square_of_complex_number_is_product/ を足した。主張の型は不変。レビュー 2 回（任意 2 件を直し、2 回目は指摘なし）。全検査通過。次は (d4c39)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百八十四個目として、状態台帳の (d4c37) を行った（(d4c36) は (d4c7) 待ちで飛ばした）。人手 det_A_theta_tilde の第一の準備の (x − iy)(x + iy)・(x − y)^2 の鎖で、分配律の行に隠れていた和の結合律を別の行に割った（13 → 14 等号、15 → 17 等号）。Lean complex_sub_I_mul_mul_add_I_mul・complex_sub_sq_chain を人手の行と 1 段ずつの calc にした。SageMath を合わせた。主張の型は不変。レビュー 2 回（1 回目の必須 1 件を直し、2 回目は指摘なし）。全検査通過。次は (d4c38)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百八十三個目として、状態台帳の (d4c35c) を行った。人手 conjugate_index_of_check_Z_Y (1) の θ̃_{M_col+1-μ} の鎖の束ねた行（和と差の像、ℝ の加法の結合律と交換律、結合律（差は加法の逆元の和）、½-μ = -(μ-½) と差の定義）を 1 行 1 操作に割った（11 → 20 等号）。Lean thetaTilde_conj を人手の 20 行と 1 段ずつの calc にした。SageMath・lean/docs を合わせた。主張の型は不変。レビュー 1 回（必須なし）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage・verify-every-proof-has-check 通過。新しい件 (d4c54)〜(d4c56) を台帳に足した。次は (d4c36)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin にあり、非対話のシェルの PATH に入っていない。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百八十二個目として、状態台帳の (d4c35b) を行った。人手 def_half_integer_modes の θ̃_{1-μ} の鎖の「ℝ の加法の結合律と交換律」を def_real_difference 2 行・結合律・交換律・結合律（右辺から左辺へ）・def_real_difference（右辺から左辺へ）2 行に割った（8 → 14 等号）。Lean thetaTilde_one_sub を人手の 14 行と 1 段ずつの calc にした。SageMath・lean/docs を合わせた。主張の型は不変。新しい件 (d4c53) を台帳に足した。次は (d4c35c)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百八十一個目として、状態台帳の (cl3c3j8n2d3d4c35) を 3 つに割り、先頭の (d4c35a) を行った。人手 half_integer_phase_periodicity の角度の鎖の「ℝ の加法の結合律と交換律」を交換律・def_real_difference・結合律・def_real_difference（右辺から左辺へ）・交換律の 5 行に（7 → 11 等号）、主鎖の「cos,sin の 2π 周期性を 2 箇所へ同時適用」を cos・sin の 2 行に（6 → 7 等号）割った。Lean thetaTilde_period_for_checkZY を人手の 11 行と 1 段ずつの calc に、checkPhase_period_for_checkZY の周期性を 2 段にした。SageMath・lean/docs を合わせた。主張の型は不変。レビュー 2 回（1 回目の必須 1 件を直し、2 回目は指摘なし）。全検査通過。新しい件 (d4c52) を台帳に足した。次は (d4c35b)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百八十個目として、状態台帳の (cl3c3j8n2d3d4c34) を行った。DefinitionThetaGamma.lean の docstring が本文に無いラベル（def_theta_mu・relation_of_gamma_2・eigenvector_of_A_theta・gamma_2_theta_is_0）を「原文」と名指ししていたので、参照用ノート integer_momentum_route_not_adopted.ts の項目と本文にあったときのラベル、本文に対応がある定理は本文のラベルと具体版を書いた。定理は移していない（ファイルは分割しない規則）。コードと主張の型は不変。レビュー 2 回。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。新しい件 (d4c51)（本文の経路の Lean がノートの項目の定理 gamma2_eq_zero_iff・gamma2_mul_gamma2_neg_eq_neg_normSq を使っている）を台帳に足した。次は (d4c35)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百七十九個目として、状態台帳の (cl3c3j8n2d3d4c33) を行った。人手 def_gamma1_gamma2_of_theta の主張に、γ_1・γ_2 の定義式を def_A_theta の (1,1) 成分の実数・(1,2) 成分の式と同じく読むことと、行列の (1,1)・(2,2) 成分が実数 γ_1(θ) の inclusion_rr_to_cc による像であることを書き、証明の 1 段落目も同じ読みにした。Lean は DefinitionThetaGamma.lean のコメントだけ合わせた（gamma1 はもとから実数の像）。主張の型は不変。レビュー 2 回。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。新しい件 (d4c50) を台帳に足した。次は (d4c34)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百七十八個目として、状態台帳の (cl3c3j8n2d3d4c32) を行った。本文に ℝ の差を定めるブロックが無かったので、ℂ の def_complex_difference と同じ形の定義 def_real_difference（y - z := y + (-z)、-z は順序体 ℝ の加法の逆元）を足した。real_inclusion_preserves_difference の右辺の差をこの定義の差と書き、最後の行「実数の四則」を 2 行に割った（7 等号）。定義は set_and_algebra_notation の直後に置いた。lean/docs/ch009-formalization.md の行数も直した。def_A_theta の (1,1)・(2,2) 成分の差をこの定義の参照にした。SageMath と Lean の real_inclusion_sub（congr 1; ring を neg_one_mul・← sub_eq_add_neg の 2 段に）を合わせた。主張の型は不変。新しい件 (d4c49)（ℝ の差を名前だけで根拠にしている行の参照化）を台帳に足した。次は (d4c33)
2026-11-10: Lean の通しの証明のゴールラインの確認の三百七十七個目として、状態台帳の (cl3c3j8n2d3d4c31) を行った。人手 det_A_theta_tilde の準備の像の読み方の和・差を real_inclusion_preserves_sum・real_inclusion_preserves_difference の参照にし、第 3 の等式の鎖の 4 行目（和・差の像を 1 行で当てていた）を和の行と差の行に割った（22 行から 23 行）。SageMath（det_A_theta_tilde の鎖と行番号）と Lean（lambda_mul_lambda_thetaTilde の calc を 1 段足し、行番号のコメントを送った。ClaimDetATilde・ClaimEigenATildeDiag の「準備の差の読み方」のコメントを主張の名前に）を合わせた。主張の型は不変。レビュー 1 回（必須なし）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage・verify-every-proof-has-check 通過。新しい件 (d4c48)（同じブロックに残る finite_sum の m = 2 の 3 行）を足した。次は (d4c32)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百七十六個目として、状態台帳の (cl3c3j8n2d3d4c30) を行った。人手 `recover_Z_Y_from_check_Z_Y` の準備 2 の複素数の鎖は、`-i` の積（`multiply_by_minus_one`・交換律・結合律の 3 行）と `(-1_ℝ)_ℂ = -1_ℂ`（`1_ℂ` に足すと `0_ℂ`、1 行）をその場で開いていた。これを `negative_i_times_complex_is_negation_of_i_times`（`z → (k_ℝx)_ℂ`）と `i_times_negated_real_is_negation_of_i_times`（`θ → k_ℝx`、右辺から左辺へ）の参照 2 行に替え、二項の和の像を `real_inclusion_preserves_finite_sum` の `m = 2` から `real_inclusion_preserves_sum` にした（8 等号から 5 等号）。実数の鎖は左辺を `j_ℝx + (-(k_ℝx))` にし、`(-1_ℝ)(k_ℝx)` を開く 2 行を ℝ の `-(ab) = (-a)b` の 1 行にした（5 等号から 4 等号）。両端と第 1・2 式は不変。SageMath は `check_exponent_chains.sage` を新しい行にし、参照先の 2 主張もこの鎖の値で確かめるようにした（4 本 PASS）。Lean は `recover_exponent_real_chain`（4 段）・`recover_exponent_complex_chain`（5 段。1・2 段目は具体版 `neg_I_mul_eq_neg_of_I_mul`・`I_mul_real_neg_eq_neg_I_mul`）を人手の行と 1 段ずつの calc にし、`lean/docs/ch013-formalization.md` を合わせた。主張の型は不変。必要十分版は置かない（既存の主張の当てはめだけ）。レビュー 1 回（必須なし。任意 3 件＝実数の鎖の根拠の文字が x と重なる、`real_inclusion_preserves_sum` の置き換えの明記、冒頭の方針に交換律と積の像の使用を残す、を直した）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage・verify-every-proof-has-check（未検算 0 件）通過。次は (d4c31)〜(d4c47)、(d4c7)（人手の全実数上の `cos`・`sin` の整備待ち）、(d4d)〜(d4g)、(cl3c3j8n2d3d5)〜(cl3c3j8n2d3d8)、(cl3c3j8n2d3e)〜(cl3c3j8n2d3z)、(cl3c3j8n3)〜(cl3c3j8n5)、(cl3c3j9)、(cl3c3k)〜(cl3c3p)、(cl4)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百七十五個目として、状態台帳の (cl3c3j8n2d3d4c29) を行った。人手 periodicity_of_check_fermi の γ_1 は ℝ の値なので、(1)(2)(3) の γ_1 の鎖を ℝ の gamma1R の上の calc（3 行・2 行・5 行）にし、gamma1R_thetaTilde_conj を ClaimCheckFermiResultsUnconditional から DefinitionCheckFermi へ移して ℂ へ出て exact_mod_cast で戻る段を消した。使う側の無い ℂ 版 gamma1_add_two_pi_mul_int・gamma1_thetaTilde_add_int_mul・gamma1_thetaTilde_conj は消した。人手・SageMath・主張の型は不変。レビュー 2 回（必須なし）。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (d4c30)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百七十四個目として、状態台帳の (cl3c3j8n2d3d4c28) を行った。人手 antiperiodic_exp_sum は (M_col)_R = ι_{Z→R}(M_col)、n_R := (n_Z)_R と写像に名前を付け済みなので本文は変えず、Lean の thetaTilde の分母を (M : R) から ((M : Z) : R) に替えた。thetaTilde_add_int_mul・thetaTilde_conj から人手に無い Int.cast_natCast が消えて 1 対 1 になった。波及先（ClaimAnticommutatorCheckZY の準備 2 の実数の鎖、TheoremMaxEigenvalueSimple の θ~ の定義の段、DefinitionCheckIndexSet・DefinitionHalfIntegerModes のタクティク証明）を合わせ、DefinitionCheckFermi の docstring の「原文」を「人手」に揃えた。人手・SageMath・主張の意味は不変。レビュー 1 回（必須なし）。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。新しい件 (d4c46)（thetaTilde_period_for_checkZY を 1 対 1 に）・(d4c47)（thetaTilde_sub ほかの分母の書き方）を足した。次は (d4c29)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百七十三個目として、状態台帳の (cl3c3j8n2d3d4c27) を行った。主張 one_plus_one_is_two_in_cc（1_C + 1_C = 2_C、4 行）を本文に足し、matrix_sum_with_itself_zero_implies_zero・V1_plus_square_root_property・trace_of_check_number_operator_product の準備 4・exp_of_negative_i_real_as_cos_minus_i_sin の重複した鎖をその参照に替えた。SageMath の検算を足し 4 ブロックの検算を合わせて PASS。Lean 具体版 complex_one_add_one を足し、重複補題 3 つを消し one_add_one_eq_complexTwo を読み替えにした（必要十分版は置かない）。主張の型は不変。レビュー 1 回（必須 1 件を直した）。全検査通過。新しい件 (d4c45)（対角化の章の 1+1 の 2 行 3 か所）を足した。次は (d4c28)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。

2026-11-10: Lean の通しの証明のゴールラインの確認の三百七十二個目として、状態台帳の (cl3c3j8n2d3d4c26) を行った。人手 exp_of_negative_i_real_as_cos_minus_i_sin の主鎖の 1・3・5 行目（分数の操作と分配法則を 1 行で当てていた）を 1 行 1 操作に割り（主鎖 22 行）、定義 def_complex_quotient（z/w := zw^{-1}）を本文に足し、i(2_C i)^{-1} = 2_C^{-1} を準備の第三の鎖（6 行）にした。Lean の主鎖を人手と 1 段ずつの calc にし（mul_div_cancel_left₀・sub_div・mul_div_mul_left を外した）、exp_neg_I_prep_I_mul_inv_two_mul_I を足した。SageMath を合わせて PASS。主張の型は不変。レビュー 2 回（必須 1 件を直した）。全検査通過。新しい件 (d4c42)〜(d4c44) を足した。次は (d4c27)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。

2026-11-10: Lean の通しの証明のゴールラインの確認の三百七十一個目として、状態台帳の (cl3c3j8n2d3d4c25) を行った。ClaimPositiveDefinite.lean の siteProd_conjTranspose の map_prod を、人手 check_number_operator_is_hermitian (1) のクロネッカー積の共役転置の 5 行の鎖と 1 対 1 の calc（siteProd_conjTranspose_apply）にし、反復適用を complex_conjugate_star_finite_prod（def_finite_product_of_complex_numbers どおり末尾の因子を外す）で受けた。補助 star_I_mul の star_mul'・ring を complex_conjugate_star_mul・conj_I_eq_neg_I の calc にした。人手・SageMath は不変、主張の型は不変。レビュー 2 回（必須 1 件を直した）。全検査通過。新しい件 (d4c41)（Pauli 行列と Z_j・Y_j の共役転置の段を人手 (1) と 1 対 1 に）を足した。次は (d4c26)。

2026-11-10: Lean の通しの証明のゴールラインの確認の三百七十個目として、状態台帳の (cl3c3j8n2d3d4c24e) を行った。人手 det_A_theta_tilde の第 1 の等式の鎖（(-1_C)(-1_C) の 2 行を minus_one_times_minus_one_is_one_in_cc の 1 行に）と第 3 の等式の鎖（差の定義を開いてから分配律、加法逆元・零元を 1 行ずつ、(2) の (-|γ_2|^2)_C に合わせて r の像を書き戻す 5 行を足して 22 行）を一ステップ一定理にし、ClaimDetATilde.lean の det_AMat_eq_gamma1_sq_add・lambda_mul_lambda_thetaTilde の ring を外して人手と 1 段ずつの calc にした。冒頭の方針を人手のいまの構成に書き直した。SageMath の CH_det・CH_lam を合わせて PASS。主張の型は不変。レビュー 3 回（必須 3・2・1 件を直した）。全検査通過。新しい件 (d4c39)（Lean の (2) の形を人手に揃える）・(d4c40)（分配律の外側・内側を 1 行に書く行）を足した。次は (d4c25)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百六十九個目として、状態台帳の (cl3c3j8n2d3d4c24d2) を行った。ClaimDetATilde.lean に det_A_theta_tilde の第 2 の等式の鎖の後半（人手の 30〜57 行）と 1 対 1 の calc の gamma1_sq_add_gamma2_mul_chain_second_half を足し、gamma1_sq_add_gamma2_mul_thetaTilde から ring・linear_combination を外した。人手は分配律の前に和の結合律の行を足し、畳む向きの行に「右辺から左辺へ」を書き、51 行目の根拠を real_inclusion_preserves_sum にした。gamma2_mul_gamma2_neg_sin_form を a₀・ha を受ける形にし、使われていない gamma2_mul_gamma2_neg_cos_form を消した。SageMath の CH_second を 58 項目にして PASS。次は (d4c24e)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百六十八個目として、状態台帳の (cl3c3j8n2d3d4c24d) を前半・後半に割り、前半 (d4c24d1) を行った。det_A_theta_tilde の第 2 の等式の鎖の前半（展開と c_2 の消去まで）の一ステップ一定理の違反を直して 29 行にし（和の結合律の行を 2 つ足し、冪と結合律を 1 行で当てていた行を 3 行に割った。2 を 2_C と書いた）、ClaimDetATilde.lean に人手と 1 対 1 の calc の gamma1_sq_add_gamma2_mul_chain_first_half を足して gamma1_sq_add_gamma2_mul_thetaTilde の Step 3・4 の ring を替えた。SageMath の CH_second を 57 項目にして PASS。主張の型は不変。レビュー 2 回（1 回目 必須 2 件を直した）。全検査通過。次は (cl3c3j8n2d3d4c24d2)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百六十七個目として、状態台帳の (cl3c3j8n2d3d4c24c) を行った。ClaimDetATilde.lean で det_A_theta_tilde の第二の準備の γ_2(θ)・γ_2(-θ)・積の 3 本の鎖を、人手の 3・9・10 行と 1 対 1 の calc（gamma2_a0_form・gamma2_neg_a0_form・gamma2_mul_gamma2_neg_sin_form）にし、ring・linear_combination を外した。人手は積の鎖の 1 行目（γ_2(±θ) の表示の同時代入）を 2 行に割り、冪の行に「右辺から左辺へ」を書いた（SageMath の CH_prod も合わせて PASS）。主張の型は不変。レビュー 2 回（1 回目 必須 2 件を直した）。全検査通過。次は (cl3c3j8n2d3d4c24d)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百六十六個目として、状態台帳の (cl3c3j8n2d3d4c24b) を行った。ClaimDetATilde.lean に det_A_theta_tilde の第一の準備の (x-y)^2 の鎖を人手の 15 行と 1 対 1 の calc（complex_sub_sq_chain）で置いた。人手は根拠の向きの書き漏れ 5 行に「右辺から左辺へ」を書き、2_C xy を 2_C(xy) と括弧付きにした（主張・13〜15 行・第 2 の等式の鎖の引用。SageMath の CH_sq も合わせて PASS）。主張の型は不変。レビュー 2 回（1 回目 必須 1 件: 2_C xy の読み。直した）。全検査通過。(d4c38) を足した。次は (cl3c3j8n2d3d4c24c)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百六十五個目として、状態台帳の (cl3c3j8n2d3d4c24)（det A(θ~) の Lean を人手と 1 対 1 に）を (d4c24a)〜(d4c24e) に割り、(d4c24a) を行った。ClaimDetATilde.lean に第一の準備の 6 本の鎖（-(-z)=z・ii=-1・e_+e_-=1・(x-iy)(x+iy)・u+iv=e_+・u^2+v^2=1）を人手の行と 1 対 1 の calc で置き、gamma2_mul_gamma2_neg_cos_form の Real.sin_sq を u^2+v^2 の鎖に替えた。人手は 9 行に「右辺から左辺へ」を書いた（中身不変）。主張の型は不変。レビュー 3 回（必須 3 件を直した）。全検査通過。(d4c37) を足した。次は (cl3c3j8n2d3d4c24b)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百六十四個目として、状態台帳の (cl3c3j8n2d3d4c22) を行った。half_integer_phase_antiperiodicity の「積の結合律と交換律」「cos,sin の周期性を同時適用」と、periodicity_of_check_fermi の準備の第二の「加法逆元と零の性質」・(2) の「加法の結合律と交換律」を、1 行 1 事実に割った（7・18・7・12 等号）。Lean の thetaTilde_add_int_mul・periodicity_prep_int_cast_neg を人手の行と 1 対 1 の calc に、SageMath を合わせて PASS。主張の型は不変。レビュー 2 回（1 回目 必須 1 件: 差の定義の省略。直した）。全検査通過。(d4c35)・(d4c36) を足した。次は (cl3c3j8n2d3d4c24)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百六十三個目として、状態台帳の (cl3c3j8n2d3d4c21) を行った。`DefinitionThetaGamma.lean` の冒頭の対応表の旧ファイル名（008_TV1_hatZ_hatY_part1/2.mjs）を、本文 eigenvalue_problem_reduction_to_A_theta.ts と参照用ノート integer_momentum_route_not_adopted.ts の正本のパスへ直した（041 のラベルも gamma2_theta_M_periodicity に訂正）。コード・人手・SageMath は不変。レビュー 1 回（必須なし）。全検査通過。(d4c34) を足した。次は (cl3c3j8n2d3d4c22)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百六十二個目として、状態台帳の (cl3c3j8n2d3d4c20) を行った。人手 def_A_theta の成分の読みに、(1,1)・(2,2) 成分の実数の積と差の括り方、(1,2)・(2,1) 成分の第四の因子の括り方と、その差（def_complex_difference）・和と積（definition_of_cc）・exp（def_scalar_exp の係数を ℂ としたもの）の出典を書いた。行列の式・Lean のコード・SageMath は不変（Lean は AMat の docstring だけ）。レビュー 1 回（必須なし）。全検査通過。(d4c32)・(d4c33) を足した。次は (cl3c3j8n2d3d4c21)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百六十一個目として、状態台帳の (cl3c3j8n2d3d4c19) を行った。本文に主張 real_inclusion_preserves_difference（y_ℂ - z_ℂ = (y - z)_ℂ）を足し、exponential_series_of_even_odd_power_terms の準備（実数の差の像）をその参照にした。factorization_of_A_theta_general の Step 2・3 の末尾に積の像 2 行と差の像 1 行を足し、def_A_theta の (1,1)・(2,2) 成分の実数の像まで運んだ。SageMath は real_inclusion_preserves_difference/ を新設、factorization に check_diagonal_entries_as_real_image.sage を足した（PASS）。Lean は real_inclusion_sub を MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealInclusionPreservesDifference.lean へ移し、factorization_A_diag_as_inclusion を人手の 3 行と 1 対 1 にして Step 2・3 の _real 版の右辺を実数の像にした。主張の型は不変。レビュー 3 回（1 回目 必須 3 件: 検算の数え違い・断り書きの消失・古い記述。2 回目 必須 1 件: 括り方の一文の範囲。直した。3 回目 必須なし）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage・verify-every-proof-has-check（未検算 0 件）通過。(d4c31)（det_A_theta_tilde の差の像の読みを新しい主張の参照に）を足した。次は (cl3c3j8n2d3d4c20)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百六十個目として、状態台帳の (cl3c3j8n2d3d4c18) を行った。人手 anticommutator_of_check_Z_Y の準備 2 の複素数の鎖の後半 11 行を negative_i_times_complex_is_negation_of_i_times・negation_of_i_times_negated_real_is_i_times の参照 2 行に替えた（14 等号→5 等号）。SageMath check_exponent_chains.sage を合わせて PASS。Lean anticomm_exponent_complex_chain を人手の 5 行と 1 対 1 の calc にした（具体版 neg_I_mul_eq_neg_of_I_mul・neg_I_mul_real_neg_eq_I_mul）。主張の型は不変。レビュー 2 回（1 回目 必須 1 件: overview の古い記述。直した）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage・verify-every-proof-has-check（未検算 0 件）通過。(d4c30)（recover_Z_Y の複素数の鎖も同じく短くできるか）を足した。次は (cl3c3j8n2d3d4c19)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百五十九個目として、状態台帳の (cl3c3j8n2d3d4c17) を確かめた（三百五十個目で済んでいた）。続けて同じ件の (d4c23) を行い、人手に対応の無い `gamma1_neg`（`@[simp]`、`Real.cos_neg` の simp）を消して check-no-sorry の targets から外した。人手・SageMath・主張の型は不変。レビュー 1 回（必須 1 件: 台帳の閉じる項目の書き方。直した）。(d4c29)（`gamma1R_thetaTilde_conj` の ℂ 経由と `exact_mod_cast`）を足した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (d4c18)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百五十八個目として、状態台帳の (cl3c3j8n2d3d4c16) を行った。thetaTilde_add_int_mul（人手 periodicity_of_check_fermi (2) の 8 行）と thetaTilde_conj（人手 conjugate_index_of_check_Z_Y (1) の 11 行）の push_cast; field_simp; ring を人手の行と 1 段ずつの calc に替えた。主張の型・人手・SageMath は不変。レビュー 1 回（必須なし）。(d4c28)（M_col の ℤ の像と ℕ の像の一致を人手に無いまま当てている件）を足した。次は (d4c17)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百五十七個目として、状態台帳の (cl3c3j8n2d3d4c15b2) を行った。exp_of_negative_i_real_as_cos_minus_i_sin の主鎖 2 行目「ℂ の四則」（2_ℂb = (a+b)-(a-b)）を、準備の二つの鎖（1_ℂ+1_ℂ = 2_ℂ の 4 行、(a+b)-(a-b) = 2_ℂb の 17 行）に割り、主鎖はその参照にした。SageMath の check_prep_chains.sage を足して PASS。Lean 具体版 exp_neg_I_prep_one_add_one・exp_neg_I_prep_add_sub_sub を足し、主鎖の ring を替えた。主張の型は不変。レビュー 2 回（必須 1 件: lean/README.md の対応表。直した）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage・verify-every-proof-has-check（未検算 0 件）通過。(d4c26)（主鎖の 1・3・5 行目の分数の操作）・(d4c27)（1_ℂ+1_ℂ = 2_ℂ の重複を主張にするか）を足した。次は (cl3c3j8n2d3d4c16)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百五十六個目として、状態台帳の (cl3c3j8n2d3d4c15b) を割り、前半の (cl3c3j8n2d3d4c15b1) を行った。主張 minus_one_times_minus_one_is_one_in_cc（(-1_ℂ)(-1_ℂ) = 1_ℂ、4 行の鎖）を本文に足し、matrix_double_negation の名前だけの根拠をその参照に替えた。SageMath の検算を足して PASS。Lean 具体版 complex_minus_one_mul_minus_one を足し、neg_neg_matrix_apply の norm_num と complex_neg_one_mul_neg_one をこれに替えた（必要十分版は置かない）。主張の型は不変。レビュー 1 回（必須なし）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage・verify-every-proof-has-check（未検算 0 件）通過。ほかの (-1_ℂ)(-1_ℂ) の箇所を参照に揃える件は台帳に足した。次は (cl3c3j8n2d3d4c15b2)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百五十五個目として、状態台帳の (cl3c3j8n2d3d4c15) を判断し、一ステップ一定理により人手の行を割ると決めた。complex_conjugate_of_product の 4 行目（ℝ の恒等式 1 行）を 3 行に割り（鎖は 8 行）、SageMath を合わせて PASS、Lean の ring を neg_add・mul_neg・neg_mul の 3 段にした。主張の型は不変。レビュー 1 回（必須なし）。exp_of_negative_i_real_as_cos_minus_i_sin の 2 行目は (cl3c3j8n2d3d4c15b) として残した（先に (-1_ℂ)(-1_ℂ) = 1_ℂ の主張を足す）。次は (cl3c3j8n2d3d4c15b)。
2026-11-10: Lean の通しの証明のゴールラインの確認の三百五十四個目として、状態台帳の (cl3c3j8n2d3d4c14) を行った。複素共役の和・積・差の具体版を star の形・添字 Fin n（n = 0 を含む）・Finset.range N・Conf M（finFunctionFinEquiv で Fin (2^M) へ付け替え）へ読み替える ClaimComplexConjugateOfSumProductDifferenceStarForm.lean を足し、TraceConjugateTransposeAndPositiveDefiniteness の 4 ファイルと必要十分版から導く 4 ファイルの mathlib の star_sum・star_add・star_mul'・star_sub をこれに替えた（残る mathlib は norm_star だけ）。主張の型は不変。レビュー 3 回（必須 2 件は直した）。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。ClaimPositiveDefinite.lean の star_I_mul・map_prod を (cl3c3j8n2d3d4c25) として台帳に足した。次は (cl3c3j8n2d3d4c15)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百五十三個目として、状態台帳の (cl3c3j8n2d3d4c13c) を行った。diagonalization の章で exp_of_negative_i_real_as_cos_minus_i_sin を引く残り 2 か所（relation_of_gamma_2_theta_tilde の \overline{exp(iθ)} の鎖、det_A_theta_tilde の e_-）はどちらも -(iθ) の読みで、negative_i_times_complex_is_negation_of_i_times の行は要らない。det_A_theta_tilde の準備に e_- の読みを書いた（中身は不変）。SageMath の第 4 行の検査の符号の形を直して PASS。Lean は exp_I_mul_exp_neg_I_mul の docstring だけ（主張の型は不変）。レビュー 1 回（必須なし）。全検査通過。Lean の det_A_theta_tilde の具体版が今の人手の鎖と 1 対 1 でないことを (cl3c3j8n2d3d4c24) として台帳に足した。次は (cl3c3j8n2d3d4c14)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百五十二個目として、状態台帳の (cl3c3j8n2d3d4c13b) の reduction_to_A_theta の部分を行った。def_half_integer_checkZ・checkY と half_integer_phase_antiperiodicity・half_integer_phase_periodicity の -i(·)_C を (-i)(·)_C の読み（anticommutator_of_check_psi・conjugate_index_of_check_Z_Y と同じ）と書き、2 つの主張に negative_i_times_complex_is_negation_of_i_times の行を足した（17 等号・6 等号）。SageMath を合わせて PASS。Lean は checkPhase_eq_exp_neg_I_mul を DefinitionHalfIntegerModes.lean へ移し、checkPhase_eq_cos_sub_I_sin（Complex.exp_mul_I で閉じていた）を消して checkPhase_period_for_checkZY を人手の 6 行と対応する calc にした。主張の型は不変。レビュー 2 回（指摘は直した）。全検査通過。次は (cl3c3j8n2d3d4c13c)（diagonalization の残り 2 か所）。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百五十一個目として、状態台帳の (cl3c3j8n2d3d4c13) の `conjugate_index_of_check_Z_Y` (2) の部分を行った。人手の (2) の鎖に negative_i_times_complex_is_negation_of_i_times で (-i)(2πj_R)_C を -(i(2πj_R)_C) へ書き換える 1 行を足し（16 等号）、準備の文の読みの誤りを直し、(2) の -i の読みを主張に書いた。SageMath を合わせて PASS。Lean は checkPhase_conj' の Complex.exp_mul_I と ring の段を具体版 neg_I_mul_eq_neg_of_I_mul・exp_neg_I_mul_real_eq_cos_sub_I_mul_sin の 2 段にした。主張の型は不変。レビュー 1 回（必須なし）。残りを (d4c13b) に割った。次は (cl3c3j8n2d3d4c13b)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。`pgrep -f 'cache get'` は連続実行の claude 自身の引数に一致するので待機に使わない。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百五十個目として、状態台帳の (cl3c3j8n2d3d4c12) を行った。人手 periodicity_of_check_fermi の準備の i(-x)・-i(-x)・cos(-x) の 3 本の鎖を消し、cos(-x) = cos x を cos_of_negated_real と inclusion_rr_to_cc_is_injective から ℝ の等式として作る準備の第三にした。half_integer_phase_antiperiodicity の「cos は偶関数」「sin は奇関数」を cos_of_negated_real・sin_of_negated_real の参照にした（16 等号）。SageMath を合わせて PASS。Lean は gamma1_thetaTilde_conj を人手の 5 行と 1 対 1 の calc にし、periodicity_prep_cos_neg を足した。主張の型は不変。レビュー 1 回（必須なし）。(d4c22)・(d4c23) を足した。次は (cl3c3j8n2d3d4c13)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百四十九個目として、状態台帳の (cl3c3j8n2d3d4c11) を行った。人手 def_A_theta を θ ∈ ℝ に直し、成分の読み（(1,1)・(2,2) は実数の像、(1,2)・(2,1) は像の ℂ の式、-iθ と先頭の -i は multiply_by_minus_one、積は左から括る）を定義に書いた。def_gamma1_gamma2_of_theta・det_A_theta_tilde の読みを定義への参照にし、det の γ_2(-θ) の鎖に 3 行、factorization_of_A_theta_general の Step 5 の末尾に 2 行を足した（SageMath も合わせて PASS）。Lean は factorization の hexp を具体版 neg_I_mul_eq_neg_of_I_mul にし、AMat のコメントを直した。主張の型は不変。レビュー 2 回（2 回目必須なし）。(d4c19)〜(d4c21) を足した。次は (cl3c3j8n2d3d4c12)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百四十八個目として、状態台帳の (cl3c3j8n2d3d4c10) を行った。人手 i_times_negated_real_is_negation_of_i_times を euler_formula_cos_sin の前へ移し、euler の証明の準備の -(iθ_ℂ) = i(-θ)_ℂ の 6 行の鎖をその主張への 1 行の参照に替えた。SageMath の 112_euler_formula_cos_sin/ の 6 行の検算を残った 1 行の check_exp_negated_argument_line.sage に替えた（PASS）。Lean は ClaimEulerFormulaCosSin.lean の冒頭の記述（補題の置き場の誤り）だけを直した。主張の型は不変。レビュー 1 回（必須なし）。(d4c18) を足した。次は (cl3c3j8n2d3d4c11)。注意: sage は ~/micromamba/envs/sage/bin。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百四十七個目として、状態台帳の (cl3c3j8n2d3d4c9) を行った。sagemath/check/112_euler_formula_cos_sin/check_01_euler.sage が SageMath 10.9 で落ちていた（CLI が __file__ を Sage のパッケージの位置にし、準備の読み込みが site-packages を探す）のを、相対パスの load("../../_shared/operators.sage")・load("_prelude.sage") に替えて直し、古い生成物 check_01_euler.sage.py を git から外した。判定 150・最大相対誤差 0 で PASS（overview.md と一致）。run-all-checks.sh の cd の理由のコメントを直した。同じ __file__ の書き方は古い検算の 185 ファイルに残るが、SageMath の連続実行の台帳の件なので扱っていない。レビュー 1 回（必須なし）。次は (cl3c3j8n2d3d4c10)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百四十六個目として、状態台帳の (cl3c3j8n2d3d4c7) を待ちにし（人手の cos・sin がまだ [-π/2, π/2] 上だけで、着手条件「人手で全実数上の cos・sin が整備されたら」を満たさない）、(cl3c3j8n2d3d4c8) を行った。DefinitionCheckFermi.lean に periodicity_of_check_fermi の準備の第二 (-k)_ℝ = -k_ℝ（6 行）、(2) の -θ̃_{μ+kM} の鎖（4 行）、(3) の θ̃_ν・-θ̃_ν の鎖（5 行ずつ）を人手と 1 対 1 の calc で置き、γ_1・γ_2 の (2)(3) の push_cast; ring を消した。主張の型・人手・SageMath は不変。レビュー 1 回（必須なし）。残りに (d4c16) thetaTilde_add_int_mul・thetaTilde_conj の ring、(d4c17) gamma1_thetaTilde_conj の cos(-x) の段を足した。次は (cl3c3j8n2d3d4c9)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百四十五個目として、状態台帳の (cl3c3j8n2d3d4c6) を行った。人手 complex_conjugate_of_sum・_of_product・_of_difference の具体版を MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimComplexConjugateOfSumProductDifference.lean に人手の行と 1 対 1 の calc で置き（和は必要十分版 map_finSumLeft_of_map_add' の系も ClaimComplexConjugateOfSumFromNecSuf.lean に）、exp_of_negative_i_real_as_cos_minus_i_sin の具体版 exp_neg_I_mul_real_eq_cos_sub_I_mul_sin を ClaimExpOfNegativeIRealAsCosMinusISin.lean へ移して人手の 6 行の calc にした。DefinitionThetaGamma.lean の map_add・map_mul・map_sub を具体版に替えた。人手・SageMath・通しの定理の型は不変。レビュー 2 回（1 回目の必須 3 件を直し、ClaimConjugateIndex の読み替えの抜けは (d4c13) に残した。2 回目は必須なし）。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (cl3c3j8n2d3d4c7)。注意: lake は ~/.elan/bin。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百四十四個目として、状態台帳の (cl3c3j8n2d3d4c5) を行った。def_gamma1_gamma2_of_theta の (2,1) 成分の鎖が後ろの relation_of_gamma_2_theta_tilde の準備の i(-θ) = -iθ・cos(-θ)・sin(-θ) を参照なしに使っていた件を、その 4 本の鎖を主張 i_times_negated_real_is_negation_of_i_times・negation_of_i_times_negated_real_is_i_times・cos_of_negated_real・sin_of_negated_real として 000_calculation_formulae_30_44.ts へ移して解消した。def の γ_2(-θ) の鎖を 6 行、A(θ)_{2,1} の鎖を 5 行にした。Lean は 4 補題を MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimCosSinAndITimesAtNegatedReal.lean へ移し、AMat_eq を simp から成分ごとの rfl と AMat_two_one_eq_neg_gamma2_neg（5 行と 1 対 1）にした。SageMath に 4 ディレクトリを足した。主張の型は不変。次は (cl3c3j8n2d3d4c6)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百四十三個目として、状態台帳の (cl3c3j8n2d3d4c4) を行った。人手 euler_formula_cos_sin の主張に読み（-iθ は -(iθ)、分母の 2 は 2_ℂ、実数は包含の像）を書き、証明の準備に -(iθ_ℂ) = i(-θ)_ℂ の 6 行の鎖を足した。(-i)θ と読んでいた factorization_of_A_theta_general のために主張 negative_i_times_complex_is_negation_of_i_times（(-i)z = -(iz)）を足し、準備の 5〜7 本目に定義の展開と書き換えの行を足した。Lean は euler の読みを MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimEulerFormulaCosSin.lean に 1 通りにまとめ（euler_cos_as_exp・euler_sin_as_exp を消した）、neg_I_mul_eq_neg_of_I_mul を置いた。SageMath も合わせた。レビュー 2 回目で必須なし。残り (d4c9)＝112_euler の check_01 が load のパスで落ちる（変更前から）。次は (cl3c3j8n2d3d4c5)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百四十二個目として、状態台帳の (cl3c3j8n2d3d4c3) を行った。γ_2 の 2π 周期性を gamma2_add_two_pi_mul_int（角度は人手どおり θ + 2π k_ℝ）として人手 periodicity_of_check_fermi (1) の γ_2 側 6 行と 1 対 1 の calc にし、γ_1 側 gamma1_add_two_pi_mul_int（3 行）と thetaTilde_add_int_mul・thetaMu_add_int_mul の角度の形も揃えた。全実数上の cos・sin の 2π 周期性（人手の前提）は mathlib で受けた（残り (d4c7)）。(2)(3) の h の push_cast; ring は残り (d4c8)。人手・SageMath は不変。レビュー 2 回目で指摘なし。次は (cl3c3j8n2d3d4c4)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百四十一個目として、状態台帳の (cl3c3j8n2d3d4c2) を行った。DefinitionThetaGamma.lean の gamma2_neg_eq_neg_conj（push_cast・ring_nf で閉じていた）を、人手 relation_of_gamma_2_theta_tilde の「第一に」の exp(iθ) の表示（17 行）・「第二に」の ī = -i（6 行）と conj(exp(iθ)) = exp(-iθ)（8 行）・「第四に」（18 行）・(1)（2 行）と 1 対 1 の calc にした。複素共役の和・積・差と multiply_by_minus_one は具体版が無く mathlib の map_*・neg_one_mul で受けた（残り (d4c6) に記録）。主張の型・人手・SageMath は不変。レビュー 2 回で指摘なし。次は (cl3c3j8n2d3d4c3)。

2026-11-09: Lean の通しの証明のゴールラインの確認の三百四十個目として、状態台帳の (cl3c3j8n2d3d4c) を (d4c1)〜(d4c3) に割り、(d4c1) を行った。DefinitionThetaGamma.lean の gamma2_neg を人手 relation_of_gamma_2_theta_tilde の「第三に」の 6 行と 1 対 1 の calc にし、準備の i(-θ) = -iθ（包含の積は real_inclusion_mul）・-i(-θ) = iθ・cos(-θ)・sin(-θ) の鎖を補題で置いた。主張の型・人手・SageMath は不変。次は (cl3c3j8n2d3d4c2)（gamma2_neg_eq_neg_conj）。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百三十九個目として、状態台帳の (cl3c3j8n2d3d4b) を行った。DefinitionVPlus.lean に人手 V2_invertible の二本の鎖 V2_mul_V2Inv・V2Inv_mul_V2（包含の積は real_inclusion_mul）を置き、V2Units を逆元 (a^{-1})_ℂ exp(-Y) で作り直した（V2Units_inv_val）。ClaimTActionsOnCheck.lean の TConj_V2_checkZ・TConj_V2_checkY を人手 T_actions_on_check_Z_Y の T_{V_2} の鎖と 1 対 1 の calc にし、係数を人手どおり (cosh 2K_2^*)_ℂ の像にした（B2mat の読み替えは actsBy_TConj_V2_check へ）。主張の型（通しの定理）・人手・SageMath は不変。範囲外の残り (cl3c3j8n2d3w)〜(z)（B2mat の定義、V_1 側の 2 式、V2H2Form 版の要否、a > 0 の作り方）を台帳に足した。次は (cl3c3j8n2d3d4c)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百三十八個目として、状態台帳の (cl3c3j8n2d3d4) をファイルの単位に (d4a)〜(d4g) に割り、(d4a) を行った。ClaimAntiperiodicExpSum.lean の antiperiodic_exp_sum_dvd（偶数 10 段・奇数 8 段）と antiperiodic_exp_sum_not_dvd（7 段）を人手 antiperiodic_exp_sum の鎖と 1 段ずつの calc にし、包含の積を具体版 real_inclusion_mul、2_ℂ - 1_ℂ = 1_ℂ を新しい two_real_inclusion_sub_one にした。主張の型・人手・SageMath は不変。範囲外の残り (cl3c3j8n2d3u)（hpow が mathlib の neg_one_zpow）・(v)（整除の補題の push_cast・ring）を台帳に足した。次は (cl3c3j8n2d3d4b)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百三十七個目として、状態台帳の (cl3c3j8n2d3d3) を行った。ClaimTwoByTwoTransferIdentity.lean の two_by_two_transfer_identity を人手の「結論」の 3 行と 1 対 1 の calc にし、「τ = K_2^* として」の鎖を新しい sqrt_two_s2_smul_exp_Kstar_pauliX（real_inclusion_mul で包含の積をまとめる）にした。← Complex.ofReal_mul の 2 か所は無くなった。twoByTwo_apply_eq_real_inclusion をこのファイルへ移し、使われない twoByTwo_eq を消した。冒頭とドキュメント文字列を今の人手の中間目標の名前に合わせた。主張の型・人手・SageMath は不変。範囲外の残り (cl3c3j8n2d3t)（exp(τσ^x) の成分の形と実数の段が 2026-11-02 の人手の書き直しと 1 対 1 でない）を台帳に足した。次は (cl3c3j8n2d3d4)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百三十六個目として、状態台帳の (cl3c3j8n2d3d2) を行った。ClaimFirstTransferMatrixPauliForm.lean を人手 first_transfer_matrix_pauli_form の中間目標どおり（D は対角行列・D の対角成分・K_1D の成分・成分の一致）の補題に組み直し、push_cast・Complex.ofReal_mul を具体版 real_inclusion_mul・real_inclusion_of_finite_sum_fintype_or_empty に替えた（d(μ) と D の 2 本の鎖は ClaimPhysicalWHasPositiveEntries.lean から移した。人手に無い sum_sigmaZ_sigmaZ_mulVec_basisVec_spin・sum_sigmaZ_sigmaZ_eq_diagonal・V1PauliForm_eq_diagonal は消した）。ClaimSecondTransferMatrixPauliForm.lean の Complex.ofReal_prod・Complex.ofReal_pow・push_cast を具体版に替え、人手 second_transfer_matrix_pauli_form の 2 本の鎖に包含の行を一ステップ一定理で足した（7 行・6 行。A の成分は two_by_two_transfer_identity の略記どおり包含で読む補題 twoByTwo_apply_eq_real_inclusion を置いた）。SageMath 2 本を直して PASS。範囲外の残り (cl3c3j8n2d3q)〜(s) を台帳に足した。次は (cl3c3j8n2d3d3)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百三十五個目として、状態台帳の (cl3c3j8n2d3d)（人手が実数の包含の像を引く行の Lean の対応の残りの洗い出し）を章のフォルダごとに (cl3c3j8n2d3d1)〜(d8) に割り、(d1) を行った。ClaimPartitionFunctionViaTransferMatrix.lean の Complex.ofReal_mul・Complex.ofReal_prod を具体版 real_inclusion_mul・real_inclusion_preserves_finite_product に替え、人手 partition_function_via_transfer_matrix の積の包含の根拠を Lean の段の置き場（転送行列の積の成分の 5 行目、指数の積を指数の和への 2 行目）へ揃えた。主張の型・SageMath は不変。次は (cl3c3j8n2d3d2)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百三十四個目として、状態台帳の (cl3c3j8n2d3c3d) を行った。ClaimFactorizationATheta.lean の主張 factorization_of_A_theta_general を、人手の Step 6 どおり（mat_mult_associative、記号の橋、Step 2〜5 の _real 版、成分を A(θ) の成分として読む段、def_A_theta）の 5 段の calc で組み立て直し、一括計算 B1_mul_B2_mul_B1_eq_AMat から切り離した。主張は K_1, K_2^*, θ ∈ ℝ と成分の実数の等式・双対関係 hdual を仮定に取る形に述べ直し、Kstar K_2 の形 factorization_of_A_theta_general_of_coupling と利用箇所の ℂ の仮定からの橋 factorization_of_A_theta_general_of_complex_hyps を置いた。主張の型・人手・SageMath は不変。レビュー 2 回。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。範囲外の残り (cl3c3j8n2d3o)（Step 2〜5 の末尾の A(θ) の成分としての読みの行が無い）を台帳に足した。次は (cl3c3j8n2d3d)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百三十三個目として、状態台帳の (cl3c3j8n2d3c3c) を行った。ClaimFactorizationATheta.lean に人手 factorization_of_A_theta_general の Step 4・5（P := B_1(θ)N の非対角成分 P_12・P_21、9 行ずつ）を factorization_step4_P12・factorization_step5_P21（記号を ℂ の元とし準備の補助的な等式・2ab = (s_1)_ℂ・C = S(c_2)_ℂ を仮定に取る）と factorization_step4_P12_real・factorization_step5_P21_real（準備で埋めた実数版）として人手の行と 1 段ずつの calc で足した。主張の型・人手・SageMath は不変。レビュー 2 回。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。範囲外の残り (cl3c3j8n2d3n)（Step 4・5 の 4 行目の 1+1=2 の根拠の不足）を台帳に足した。次は (cl3c3j8n2d3c3d)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百三十二個目として、状態台帳の (cl3c3j8n2d3c3b) を行った。ClaimFactorizationATheta.lean に人手 factorization_of_A_theta_general の Step 2・3（P := B_1(θ)N の対角成分 P_11・P_22、12 行ずつ）を factorization_step2_P11・factorization_step3_P22（記号を ℂ の元とし準備の 4 本を仮定に取る）と factorization_step2_P11_real・factorization_step3_P22_real（準備の 4 本で埋めた実数版）として人手の行と 1 段ずつの calc で足した。主張の型・人手・SageMath は不変。レビュー 2 回。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。範囲外の残り (cl3c3j8n2d3m)（Step 2・3 の (2)_ℂ = 2 と (-1)x = -x の根拠の不足）を台帳に足した。次は (cl3c3j8n2d3c3c)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百三十一個目として、状態台帳の (cl3c3j8n2d3c3) を (c3a)〜(c3d) に割り、(cl3c3j8n2d3c3a) を行った。ClaimFactorizationATheta.lean に人手 factorization_of_A_theta_general の証明冒頭の「この記号で B_1(θ)・B_2 は…」の橋 factorization_B1mat_eq_symbols・factorization_B2mat_eq_symbols（人手の記号の行列 factorizationB1Symbols・factorizationB2Symbols）と、Step 1 の N := B_2B_1(θ) の 4 成分 factorization_step1_N11・N12・N21・N22 を人手の行と 1 段ずつの calc で足した。主張の型・人手・SageMath は不変。レビュー 2 回。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。範囲外の残り (cl3c3j8n2d3l)（Step 1 の ii = -1 の行の根拠の不足）を台帳に足した。次は (cl3c3j8n2d3c3b)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百三十個目として、状態台帳の (cl3c3j8n2d3c2) を行った。ClaimFactorizationATheta.lean に人手 factorization_of_A_theta_general の準備の残り 4 本（e_+e_- = 1・e_+ + e_- = (2)_ℂ(cos θ)_ℂ・e_± = cos ± i sin）、補助的な等式 2 本、C = S(c_2)_ℂ を人手の行と 1 段ずつの calc で足した（Euler の表示は具体版が無いので euler_cos_as_exp・euler_sin_as_exp を mathlib で置いて受けた）。主張の型・人手・SageMath は不変。レビュー 2 回（必須なし）。範囲外の残り (cl3c3j8n2d3j)（euler_formula_cos_sin の具体版）・(cl3c3j8n2d3k)（補助的な等式の 5 行目の根拠）を台帳に足した。次は (cl3c3j8n2d3c3)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百二十九個目として、状態台帳の (cl3c3j8n2d3c) を (c1)〜(c3) に割り、(cl3c3j8n2d3c1) を行った。ClaimFactorizationATheta.lean に人手 factorization_of_A_theta_general の準備の実数の像の 3 本（a^2+b^2・2ab・a^2-b^2）を factorization_prep_sq_add_sq・factorization_prep_two_mul_mul・factorization_prep_sq_sub_sq として人手の行と 1 段ずつの calc で足した（real_inclusion_mul・real_inclusion_add・cosh_add_formula・sinh_eq_two_sinh_half_mul_cosh_half）。主張の型・人手・SageMath は不変。レビュー 2 回。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。範囲外の残り (cl3c3j8n2d3i) を台帳に足した。次は (cl3c3j8n2d3c2)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百二十八個目として、状態台帳の (cl3c3j8n2d3b3) を行った。ClaimRecoverZYFromCheckZY.lean の inverse_dft_check を人手 recover_Z_Y_from_check_Z_Y の第 1 式の鎖と 1 段ずつ対応する calc にし（expPhase_add と ring で畳む Step 0 を外した）、準備 2 の実数の鎖（5 行）・複素数の鎖（8 行）を recover_exponent_real_chain・recover_exponent_complex_chain、準備 1 を recover_off_diagonal_term、読みを checkPhase_neg_eq_exp_I_mul・exp_I_mul_int_mul_real として足した。必要十分版 NecSuf.inverse_dft_antiperiodic を同じ段の順にし、直交性を具体版の「とくに」に当たる sum_zpow_antiperiodic_not_dvd・sum_zpow_antiperiodic_dvd_even にした。主張の型・人手・SageMath は不変。レビュー 2 回。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。範囲外の残り (cl3c3j8n2d3h) を台帳に足した。次は (cl3c3j8n2d3c)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百二十七個目として、状態台帳の (cl3c3j8n2d3b2) を行った。ClaimAnticommutatorCheckZY.lean に人手 anticommutator_of_check_Z_Y の準備 2 の実数の鎖（20 行）・複素数の鎖（14 行）を anticomm_exponent_real_chain・anticomm_exponent_complex_chain として足し、第 1・3 式の scalar_exp_product → 準備 2 → exp_sum → def_delta_M の段を人手の行と 1 対 1 にした（expPhase_add・expPhase_two_mul で畳む段を外した。読みの補題 checkPhase_eq_exp_neg_I_mul・exp_sum_as_I_mul_real、deltaMod_sub_one を deltaMod_neg_sub_one に替えた）。主張の型・人手・SageMath は不変。レビュー 2 回（必須 1 件を直した）。範囲外の残り (cl3c3j8n2d3f)（exp_sum の符号）・(cl3c3j8n2d3g)（同じファイルの残りの段）を台帳に足した。次は (cl3c3j8n2d3b3)（ClaimRecoverZYFromCheckZY.lean）。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百二十六個目として、状態台帳の (cl3c3j8n2d3b) をファイルごとに (b1)〜(b3) に割り、(cl3c3j8n2d3b1) を行った。ClaimConjugateIndex.lean の checkPhase_conj' を人手 conjugate_index_of_check_Z_Y (2) の鎖 15 行と 1 対 1 の calc にし、準備の 2 つの鎖を conj_index_exponent_real_chain・neg_I_mul_real_inclusion_neg として足した。和・積の像は push_cast から具体版 real_inclusion_add・real_inclusion_mul に替えた。主張の型・人手・SageMath は不変。レビュー 2 回。次は (cl3c3j8n2d3b2)（ClaimAnticommutatorCheckZY.lean の準備 2）。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百二十五個目として、状態台帳の (cl3c3j8n2d3) を (a)〜(d) に割り、(cl3c3j8n2d3a) を行った。ClaimDetATilde.lean・ClaimEigenATildeDiag.lean で、人手 det_A_theta_tilde・eigenvector_of_A_theta_tilde が実数の積・和・差の像を引く行の Lean を、mathlib の Complex.ofReal_mul・ofReal_add・ofReal_sub・ofReal_pow から具体版 real_inclusion_mul・real_inclusion_add・real_inclusion_sub に替えた（補題 real_inclusion_sq_via_product・c1_sq_sub_s1_sq_inclusion・c2star_sq_sub_s2star_sq_inclusion・c2_mul_s2star_inclusion・gamma1_eq_inclusion_form を足した）。主張の型・人手・SageMath は不変。レビュー 3 回。範囲外の残りとして (cl3c3j8n2d3e)（u^2 + v^2 = 1 を人手どおり ℂ の中で示す）を台帳に足した。次は (cl3c3j8n2d3b)。

2026-11-09: Lean の通しの証明のゴールラインの確認の三百二十四個目として、状態台帳の (cl3c3j8n2e) を行った。必要十分版 NecSuf.map_pow_of_map_one_of_map_mul' の型の仮定を [Monoid] から [One]・[Mul] だけに弱め、冪を npowRec（人手の冪の 2 つの式と同じ）で書いた。導出に、2 つの式を満たす ^ と npowRec の一致 npowRec_eq_pow_of_power_equations を足した。具体版・人手・SageMath は不変。レビュー 2 回（必須なし、任意 3 件を直した）。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (cl3c3j8n2d3)

2026-11-09: Lean の通しの証明のゴールラインの確認の三百二十三個目として、状態台帳の (cl3c3j8n2d) を行った。人手 real_inclusion_preserves_finite_sum の Lean 具体版 real_inclusion_of_finite_sum_succ（m = 1 の 2 行・帰納法の段の 7 行と 1 対 1）と、有限型・空かもしれない有限型・有限集合の上の和の形、必要十分版 NecSuf.map_finSumLeft_of_map_add'（仮定は f(a+b) = f(a)+f(b) だけ）と導出を足し、mathlib の Complex.ofReal_sum で受けていた 14 ファイルを具体版に替えた。ClaimDetATilde.lean の m = 2 の行も real_inclusion_add・real_inclusion_mul に替えた。人手・SageMath は不変。レビュー 2 回。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。残り: TheoremCPlusEqualsLambda.lean の 5 か所は (cl9) で、ほかの Complex.ofReal_add・ofReal_mul の受け方は (cl3c3j8n2d3) で扱う。次は (cl3c3j8n2e)

2026-11-09: Lean の通しの証明のゴールラインの確認の三百二十二個目として、状態台帳の (cl3c3j8n2c) を行った。exponential_series_of_even_odd_power_terms の準備（冪の像）の帰納法を外し、中間目標「各項」の 2 か所で real_inclusion_preserves_power を右辺から左辺へ引くようにした。主張の冪を def_power_of_real_number・def_power_of_complex_number の参照にした。値と主張は不変。Lean は real_inclusion_pow を消して real_inclusion_of_power の逆向きで受けた。SageMath を合わせた（PASS）。レビュー 1 回（必須なし、任意 3 件を直した）。次は (cl3c3j8n2d)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百二十一個目として、状態台帳の (cl3c3j8n2b) を行った。trace_of_check_number_operator_product の基底段階の「1_C を 2^{M_col} 個足した和。ℂ の四則」を 9 行の鎖にし、新しい主張 real_inclusion_preserves_power（(r^m)_C = (r_C)^m）を 020_critical_point.ts に足した。Lean は具体版 real_inclusion_of_power・必要十分版 NecSuf.map_pow_of_map_one_of_map_mul'・trace_basic_properties (3) の 1 対 1 の trace_identity_eq_sum_one を足し、trace_identity_base_case を人手の 9 行と同じ順の calc にした。SageMath を足して合わせた（PASS）。レビュー 1 回（必須なし、任意 3 件を直した）。次は (cl3c3j8n2c)（exponential_series_of_even_odd_power_terms の準備「冪の像」を新しい主張の参照に替える）。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。Lean の名前 real_inclusion_pow は既に ClaimExponentialSeriesOfEvenOddPowerTerms.lean にある。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百二十個目として、状態台帳の (cl3c3j8n2) を割り、前半の (cl3c3j8n2a) を行った。trace_of_check_number_operator_product の帰納段階の「ℂ の四則」4 か所を、準備 4（2_C = 1_C + 1_C、2_C^{-1}2_C = 1_C、2_C w = w + w、w = 2_C^{-1}(2_C w)、w = 2_C^{-1}w + 2_C^{-1}w）と体の公理 1 つずつの鎖（9 行・8 行・9 行）にした。½ を 2_C^{-1} にし、冪の底が 2_C であることを主張に書いた。値と主張は不変。Lean 具体版・必要十分版を同じ行の calc にした（ring・linear_combination を外した）。SageMath _chains.sage を合わせた（PASS）。レビュー 1 回（任意 5 件を直した）。次は (cl3c3j8n2b)（基底段階の Σ 1_C = 2^{M_col}。実数の冪の包含の主張を足す）。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百十九個目として、状態台帳の (cl3c3j8n) を割り、先頭の periodicity_of_check_fermi の準備の第一を行った。名前だけの根拠「ℂ の四則」3 か所と 1 行に 3 等号の (−x)_C = −x_C の行を、relation_of_gamma_2_theta_tilde と同じく i(−x) = −ix（6 行）・−i(−x) = ix（2 行）と cos x + i sin x の 17 行の鎖に割った。値と主張・Lean は不変。SageMath check_generic_chains を合わせた（PASS）。レビュー 2 回（必須 1・任意 2 を直した）。残りを (cl3c3j8n2)〜(cl3c3j8n5) に割った。次は (cl3c3j8n2)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。

2026-11-09: Lean の通しの証明のゴールラインの確認の三百十八個目として、状態台帳の (cl3c3j8m) を行った。「‖x‖ = 1 なら x ≠ 0」を主張 unit_norm_vector_is_nonzero として def_rayleigh_sup の直前に切り出し（6 行の鎖をそのまま移した）、def_rayleigh_sup・moment_log_convexity・c_between_Lambda_half_and_twice_Lambda_half の Step 2 の準備から引く形にした。Lean は ne_zero_of_unit_norm を ClaimUnitNormVectorIsNonzero.lean へ移し、c_le_twice_c_plus_physical の u ≠ 0 の別証明をそれに替えた。abs_basic_properties (6) の「平方根の一意性」を definition_of_sqrt_r_positive と sqrt_nonnegative_existence_uniqueness の参照にした。値と主張は不変。SageMath unit_norm_vector_is_nonzero・103 の check_part6 を足した（PASS）。レビュー 2 回（必須 3・任意 5 を直した）。次は (cl3c3j8n)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。103 の check_01_abs.sage は run-all-checks.sh でパスが解けず落ちる（既存の問題）。

2026-11-09: Lean の通しの証明のゴールラインの確認の三百十七個目として、状態台帳の (cl3c3j8l2) を行った。relation_of_gamma_2_theta_tilde の名前だけの根拠「ℂ の四則」11 か所と 1 行に 2 事実以上の行を、ℂ・ℝ の体の等式 1 つずつの行に割った（準備の第一の前に i(−θ) = −iθ の 6 行・−i(−θ) = iθ の 2 行の鎖、cos θ + i sin θ の鎖は 17 行、conj(γ_2(θ)) の鎖は 18 行、(5) の (0,1)(|γ|,0) までを可換律と成分の等式 1 つずつ、(1) と背理の鎖の −(−z) = z、2_C・i・2i ≠ 0 の前置き、ℝ の順序の 2 行に「ℝ は順序体」）。値と主張・Lean は不変。SageMath を割った行に合わせた（PASS）。レビュー 2 回（必須 6・任意 5 を直した）。次は (cl3c3j8m)。

2026-11-09: Lean の通しの証明のゴールラインの確認の三百十六個目として、状態台帳の (cl3c3j8l) を行った。relation_of_gamma_2_theta_tilde の (3)(4) の外で 1 行に 2 事実以上か名前だけの根拠だった 5 行（(2) の (−1)a = −a、0 = 0·|γ|、−0 = 0、(5) の π/2 − 0·π = π/2 と「ℝ の四則を 2 箇所へ」）を一ステップ一定理に割り、(4)(5) の段落を angle_section_existence_uniqueness を引く書き方にした。値と主張・Lean は不変。SageMath を割った行に合わせた（PASS）。次は (cl3c3j8l2)（(5) の definition_of_cc の積の行と「ℂ の四則」の扱い）。
2026-11-09: 全証明の SageMath 検算のゴールラインを再び満たした。残っていた 3 件（000_calculation_formulae_00_09.ts の index_skipping_map_never_takes_skipped_index・index_skipping_map_reaches_every_other_index・bijection_composed_with_index_skipping_map_stays_in_lower_indices）は 2026-11-06 の検算の中で確かめていたが、overview.md の「対象ラベル」は 1 つしか読まれないので未検算に数えられていた。ラベルごとの sagemath/check/<ラベル>/ へ移し、証明の各行を ZZ の全数検査で確かめた（PASS）。レビュー 2 回。本文は注記の検算の置き場だけを直した（主張・証明は不変）。verify-every-proof-has-check は 0 件、verify-check-linkage は 514 件で通過、npm run check 通過。build:pdf は origin/main のままでも「PDF に組めない文字がある: ⊤ 。 ε ℝ ≤ ≥」で落ちる（この回の変更に依らない。2026-11-09 に確かめた）。ゴール台帳を達成に戻し、連続実行を一時停止した。
2026-11-09: 止めていた連続実行「複素行列版イジング: 全証明の SageMath 検算」を再開した。証明を持つ 500 件のうち 3 件（000_calculation_formulae_00_09.ts の δ^m_k の主張 index_skipping_map_never_takes_skipped_index・index_skipping_map_reaches_every_other_index・bijection_composed_with_index_skipping_map_stays_in_lower_indices。Lean の連続実行が 2026-11-06 に足した）に検算が無く、ゴール台帳の確認コマンドが落ちていた。ゴール台帳を未達に戻し、検算の状態台帳の「現在地」と「次の一歩」を 3 件に合わせ、Lean の runbook の毎回の手順に「人手へ足した証明に検算を足し、未検算の件数を増やさない」を足した。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百十五個目として、状態台帳の (cl3c3j8k3) を行った。three_halves_power_integral_bound・second_derivative_log_divergence・def_check_index_set・sine_half_angle_linear_bounds・pi_squared_numerical_bounds の、π の正から出す派生形（aπ/2>0・aπ≠0・π/δ²>0・1/(2π)>0・1/(4π)>0・2π>1・2π/M_col>0・π/M_col>0・π/2>0）に、pi_is_positive と正の数どうしの積・正の数の逆数は正（set_and_algebra_notation）の段を書き、鎖の根拠を参照にした。pi_squared_numerical_bounds の準備を remark_real_analysis_facts_R3_R4 の参照にした。値と主張・Lean・SageMath は不変。次は (cl3c3j8l)。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百十四個目として、状態台帳の (cl3c3j8k2) を行った。数学的道具立てに arcsin_of_one_is_half_pi（齋藤微積分 命題 2.1.5 から arcsin(1) = π/2）を足し、pi_is_positive を 020_critical_point.ts から arcsin_is_bijection の直後へ移した。angle_section_existence_uniqueness の π>0・2π>0（4 か所）、sine_integral_two_sided・log_integral_two_sided_bounds の π>0 を pi_is_positive の参照にし、R3_R4 の円周率の項ほか 3 か所の arcsin(1) = π/2 を新しい主張の参照にした。値と主張・Lean は不変。SageMath arcsin_of_one_is_half_pi を足した（PASS）。道具立ての違反は 32 件のまま。レビュー 2 回（必須 1・任意 5 を直し、2 回目は指摘なし）。次は (cl3c3j8k3)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-09: Lean の通しの証明のゴールラインの確認の三百十三個目として、状態台帳の (cl3c3j8k) を割り、2次元イジング側の 4 ブロック（pi_squared_numerical_bounds・three_halves_power_integral_bound・gamma_2_theta_tilde_nonzero・second_derivative_log_divergence）で名前だけの π > 0・2π > 0 を pi_is_positive の参照にした（second_derivative_log_divergence は準備に 0 < 2π を置いて引く）。値と主張・Lean・SageMath は不変。pi_is_positive を道具立てへ移しても前提 remark_real_analysis_facts_R3_R4 がイジング側なので違反は減らないため、道具立ての 2 ブロックは π の定義の置き場の件として (cl3c3j8k2) に、暗黙の派生形を (cl3c3j8k3) に分けた。レビュー 2 回で指摘なし。次は (cl3c3j8k2)。
2026-11-08: Lean の通しの証明のゴールラインの確認の三百十二個目として、状態台帳の (cl3c3j8j) を行った。moment_log_convexity【(W_ℝ)^ax は零でない】の x ≠ 0 を def_rayleigh_sup の 6 行の鎖を引く形にし、Lean の 2 段の補題 ne_zero_of_vecNorm_eq_one を削って使う 3 ファイルを ne_zero_of_unit_norm に替えた。abs_basic_properties (1) の √(y^2) = y・√((−y)^2) = −y の根拠を definition_of_sqrt_r_positive（s・u で）と sqrt_nonnegative_existence_uniqueness の参照にした。値と主張は不変。SageMath 103_abs_basic_properties/check_02 を足した（PASS）。レビュー 1 回、必須 1・任意 2 を直し、残り 2 件を (cl3c3j8m) に足した。次は (cl3c3j8k)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-08: Lean の通しの証明のゴールラインの確認の三百十一個目として、状態台帳の (cl3c3j8i) を行った。relation_of_gamma_2_theta_tilde の (3)(4) で 1 行に 2 事実以上を使っていた 7 か所（φ_polar((−r)_C)・φ_polar(r_C) の鎖の「ℝ の四則」、(3) の主の鎖の最後 2 行、(4) の (−1)(−r) = r・0/2 − 0·π = 0・「ℝ の四則を 2 箇所へ」、definition_of_sqrt_r_positive の前提）を一行一事実に割るか前提を書き足した（6 か所を割り、1 か所に前提を書いた）。値と主張・Lean は不変。SageMath を合わせた（PASS）。(3)(4) の外の 5 行を (cl3c3j8l) に足した。次は (cl3c3j8j)。
2026-11-08: Lean の通しの証明のゴールラインの確認の三百十個目として、状態台帳の (cl3c3j8h) を行った。主張 pi_is_positive（0 < π）を 020_critical_point.ts に足し、zero_in_closed_interval_from_minus_half_pi_to_half_pi の証明の準備の 3 本の鎖をそこへ移した。relation_of_gamma_2_theta_tilde の準備の第五の arcsin(0) を経る 0 < π の鎖と arcsin(0) = 0 の鎖を外してこの主張の参照にした。値と主張は不変。Lean は置かない（本文の π と Real.pi は定義が違う）。SageMath pi_is_positive を足し、zero_in_closed_interval…・relation_of_gamma_2_theta_tilde の検算を合わせた（PASS）。π > 0 を名前だけで使う残りの箇所を (cl3c3j8k) に足した。次は (cl3c3j8i)。
2026-11-08: Lean の通しの証明のゴールラインの確認の三百九個目として、状態台帳の (cl3c3j8g) を行った。本文で √0 = 0 を名前だけか複数の事実を 1 行で使っていた 7 行（def_rayleigh_sup・moment_log_convexity・abs_basic_properties・sqrt_expansion_via_polar の 3 行・arccosh_properties）を sqrt_of_real_zero_is_zero の参照にし、arccosh_properties (4) の 1^2 − 1 = 0 を power_of_real_one_is_one（m → 2）と a − a = 0 の 2 行に割った。値と主張は不変。Lean の ne_zero_of_unit_norm・ne_zero_of_vecNorm_eq_one の Real.sqrt_zero を具体版 sqrt_of_real_zero_is_zero に替えた。SageMath arccosh_properties PASS。通しの定理の型は不変。レビュー 2 回。任意 2 件を (cl3c3j8j) に足した。次は (cl3c3j8h)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。

2026-11-08: Lean の通しの証明のゴールラインの確認の三百八個目として、状態台帳の (cl3c3j8f) を行った。cosine_zero の証明の「ℝ の四則」1 行（0^2 = 0・1 − 0 = 1）を、square_of_real_number_is_product（r → 0）、ℝ で 0·x = 0（x → 0）、ℝ で a − 0 = a（a → 1）の 3 行に割った。値と主張は不変。Lean は cosine_zero を形式化していないので不変。SageMath cosine_zero を 6 行の鎖に合わせ、否定の対照を足した（PASS）。レビュー 2 回、必須なし。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (cl3c3j8g)。

2026-11-08: Lean の通しの証明のゴールラインの確認の三百七個目として、状態台帳の (cl3c3j8e) を行った。relation_of_gamma_2_theta_tilde の (3) の φ_polar((−r)_C) の鎖の最後の行（arctan 0 = 0 と ℝ の 0 + π = π を 1 行で使っていた）を、arctan_zero の行と ℝ で 0 + a = a（a → π）の行の 2 行に割った。値と主張は不変。Lean は (3) を形式化していないので不変。SageMath relation_of_gamma_2_theta_tilde に第 6 行の検算を足した（17/17 PASS）。レビュー 1 回、必須は残りの記録のみ。同じ主張の (3)(4) で 1 行に 2 事実以上を使う 7 か所を (cl3c3j8i) に足した。次は (cl3c3j8f)。

2026-11-08: Lean の通しの証明のゴールラインの確認の三百六個目として、状態台帳の (cl3c3j8d) を行った。主張 zero_in_closed_interval_from_minus_half_pi_to_half_pi（0 ∈ [−π/2,π/2]）を 020_critical_point.ts の sine_zero の直前に足した（arcsin(−1) = −π/2 と arcsin の狭義単調増加から −π/2 < π/2、0 < π、0 < π/2、−π/2 < 0。arcsin(0) を経ないので循環しない）。sine_zero の冒頭・arctan_zero の最後の行・relation_of_gamma_2_theta_tilde の準備の第五の arcsin(0) の鎖・cosine_zero の 1 行目から引くようにした。値と主張は不変。Lean は置かない（本文の π と Lean の Real.pi は定義が違う）。SageMath zero_in_closed_interval_from_minus_half_pi_to_half_pi（等号 10・不等号 8、PASS）。レビュー 2 回で必須なし。0 < π を主張にする件を (cl3c3j8h) に足した。次は (cl3c3j8e)。

2026-11-08: Lean の通しの証明のゴールラインの確認の三百五個目として、状態台帳の (cl3c3j8c) を行った。主張 sqrt_of_real_zero_is_zero（√0 = 0）を 000_calculation_formulae_20_29.ts に足し、relation_of_gamma_2_theta_tilde の準備の第五の cos(π/2) の鎖の「ℝ の四則」1 行を power_of_real_one_is_one（m → 2）と ℝ で a − a = 0 の 2 行に割り、最後の行を sqrt_of_real_zero_is_zero の参照にした。値と主張は不変。Lean 具体版 Ising2D.sqrt_of_real_zero_is_zero（ClaimSqrtOfRealZeroIsZero.lean、Real.sqrt_zero を使わない）。SageMath sqrt_of_real_zero_is_zero（等号 8 個 PASS）と relation_of_gamma_2_theta_tilde の cos(π/2) の行ごとの検算。build-flat-inventory の道具立ての違反が 1 件増えた（32）。√0 = 0 を名前だけで使う残り 5 か所を (cl3c3j8g) に足した。次は (cl3c3j8d)。

2026-11-08: Lean の通しの証明のゴールラインの確認の三百四個目として、状態台帳の (cl3c3j8b) を行った。inverse_of_sqrt_cc の √(1_C) の鎖の「ℝ の計算」1 行を 3 行（0/x = 0・0·x = 0・a − 0 = a）に割り、cos 0・sin 0 を cosine_zero・sine_zero の参照に、「ℝ の積の計算」を 1·x = x の 2 箇所適用にした。値と主張は不変。Lean は対応が無いので不変。SageMath 111_inverse_of_sqrt_cc/check_sqrt_of_one_chain.sage（11 件 PASS）。build-flat-inventory の道具立ての違反が 2 件増えた（31。台帳に記録）。cosine_zero の「ℝ の四則」1 行を (cl3c3j8f) に足した。次は (cl3c3j8c)。

2026-11-08: Lean の通しの証明のゴールラインの確認の三百三個目として、状態台帳の (cl3c3j8) を (cl3c3j8a)〜(cl3c3j8e) に割り、(cl3c3j8a) を行った。主張 arctan_zero（arctan 0 = 0、020_critical_point.ts の sine_zero の直後）を立て、relation_of_gamma_2_theta_tilde の準備の第五の鎖を移し、(3)(4) と inverse_of_sqrt_cc の φ_polar(1_C) の鎖から引いた。0 < π の鎖が使う arcsin(0) = 0 は 2 行の鎖として準備の第五に残した。値と主張は不変。Lean は対応が無いので不変。SageMath sagemath/check/arctan_zero/（PASS）、relation_of_gamma_2_theta_tilde は 12/12 PASS。build-flat-inventory の道具立ての違反が 1 件増えた（台帳に記録）。次は (cl3c3j8b)。

2026-11-08: Lean の通しの証明のゴールラインの確認の三百二個目として、状態台帳の (cl3c3j7b) を行った。exp_converges Step 4 の ‖E^{(k,l)}‖ = √1 の 1 行を、|0_K|・|1_K| の準備（K = ℂ は abs_basic_properties (3) と |1_C| = |ι(1_R)| = |1_R| = 1）、成分の絶対値の二乗の鎖 2 本、行ごとの和の鎖 2 本、ノルムの 5 行の鎖に割った（【e_k のノルム】と同じ書き方。値と主張は不変）。Lean は対応の具体版が無いので不変。SageMath 145_exp_converges/check_02_matrix_unit_norm_chain.sage（2525 件 PASS）。通しの定理の型は不変。0_C・1_C の値を述べるブロックが本文に無いことを (cl3c3j9) に足した。次は (cl3c3j8)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。

2026-11-08: Lean の通しの証明のゴールラインの確認の三百一個目として、状態台帳の (cl3c3j7) を (cl3c3j7a)・(cl3c3j7b) に割り、(cl3c3j7a) を行った。inverse_of_sqrt_cc の φ_polar(1_C) の鎖の「ℝ の計算 1^2+0^2=1」を 4 行に、relation_of_gamma_2_theta_tilde の arctan 0 の鎖の「0/√1 = 0」を 5 行に割った（値と主張は不変）。Lean は対応の補題が無いので不変。SageMath は arctan 0 の鎖を行の式どうしで確かめる形にし、111 に check_phi_polar_of_one_chain.sage を足した（PASS）。111 の check_01 はこの環境の Sage で __file__ の読み込みが壊れて落ちる（既存・無関係）。レビュー 1 回で必須なし。次は (cl3c3j7b)（exp_converges Step 4 の ‖E^{(k,l)}‖ の鎖）。

2026-11-08: Lean の通しの証明のゴールラインの確認の三百個目として、状態台帳の (cl3c3j6) を行った。trace_power_upper_bound【e_k のノルム】の 2 行目「i ≠ k の項は |(e_k)_i|^2 = |0|^2 = 0」を、i ≠ k の 3 行の鎖（def_rayleigh_sup と同じ）とノルムの鎖の「各項へ当てる」「0 + a = a・a + 0 = a を左から順に」の 2 行に割った。Lean 具体版 norm_of_standard_basis_vector に hoff（3 段）を置き calc を 7 段に（Finset.sum_eq_single・abs_zero・norm_num を消した）。SageMath 等号 38414 個・30168 個 PASS。通しの定理の型は不変。レビュー 2 回で必須なし。次は (cl3c3j7)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百九十九個目として、状態台帳の (cl3c3j5) を行った。本文で √1 = 1 を名前だけの根拠か複数の事実で 1 行に書いていた 7 行（cos_arctan_sin_arctan、exp_converges Step 4、norm_of_normalized_real_vector_is_one、cosine_zero、closed_form_log_integral の F(0) の鎖、sqrt_of_reciprocal の √(1_C) 系 2 行）を sqrt_of_real_one_is_one の参照にした（値と主張は不変）。Lean 具体版 norm_of_normalized_real_vector_is_one の最後の段を sqrt_of_real_one_is_one にした。SageMath はコメントだけ（再実行 PASS）。通しの定理の型は不変。レビュー 1 回で必須なし。残りを (cl3c3j7) に足した。次は (cl3c3j6)。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百九十八個目として、状態台帳の (cl3c3j4) を行った。thermodynamic_limit_row_limit_and_max_eigenvalue.ts の trace_power_upper_bound【e_k のノルム】の √(|1|^2) = √1 を、def_real_absolute_value の |1| = 1 の行と power_of_real_one_is_one（m → 2）の行に割った。Lean 具体版 norm_of_standard_basis_vector の calc を同じ 2 段にし（abs_one・one_pow を消した）、SageMath trace_power_upper_bound に根拠と 2 段を足した（等号 36830 個・28528 個 PASS）。通しの定理の型は不変。レビュー 1 回で必須なし。同じ鎖の 2 行目 |(e_k)_i|^2 = |0|^2 = 0 を (cl3c3j6) に残した。次は (cl3c3j5)。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百九十七個目として、状態台帳の (cl3c3j3) を行った。trace_power_sandwich【(W_ℝ)^n の半正定値性】z ≠ 0 の段の ‖z‖ ≠ 0 の背理を、‖z‖ = 0 の代入・square_of_real_number_is_product（r → 0）・ℝ で 0·x = 0（x → 0）の 3 行の鎖に開いた（値と主張は不変）。Lean 具体版 norm_pos_of_component_ne_zero の hne を 3 段の calc にした。SageMath はコメントだけ合わせた。次は (cl3c3j4)。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百九十六個目として、状態台帳の (cl3c3j2) を行った。主張 sqrt_of_real_one_is_one（√1 = 1）を 000_calculation_formulae_20_29.ts に足し、thermodynamic_limit_row_limit_and_max_eigenvalue.ts の def_rayleigh_sup・trace_power_upper_bound・trace_power_sandwich の √1 = 1 の 3 か所をその参照にした（def_rayleigh_sup の「ℝ で 1^2 = 1」も power_of_real_one_is_one の参照に）。Lean 具体版 Ising2D.sqrt_of_real_one_is_one（ClaimSqrtOfRealOneIsOne.lean）を足し 3 か所を閉じた。必要十分版は置かない。SageMath sqrt_of_real_one_is_one PASS。通しの定理の型は不変。レビュー 2 回。残りを (cl3c3j4)・(cl3c3j5) に足した。次は (cl3c3j3)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百九十五個目として、状態台帳の (cl3c3j) を割り前半を行った。thermodynamic_limit_row_limit_and_max_eigenvalue.ts の trace_power_sandwich【(W_ℝ)^n の半正定値性】z ≠ 0 の段で、|z_j|^2 ≥ 0 の根拠の鎖と |z_{j_0}| > 0 の def_real_absolute_value の場合分けを置き、‖z‖^2 の鎖（4 行）、z_i = ‖z‖w_i（4 行）、‖w‖ の鎖（15 行）、z^⊤(W_ℝ)^nz の鎖（8 行）を 1 行 1 事実に割った。Lean 具体版 ClaimTracePowerSandwichUnitVectorBound.lean を 1 対 1 に（abs_sq_of_real_number_nonneg・abs_pos_of_real_number_ne_zero を足し sq_nonneg・abs_pos・mul_inv_cancel_left₀ を消した）。SageMath 等号 19814 個・28372 個 PASS。通しの定理の型は不変。レビュー 2 回。次は (cl3c3j2)（√1 = 1 の 3 か所）。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百九十四個目として、状態台帳の (cl3c3i) を行った（(cl3c3h4) は並行の実行が二百九十三個目で済ませていた）。000_calculation_formulae_00_09.ts の positive_real_square_injective の主張に二乗が def_power_of_real_number の冪であることを書き、名前だけの根拠「等しい実数を二乗しても等しい」「2 乗の差の因数分解」を代入の行と 8 行の鎖（分配法則・交換法則・打ち消し・square_of_real_number_is_product）に割った。Lean 具体版 factor_difference_of_squares_eq_zero（8 段の calc、ring を消した）、必要十分版を Ring + Commute b a に弱めて NecSuf.factor_difference_of_squares_eq_zero' と導出を置き、NecSuf/ConstantC.lean を合わせた。SageMath（等号 23940 個 PASS）。通しの定理の型は不変。行列の二乗 X^2 := XX を (cl3c3p) に足した。レビュー 2 回で必須なし。次は (cl3c3j)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百九十三個目として、状態台帳の (cl3c3h4) を行った。eigenvalue_problem_diagonalization_and_exponential_form.ts の anticommutator_of_check_psi の準備 5 の r_ν の鎖の名前だけの根拠「ℝ で (−x)^2 = x^2」を、square_of_real_number_is_product (r → −x)・ℝ の四則演算 (−a)(−b) = ab・square_of_real_number_is_product (r → x) の 3 行に割り（11 行 → 13 行）、準備 5 に x, y ∈ ℝ と二乗が def_power_of_real_number の冪であることを書いた。Lean 具体版 checkR_conj（DefinitionCheckFermi.lean）を人手の 13 行と 1 対 1 の calc にし、補題 sqrt_normSq_mk_eq_sqrt_sq_add_sq を足した。必要十分版は不要と判断（理由は状態台帳）。SageMath 1674/1674 PASS。通しの定理の型は不変。レビュー 2 回で必須なし。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (cl3c3i)。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百九十二個目として、状態台帳の (cl3c3h3) を行った。eigenvalue_problem_diagonalization_and_exponential_form.ts の det_A_theta_tilde の最後の等式の鎖の「ℝ の冪 x^2 = xx」「xx = x^2」と gamma1_gt_1_theta_tilde の準備・背理の鎖の「平方の定義」の 4 行を square_of_real_number_is_product の参照にし、主張・準備に二乗が def_power_of_real_number の冪であることを書いた。Lean 具体版 gamma1R_sq_thetaTilde（13 行の鎖）・gamma1_gt_1_prep_absGamma2_sq_pos・one_lt_gamma1R_sq_thetaTilde・gamma1R_thetaTilde_sq_le_one_of_le_one・one_lt_gamma1R_thetaTilde を人手と 1 対 1 にし（nlinarith を消した）、必要十分版 NecSuf.sq_pos_of_pos_implication_chain・sq_le_one_of_le_one_chain・one_lt_of_sq_gt_one（一般の型クラス）と導出 ClaimDetATildeFromNecSuf.lean を置いた。通しの定理の型は不変。次は (cl3c3h4)。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百九十一個目として、状態台帳の (cl3c3h2) を行った。eigenvalue_problem_diagonalization_and_exponential_form.ts の relation_of_gamma_2_theta_tilde で、主張に |γ_2| が def_abs_arg の絶対値、|γ_2|^2 が def_power_of_real_number の冪であることなどを書き、(2) を γ_2γ_2(−θ̃) = (−|γ_2|^2)_ℂ と −|γ_2|^2 < 0 の 2 式に分けた（−|γ_2|^2 を ℂ と ℝ の両方で使わないため）。0 < |γ_2|^2 の鎖の名前だけの根拠「実数の 2 乗の定義」を square_of_real_number_is_product の参照にした。Lean 具体版 absGamma2_thetaTilde_sq_pos・neg_absGamma2_thetaTilde_sq_neg、必要十分版 NecSuf.sq_pos_of_pos_chain・neg_neg_of_pos_chain、導出 ClaimRelationGamma2TildeFromNecSuf.lean を置き、SageMath を鎖の行ごとの検算にした（13/13 PASS）。通しの定理の型は不変。レビュー 7 回で必須なし。(2) の等式の Lean の形と 9 行の鎖の欠けを (cl14)、不等式の根拠のブロックの欠けを (cl3c3n) に足した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (cl3c3h3)。
2026-11-08: Lean の通しの証明のゴールラインの確認の二百九十個目として、状態台帳の (cl3c3h) を (cl3c3h1)〜(cl3c3h4) に割り、(cl3c3h1) を行った。sqrt_nonnegative_existence_uniqueness の s^2 = s·s・ε^2 = ε·ε の 2 行の名前だけの根拠「2 乗の定義」を square_of_real_number_is_product の参照にした（平方根を使わないので循環しない）。Lean・SageMath は変えていない。レビュー 1 回で必須なし、任意を (cl3c3m) に足した。次は (cl3c3h2)。
2026-11-08: Lean の通しの証明のゴールラインの確認の二百八十九個目として、状態台帳の (cl3c3g) を行った。definition_of_sqrt_r_positive と sqrt_nonnegative_existence_uniqueness の主張に、二乗 y^2 が def_power_of_real_number の冪（m = 2）であることを書き足した。sqrt_squared_is_original の √r·√r = r の行を square_of_real_number_is_product の行と定義の y^2 = x の行に割り（SageMath を行 0〜10 に直した）、eigenvalues_of_V_plus (2) の積の鎖 19 行目の「y^2 = yy」を square_of_real_number_is_product の参照にした（Lean checkBigLambda_max_mul_min の rw [sq] を同じ主張に替えた）。レビュー 1 回で必須なし。残りを (cl3c3k)・(cl3c3l) に足した。次は (cl3c3h)。
2026-11-08: Lean の通しの証明のゴールラインの確認の二百八十八個目として、状態台帳の (cl3c3f) を行った（(cl3c3e) は並行の実行が二百八十七個目で済ませていた）。thermodynamic_limit_row_limit_and_max_eigenvalue.ts の trace_power_sandwich で def_power_of_real_number の冪をその場で開いていた二乗と積の行き来を square_of_real_number_is_product、1^2 = 1 を power_of_real_one_is_one から引く行にし、複数の事実を使う行を割った（‖w‖ 9 → 14 行、Σx_k^2 3 → 4 行、m_{k+1} 5 → 6 行、成分の評価 7 → 8 行）。SageMath（rpow、全 PASS）と Lean 具体版 ClaimTracePowerSandwichUnitVectorBound.lean を 1 対 1 に直した。通しの定理の型は不変。残りを (cl3c3j) に足した。次は (cl3c3g)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin、新しい作業ツリーでは structured-latex/ と論文側の両方で pnpm install --frozen-lockfile が要る。
2026-11-08: Lean の通しの証明のゴールラインの確認の二百八十七個目として、状態台帳の (cl3c3e) を行った。eigenvalue_problem_eigenvalues_of_V_plus.ts の constant_c_value_even_sector の局所定義 a^2 := aa・c^2 := cc を消し、a^2 を def_power_of_real_number、c^2 を def_power_of_complex_number の冪にした。c^2w の鎖 15 行 → 20 行、(ρρ, 0) の鎖 6 行 → 10 行、ρ^2 = a^2 を 3 行の鎖に。SageMath（等号 510 個 PASS）、Lean 具体版 constant_c_steps_four_five・必要十分版 NecSuf.const_eq_of_trace_chains を新しい鎖と 1 対 1 に直した。通しの定理の型は不変。positive_real_square_injective の二乗の宣言と名前だけの根拠を (cl3c3i) に足した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (cl3c3f)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。
2026-11-08: Lean の通しの証明のゴールラインの確認の二百八十六個目として、状態台帳の (cl3c3d) を行った。eigenvalue_problem_diagonalization_and_exponential_form.ts の anticommutator_of_check_psi の準備と準備 5 の二乗を def_power_of_real_number の冪に一本化し（局所定義 |a_μ|^2 := |a_μ||a_μ|・s^2 := ss を消した）、積との行き来を square_of_real_number_is_product、s^2 = M_col を definition_of_sqrt_r_positive の y^2 = x から引いた。b_μ b_ν の鎖は 7 行 → 8 行、t t の鎖は 6 行 → 7 行。SageMath check_coefficients.sage を冪 rpow で組み直した（1672 件 PASS）。Lean は変えていない（ClaimAnticommutatorCheckPsi.lean は係数の鎖を ring・field_simp で閉じ、元から人手の準備と 1 対 1 でない。台帳に (cl13) として足した）。名前だけの「2 乗の定義」などの残りを (cl3c3h) に足した。レビュー 1 回で必須なし。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (cl3c3e)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百八十五個目として、状態台帳の (cl3c3c) を行った。thermodynamic_limit_column_limit_and_closed_form.ts の norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four・def_sector_rayleigh_sup・c_between_Lambda_half_and_twice_Lambda_half の二乗を def_power_of_real_number の冪に一本化し（局所定義 ‖v‖^2 := ‖v‖‖v‖・r^2 := rr を消した）、積との行き来を square_of_real_number_is_product、1^2 = 1 を power_of_real_one_is_one から引いた。at_most_four の鎖は 8 行 → 9 行。SageMath 3 件と Lean 具体版 3 ファイルを新しい行と 1 対 1 に直した。通しの定理の型は不変。レビュー 2 回。次は (cl3c3d)。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百八十四個目として、状態台帳の (cl3c3b) を行った。011_max_eigenvalue.ts の norm_of_normalized_real_vector_is_one・real_bilinear_value_of_normalized_vector の二乗を def_power_of_real_number の冪に一本化し（局所定義 r^2 := rr・‖v‖^2 := ‖v‖‖v‖ を消した）、積との行き来を square_of_real_number_is_product、1^2 = 1 を power_of_real_one_is_one から引いた。前者の鎖は 9 行 → 11 行。SageMath 2 件と Lean 具体版 2 件を新しい鎖と 1 対 1 に直した。通しの定理の型は不変。残りに (cl3c3g)（definition_of_sqrt_r_positive の y^2 の意味の明記）を足した。次は (cl3c3c)。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百八十三個目として、状態台帳の (cl3c3)（実数の二乗の記号が、その場の r^2 := rr と def_power_of_real_number の冪の 2 つの意味を持つ記号の濫用）を (cl3c3a)〜(cl3c3f) に割り、(cl3c3a) を行った。二乗は def_power_of_real_number の冪に一本化し、積の形は新しい主張 square_of_real_number_is_product（r^2 = r^1 r = (r^0 r) r = (1 r) r = r r）から引く。square_of_real_absolute_value・square_of_real_sum_is_at_most_twice_sum_of_squares の二乗を冪に替え、積へ開く行を足した。SageMath 3 件（1 件新規）、Lean 具体版 square_of_real_number_is_product・必要十分版 NecSuf.sq_eq_mul_self'・導出を置き、2 主張の具体版・必要十分版を新しい鎖と 1 対 1 に直した。通しの定理の型は不変。レビュー 2 回。次は (cl3c3b)（011_max_eigenvalue.ts の局所定義）。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百八十二個目として、状態台帳の (cl3c2) を行った。Lean の rayleighSet・evenSectorSet（と退避経路の sectorSet）の条件を人手と同じ vecNorm x = 1 に書き換え、def_rayleigh_sup の「‖x‖ = 1 なら x ≠ 0」の 6 行（ne_zero_of_unit_norm）と ‖e_1‖ = 1 の鎖（vecNorm_single）を人手と 1 対 1 にした。vecNormSq で単位ベクトルを作る既存の証明は Lean だけの読み替え vecNorm_eq_one_of_vecNormSq_eq_one・vecNormSq_eq_one_of_vecNorm_eq_one で渡す。通しの定理の型は不変。次は (cl3c3)（二乗の記号の 2 つの意味）、その後 (cl4)。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百八十一個目として、状態台帳の (cl3c) を三つに割り (cl3c1) を行った。人手 def_sector_rayleigh_sup のノルムの鎖の結論 ‖x^{(+)}‖^2 = 1 から 𝓡_+ の条件 ‖x^{(+)}‖ = 1 へ根拠なしに進んでいた欠けを、‖x‖ ∈ ℝ≥0・‖x‖=0 を仮定した 4 行の鎖・‖x‖^2 = 1^2 の 3 行の鎖と positive_real_square_injective で埋めた。SageMath（c_plus_le_c の鎖、等号 621 個）、Lean 具体版 vecNorm_evenUnit_succ と読み替えの段 vecNormSq_eq_one_of_vecNorm_eq_one を置いた。通しの定理の型は不変。次は (cl3c2)（Lean の evenSectorSet・rayleighSet の条件 vecNormSq x = 1 を人手の ‖x‖ = 1 に揃えるか）、その後 (cl3c3)（二乗の記号の 2 つの意味）。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百八十個目として、状態台帳の (cl3b) を行った。人手に主張 product_of_real_powers_is_power_of_product（a^m b^m = (ab)^m）と power_of_real_one_is_one（1^m = 1）を足し、def_sector_rayleigh_sup のノルムの鎖を 3 行（定義の無い 2^{-M_col} と名前だけの「指数法則」）から一ステップ一定理の 14 行にした。SageMath（新設の 2 つと c_plus_le_c の鎖）、Lean 具体版・必要十分版・導出と、人手の 14 行と 1 対 1 の calc の vecNorm_sq_evenUnit_succ を置いた。通しの定理の型は不変。レビュー 2 回。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (cl3c)（‖x‖^2 = 1 から ‖x‖ = 1 への根拠の欠けと、Lean の vecNormSq x = 1 との読み替え、二乗の記号の 2 つの意味）。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin。新しい作業ツリーでの初回 lake build は 10 分を超えるので、背景実行の時間の上限を長く取る。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百七十九個目として、状態台帳の (cl3a) を行った。人手に主張 finite_product_of_constant_real_is_power（Π_{j=1}^{m} r = r^m）を足し、def_sector_rayleigh_sup の x^{(+)} の各成分の値を 3 行の鎖（(1/√2)^{M_col}。定義の無い 2^{-M_col/2} を消した）にした。SageMath（新設の検算と c_plus_le_c の鎖）、Lean 具体版・必要十分版・導出、evenUnit_apply_succ を人手と 1 対 1 に置いた。通しの定理の型は不変。レビュー 1 回で必須 0 件。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (cl3b)（人手のノルムの鎖の 2^{-M_col} を冪の法則の鎖に書き直してから vecNormSq_evenUnit を calc に）。注意: lake は ~/.elan/bin、sage は ~/micromamba/envs/sage/bin にあり、非対話のシェルの PATH に入っていない。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百七十八個目として、状態台帳の (cl2f) を行った。人手 `W_has_positive_entries` の Step 3 の必要十分版 `NecSuf/SandwichByDiagonal.lean` を、(cl2e) の具体版と同じ並び（補助の鎖 2 本・外側の和を先に潰す主の鎖・`w > 0` の有限積・主張の形）に書き直し、係数は `AddCommMonoid`・`Mul` と明示の `x·0 = 0`・`0·x = 0`、値は積を保つ写像 `φ` の像で受ける形にした。`ClaimPhysicalWHasPositiveEntriesFromNecSuf.lean` で具体版 5 本を `R := ℂ`・`S := ℝ` の特殊化として導き、旧い特殊化だけが使っていた実成分の補題 7 つを消した。人手・SageMath・通しの定理の型は不変。次は (cl3)（`def_sector_rayleigh_sup` の `(1/√2)^{M_col}` の鎖）。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百七十七個目として、状態台帳の (cl2e) を行った。人手 `W_has_positive_entries` の Step 3 の主の鎖 9 行（複素行列のまま、外側の和を先に潰す）と `w > 0` の 2 行を `ClaimPhysicalWHasPositiveEntries.lean` に Lean 具体版 `physicalSymTransferC_apply_configBasisIso`・`symTransferEntryProduct_pos` として置き、主張の形 `W_has_positive_entries` をそれらで閉じた。実成分の `physicalSymTransferR_pos`・`W_has_positive_entries_physical` は人手 `W_real_has_positive_entries` と同じ手順で主張の形から導き直した（型は不変）。人手・SageMath・通しの定理の型は不変。次は (cl2f)（必要十分版 `NecSuf/SandwichByDiagonal.lean` とその導出を主の鎖の手順に合わせ、冒頭の古いコメントも直す）。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百七十六個目として、状態台帳の (cl2d) を行った。人手 `W_has_positive_entries` の準備の `e(μ,μ')`・`v(μ,μ')`・`v(μ,μ') > 0`、Step 2 の `(V_2)_{kl}` の 3 行、Step 3 の補助の鎖 2 本を `ClaimPhysicalWHasPositiveEntries.lean` に Lean 具体版（`sameSiteSpinProductSum`・`secondTransferEntry(_pos)`・`V2_apply_configBasisIso_eq_secondTransferEntry`・`physicalV1halfC_mul_V2_apply_mul_apply_of_ne`・`physicalV1halfC_apply_mul_V2_apply_of_ne`）として置き、`physicalV2R_apply_configBasisIso`（型は不変）を Step 2 の鎖から導き直した。人手・SageMath・通しの定理の型は不変。次は (cl2e)（Step 3 の主の鎖 9 行と `w > 0`）。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百七十五個目として、状態台帳の (cl2c) を行った。人手 `W_has_positive_entries` の準備の `X`・`b(μ)`・`b(μ) > 0` と Step 1 の `X_pq`（3 行）・`B_pq`（2 行）・`B_kk`（7 行）の鎖を `ClaimPhysicalWHasPositiveEntries.lean` に Lean 具体版（`halfK1SmulD`・`squareRootV1DiagonalEntry(_pos)`・`halfK1SmulD_apply_of_ne`・`halfK1SmulD_eq_diagonal`・`physicalV1halfC_apply_of_ne`・`physicalV1halfC_apply_configBasisIso_self`）として置き、`physicalV1halfC_apply_configBasisIso` をそれらから導き直した（型は不変）。人手・SageMath・通しの定理の型は不変。次は (cl2d)（Step 2 の 3 行と Step 3 の補助の鎖 2 本）。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百七十四個目として、状態台帳の (cl2b) を行った。人手 `W_has_positive_entries` の Step 1 の `D_pq`・`D_kk` の鎖を Lean 具体版 `sum_sigmaZ_sigmaZ_apply_of_ne`・`sum_sigmaZ_sigmaZ_apply_configBasisIso_self`（準備の `d(μ)` は `adjacentSpinProductSum`）に置き、鎖が引く `site_sigma_z_product_is_diagonal`・`site_sigma_z_product_diagonal_entry` の 1 対 1 の具体版を `ClaimSigmaZDiagonalAction.lean` に足した。人手・SageMath・通しの定理の型は不変。次は (cl2c)（Step 1 の `X_pq`・`B_pq`・`B_kk` の鎖）。

2026-11-08: Lean の通しの証明のゴールラインの確認の二百七十三個目として、状態台帳の (cl2a) を行った。人手 `W_has_positive_entries` の主張の形（複素行列 `W` の `ι(μ), ι(μ')` 成分が `w_ℂ`、`w ∈ ℝ_{>0}`）の Lean 定理 `W_has_positive_entries` を `ClaimPhysicalWHasPositiveEntries.lean` に立て、言い換えの形 `W_has_positive_entries_as_inclusion` を人手の最後の段どおり `ι` の全射性でそこから導き直した。証明本体はまだ実成分の経路で、(cl2b)〜(cl2e) で人手の鎖に組み直す。人手・SageMath・通しの定理の型は不変。次は (cl2b)（Step 1 の `D_pq`・`D_kk` の鎖）。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百七十二個目として、状態台帳の (cl1) を行った。「M→∞ の極限と閉形式」の章の人手は `M_col ≥ 1`・`K_1, K_2 > 0` を主張に置くので、Lean 具体版 7 定理（`W_real_has_positive_entries`・`epsilon_real_commutes_with_W_real`・下限の 2 倍の主張・`epsilon_entries_in_row_configuration_numbering`（準備の 2 補題も）・`W_has_positive_entries_physical`・`physicalSymTransferR_pos`・`W_has_positive_entries_as_inclusion`）に人手どおりの仮定を足し、呼び出し側 `c_le_twice_c_plus_physical`・`W_has_positive_entries_physical_of_necSuf`・`onsager_exact_solution_unconditional` の呼び出しを直した。証明は仮定を使わない。人手・SageMath・通しの定理の型は不変。次は (cl2a)（`W_has_positive_entries` の複素行列の形の主張）。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百七十一個目として、`thermodynamic_limit_column_limit_and_closed_form.ts`（「M→∞ の極限と閉形式」の章）の各ブロックと Lean 具体版の 1 対 1 を洗い出した。主張・定義・定理の 30 ブロックのうち、16 は 1 対 1（ε_ℝ の性質の鎖、`onsager_free_energy_expression`、`even_eigenspace_is_complex_subspace` ほか）。1 対 1 でないものを状態台帳に (cl1)〜(cl12) の単位として章の並びで書いた: 主張の仮定（`0 < K1`・`M_col ≥ 1`）の欠け、`W_has_positive_entries`（実行列へ移して畳む）、`def_sector_rayleigh_sup` のノルムの鎖、`c_plus_le_c`（人手の「上限の単調性」に引くブロックが無い）、`epsilon_commutes_with_W`（mathlib の `Commute` へ委譲）、`gamma_is_continuous`（`Real.continuousOn_arcosh` へ委譲）、`Z_Y_linearly_independent`（Clifford 関係の別証明）、`check_number_operator_is_hermitian`、`c_plus_equals_Lambda_half_integer`（人手が使わない「`V^{(+)}` は実行列」を経る経路）、`c_between_Lambda_half_and_twice_Lambda_half`、`onsager_exact_solution`（挟み撃ちと `(log 2)/M → 0` に人手のブロックが無い）、章のゴールの主張の表現。Lean・本文・SageMath は不変。次は (cl1)（主張の仮定を人手に揃える）。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百七十個目として、状態台帳の (r12) を行った。人手 `partition_function_via_transfer_matrix` とそれを「同じ設定」で受ける `partition_function_via_pauli_transfer_matrices`・`Z_equals_trace_of_W`・`partition_function_sandwich` は `K_1, K_2 ∈ ℝ_{>0}` を置くので、Lean の具体版 5 定理に人手どおり `0 < K1`（足りないものは `0 < K2` も）を仮定に足し、呼び出し 3 か所（章のゴールの主張・`onsager_exact_solution_unconditional`・ノートへ退避した `partition_function_sector_decomposition`）とコメント・README・`lean/docs/ch011-formalization.md` を直した。証明は正値性を使わない。人手・SageMath・通しの定理の型は不変。次は `thermodynamic_limit_column_limit_and_closed_form.ts` の各ブロックと Lean 具体版の 1 対 1 の洗い出し。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百六十九個目として、状態台帳の「行列の大きさの記号を章で揃える件」の「残りの箇所」を行い、この件を済ませた。章の概観 `maxeig_000_remark_overview` と章のゴールの主張 `partition_function_sandwich_and_limit_in_N_row` に `d := 2_ℤ^{M_col}` を置いて行列の大きさ・ベクトルの次元を `d` にし、`ℝ` の `2^{M_col}`（`2_ℝ^{M_col}` の略記）と `ι_{ℤ→ℝ}` の略記の断りを書いた。`trace_power_sandwich` の「`d^2` 個の項」を「組 `(k,l)` ごとの項」にし、`limit_of_log_Z_in_N_row` の証明に `2_ℝ`・`2_ℝ^{M_col}` の略記を置いた。Lean は冒頭のコメントだけ直した。値・手順・SageMath・通しの定理の型は不変。次は (r12)。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百六十八個目として、状態台帳の「行列の大きさの記号を章で揃える件」の「作用素ノルムの評価のブロック」を行った。人手 `rayleigh_bounds_operator_norm` の主張の冒頭で `d := 2_ℤ^{M_col}` を置き、添字なしの `2^{M_col}`（26 か所）を `d` にし、`def_matrix_norm` の当てはめに `K = ℝ, d → d, w → y` を書いた。Lean は `ClaimOperatorBound.lean` の冒頭のコメントだけ直した。値・手順・SageMath・通しの定理の型は不変。次は「残りの箇所」。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百六十七個目として、状態台帳の「行列の大きさの記号を章で揃える件」の「Rayleigh 上限の定義のブロック」を行った。人手 `def_rayleigh_sup` の主張の冒頭で `d := 2_ℤ^{M_col}` を置き、添字なしの `2^{M_col}`（40 か所）を `d` にし、`def_matrix_norm` の当てはめに `K = ℝ` を足した。Lean は `DefinitionRayleighSup.lean` の冒頭のコメントだけ直した。値・手順・SageMath・通しの定理の型は不変。次は「作用素ノルムの評価のブロック」。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百六十六個目として、状態台帳の「行列の大きさの記号を章で揃える件」の「W の正定値性のブロック」を行った。人手 `W_is_real_symmetric_positive_definite` の証明の冒頭で `d := 2_ℤ^{M_col}` を置き、行列の大きさの添字なしの `2^{M_col}`（25 か所）を `d` にし、当てはめの無かった 5 つの主張の引用に `n → d` ほかを書いた。Lean は対応のコメントだけ直した。値・手順・SageMath・通しの定理の型は不変。次は「Rayleigh 上限の定義のブロック」。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百六十五個目として、状態台帳の「行列の大きさの記号を章で揃える件」を五つのブロックの単位に割り、先頭の「W_ℝ の定義と性質の 4 ブロック」を行った。人手 `def_W_real`・`W_real_is_symmetric`・`W_real_is_positive_definite`・`W_real_is_positive_semidefinite` の主張の冒頭で `d := 2_ℤ^{M_col}`（`def_power_of_integer`・`power_of_two_in_integers_is_at_least_one`）を置き、行列の大きさの添字なしの `2^{M_col}`（26 か所）を `d` にした。`W_real_is_positive_definite` は証明の冒頭の `d` を主張へ移して書き方の二通りを無くし、`def_W_real` は `W ∈ Mat(d,ℂ)` の出典に `def_symmetrized_transfer_matrix` を引いた。値・手順・SageMath・通しの定理の型は不変。Lean は `PhysicalPartitionFunctionSandwich.lean` の docstring と正本の一覧だけ直した。レビュー 2 回で必須 1 件・任意 3 件（うち 2 件を直した）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は「W の正定値性のブロック」（`W_is_real_symmetric_positive_definite` の 25 か所）。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百六十四個目として、状態台帳の (r11c) を行った。人手 `real_log_of_power` の右辺を `ι_{ℤ→ℝ}(n) log a` にし、`limit_of_log_Z_in_N_row` の ℤ の元 `M_col`・`N_row`・`N_0` を ℝ の式に入れる箇所・ℝ と比べる箇所をすべて `inclusion_zz_to_rr` の `ι` で通した。主張 `inclusion_zz_to_rr_of_positive_is_at_least_one`・`inclusion_zz_to_rr_of_nonpositive_is_nonpositive`・`inclusion_zz_to_rr_is_monotone_on_nonnegatives` を足した（Lean 具体版・必要十分版・導出、SageMath の検算 3 本）。Lean の極限の段はアルキメデス性を `exists_int_gt`（`N_0 ∈ ℤ`）で取るようにし、必要十分版も同じ手順にした。値・通しの定理の型は不変。レビュー 2 回で必須 1 件（必要十分版の「効いていないもの」の誤り）と任意の指摘を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は行列の大きさの記号を章で揃える件、その後 (r12)。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百六十三個目として、状態台帳の (r11b) を行った。人手 `partition_function_sandwich` と同じ章の 5 ブロック（`Z_equals_trace_of_W`・`W_real_is_positive_definite`・`trace_of_W_power_via_W_real`・`moment_log_convexity`・`trace_power_sandwich`）の行列の大きさ `d`（`n_0`）`:= 2^{M_col}` を ℤ の冪 `2_ℤ^{M_col}`（`def_power_of_integer`・`power_of_two_in_integers_is_at_least_one`）にし、`trace_power_sandwich`・`partition_function_sandwich` の主張の ℝ の `2^{M_col}` が `2_ℝ^{M_col}` の略記で `d` とは別の元だと書いた。`d` を ℝ の元として使う行は無いので `inclusion_zz_to_rr_of_power_of_two` を通す行は足していない。Lean は対応のコメント 4 ファイルだけを直した。値・手順・SageMath・通しの定理の型は不変。レビュー 2 回で必須なし、任意 5 件を直した。章全体の添字なしの `2^{M_col}`（行列の大きさ、約 100 か所）は状態台帳に残した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r11c)。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百六十二個目として、状態台帳の (r11) を (r11a)〜(r11c) に割り、(r11a) を行った。本文に ℤ から ℝ への包含写像 inclusion_zz_to_rr（ι_{ℤ→ℝ}）と、ι(1) = 1・非負の整数の和を保つこと・定数の有限和 Σ r = ι(m)r・ℤ の冪 def_power_of_integer・2_ℤ^M ≥ 1・ι(2_ℤ^M) = 2_ℝ^M を足し、trace_power_upper_bound の最後の鎖（行列の大きさ d ∈ ℤ と ℝ の冪 2^{M_col} を同じ記号で結んでいた）をそれらの参照にした。Lean 具体版・必要十分版・導出、SageMath の検算 5 本を足した。値・主張・通しの定理の型は不変。レビュー 3 回で必須 3 件・任意 10 件を直した。次は (r11b) partition_function_sandwich の d、続けて (r11c) limit_of_log_Z_in_N_row の N_0・N_row と real_log_of_power の n log a。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百六十一個目として、状態台帳の (r10) を行った。Lean partition_function_sandwich_and_limit_in_N_row に人手の主張どおり仮定 _hK1 : 0 < K1 を足した（証明は使わない。先例 critical_point_iff_kappa_zero と同じ形）。冒頭の対応表の rayleighSup_pos に渡すものを正定値性だけに直し、lean/docs/ch011-formalization.md の K_1 の記述を直した。ch011 の trace_power_sandwich の行は人手と既に合っていた。通しの定理の型・本文・SageMath は不変。次は (r11)（d := 2^{M_col} の ℤ から ℝ への写像）。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百六十個目として、状態台帳の (r9b) を行った。人手 limit_of_log_Z_in_N_row の「非負の実数の絶対値はそれ自身」を def_real_absolute_value の q ≥ 0 の場合への参照にし、アルキメデス性で N_0 を取る 1 文を、アルキメデス性の述べ方と適用先 t = log 2/ε の文と、log 2/ε > 0・0 < N_0 ⟹ N_0 ≥ 1・log 2 = (log 2/ε)ε < N_0ε の表示式の鎖に分けた。正の数で割る・約す・引く・u ≤ v の場合分けは引ける主張が無く高校教科書レベルなので名前のまま残した。Lean ClaimLimitInNRow.lean の ht・hN0eps の 2 段の calc と対応表、SageMath の assert と overview を合わせた。値・主張・通しの定理の型は不変。レビュー 3 回で必須 1 件・任意 9 件を直した（ℤ から ℝ への写像を名指さない前からの書き方 1 件は残した）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r10)。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百五十九個目として、状態台帳の (r9) を (r9a) Lean の側・(r9b) 人手の名前だけの根拠に割り、(r9a) を行った。limit_of_log_Z_in_N_row の具体版を人手の 10 行の含意の鎖（MN で一度に割る）と log 2 > 0 の準備・ε と N_0 の鎖に 1 対 1 で書き直し、Lean に無かった real_log_strictly_increasing・real_log_of_product・real_log_of_power の具体版と必要十分版（NecSuf/InverseOfAdditiveToMultiplicativeMap.lean）を置いた。必要十分版 LogSqueeze を同じ手順（順序半環から順序体への写像、C ≥ 0）に替えた。人手の証明冒頭の冪の正値性の根拠を real_log_of_power・real_log_of_product にした。通しの定理の型は不変。レビュー 3 回で必須 2 件・任意 11 件を直した。次は (r9b)。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百五十八個目として、状態台帳の (r8) を行った。人手 partition_function_sandwich の主張から、(r7c) で無くなった「trace_power_sandwich がその場で定める冪」への言及を除き、2^{M_col} の帰属を ℝ にした。Lean の準備の定理を partition_function_eq_sum_diag_W_real_pow（Z = Σ_k ((W_ℝ)^{N_row})_kk、人手の 2 行と単射性と 1 対 1）に改め、partition_function_sandwich_physical から書き換えの往復を除いた。lean/README.md に partition_function_sandwich の行を足し、ch011・check-no-sorry の名前を直した。値・手順・SageMath・通しの定理の型は不変。レビュー 3 回で必須 1 件・任意 8 件を直した。残した件: 証明の d := 2^{M_col} ∈ ℤ と ℝ の冪の使い回し（trace_power_upper_bound の単位で直す）。次は (r9) limit_of_log_Z_in_N_row。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百五十七個目として、状態台帳の (r7c) を行った。人手 trace_power_sandwich で実数の冪を名前だけ・根拠なしで使っていた行（「冪の定義」の 7 行と、s^0 = 1・m_k^2・二乗の段など）と、主張の段落の冪の再定義を def_power_of_real_number の参照にし、|t|^2 = t^2 の 3 か所を square_of_real_absolute_value の参照にした。Lean の注記を合わせ、mul_pow・pow_pos で閉じていた 3 段を sq で積に開く段にした。値・手順・通しの定理の型は不変。レビュー 2 回で必須 4 件・任意 5 件を直した。次は (r8)（済んでいるかを確かめ、済んでいれば (r9)）。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百五十六個目として、状態台帳の (r7b) を行った。人手 trace_power_sandwich の【正の実数の冪の比較】・【上限への移行】（背理法）と主張そのものの Lean 具体版を人手と 1 対 1 の calc で置き（ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimTracePowerSandwich.lean。一般の W : TensorPow M、本文の W への当てはめは trace_power_sandwich_physical）、partition_function_sandwich_physical をそれを引く 2 本の calc にした。人手が捨てた経路（TraceBound.lean、n 乗根の rayleighSup_pow_le_trace_pow ほか）と、どこからも使われない一般の実行列の partition_function_sandwich（ClaimPartitionFunctionSandwich.lean）を消した。人手・SageMath・通しの定理の型は不変。レビュー 2 回で必須 3 件・任意 7 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r7c)（人手の「冪の定義」6 か所を def_power_of_real_number の参照に）。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百五十五個目として、状態台帳の (r7) を (r7a)〜(r7c) に割り、(r7a) を行った。人手 trace_power_sandwich の下からの評価の前半（【冪の実数の行列】の (W_ℝ)^1 = W_ℝ・成分の対称性・半正定値性・成分の評価・【単位ベクトルでの評価】）の Lean 具体版を人手と 1 対 1 の calc で置いた（ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimTracePowerSandwichUnitVectorBound.lean。一般の W : TensorPow M）。必要十分版 NecSuf.IsPdPair.moment_ratio_le・moment_pow_le の説明を直し、導出 moment_ge_moment_one_pow_of_necSuf を置いた。人手・SageMath・通しの定理の型は不変。レビュー 2 回で必須 2 件・任意 6 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r7b)（冪の比較と背理法、trace_power_sandwich 本体の書き直しと使う側の付け替え）。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百五十四個目として、状態台帳の (r6) を行った。人手 moment_log_convexity の Lean 具体版 moment_log_convexity を人手の各段と 1 対 1 の calc で置いた（ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimMomentLogConvexity.lean。一般の W : TensorPow M で述べ、本文の W への当てはめは PhysicalPartitionFunctionSandwich.lean の moment_log_convexity_physical）。必要十分版 NecSuf.IsPdPair.moment_pos・NecSuf.IsPsdPair.moment_log_convex の説明を直し、同じ型の導出 moment_log_convexity_of_necSuf（ClaimMomentLogConvexityFromNecSuf.lean）を置いた。人手・SageMath・通しの定理の型は不変。次は (r7)（trace_power_sandwich を具体版を引く人手の鎖へ）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百五十三個目として、状態台帳の (r5b) を行った。人手 trace_power_upper_bound の Lean 具体版を人手の各段と 1 対 1 の calc で置いた（ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimTracePowerUpperBound.lean。一般の W : TensorPow M で述べ、本文の W への当てはめは PhysicalPartitionFunctionSandwich.lean の trace_power_upper_bound_physical）。必要十分版 NecSuf.IsPsdPair.moment_le_pow からの同じ型の導出 trace_power_upper_bound_of_necSuf を置き、ch011-formalization.md の psd_quad_le_normSq_mul_trace・psd_abs_entry_le の対応欄を直した。trace_power_sandwich の上側を新しい具体版へ替えるのは (r7)。人手・SageMath・通しの定理の型は不変。次は (r6)（moment_log_convexity の具体版）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百五十二個目として、状態台帳の (r5) を (r5a)・(r5b) に割り、(r5a) を行った。人手 matrix_power_exponent_law と power_of_real_symmetric_complex_matrix_is_real_symmetric の Lean 具体版（人手の鎖と 1 対 1）と必要十分版（任意のモノイド／可換半環と閉じた性質）を置いた。人手・SageMath・通しの定理の型は不変。次は (r5b)（trace_power_upper_bound の具体版）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百五十一個目として、状態台帳の (r3b3) を行った。列の極限の章の部分はそれまでの回で済んでいたことを確かめ、005_exp_conjugation_proof.ts の frobenius_inner_product_axioms の Step 5・Step 6 の「ι_{ℝ→ℂ} の単射性」2 か所を inclusion_rr_to_cc_is_injective の参照に替えた。epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors の略記 ι に def_real_vector_inclusion の参照を添えた。Lean・SageMath・通しの定理の型は不変。レビューは必須 0 件、任意 4 件のうち 2 件を直した。次は (r5)（trace_power_upper_bound の具体版）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百五十個目として、状態台帳の (r3b2e3e) を行った。旧い形 Z = tr(…)（ℝ と ℂ を等号で結ぶ）の残りを、本文 chapter_organization.ts の章の案内「転送行列による表示」（inclusion_rr_to_cc を引いて (Z)_ℂ に）、Lean の注記 7 ファイル、lean/README.md、lean/docs/ch011-formalization.md、SageMath の overview 3 件で (Z(K_1,K_2))_ℂ に揃えた。実行列の ℝ の等式の仮定 hZ には「本文には無い、実成分の行列で述べた形」と添えた。Lean の証明・通しの定理の型は不変。レビュー 2 回で必須 2 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r3b3)。注意: lake は ~/.elan/bin にあり、非対話のシェルの PATH に入っていない。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百四十九個目として、状態台帳の (r3b2e3d) を行った。参照用ノート minus_sector_not_adopted.ts の「分配関数の偶奇セクター分解」の左辺 5 か所を、本文 partition_function_via_transfer_matrix の今の形 (Z(K_1,K_2))_ℂ（inclusion_rr_to_cc）に揃え、由来の括弧書きにその旨を足した。Lean の証明は不変（元から ((partitionFunction … : ℝ) : ℂ)）で、ClaimPartitionFunctionSectorDecomposition.lean の冒頭と lean/docs/ch010-formalization.md の式を合わせた。レビューは必須 0 件、任意 9 件のうち 1 件を直し、残る 8 件（本文 chapter_organization.ts の章の案内ほか、旧い形 Z = tr(…) の残り）を (r3b2e3e) にした。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r3b2e3e)。注意: lake は ~/.elan/bin にあり、非対話のシェルの PATH に入っていない。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百四十八個目として、状態台帳の (r3b2e3c5) を行った。人手の章のゴールの主張 c_plus_value_c_sandwich_and_double_limit_of_log_Z の (1) を W_ℝ の二次形式に、記号の一覧を W_ℝ・ε_ℝ・積・二次形式・ノルムの出どころに直し、章冒頭の案内文 maxeig_remark_overview_c_plus_and_epsilon を W_ℝ・ε_ℝ の道筋に書き直した。Lean の証明・SageMath の検算は不変（Lean の冒頭の説明と overview の注記だけ直した）。レビュー 4 回で必須 3 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。(r3b2e3c) は済み、次は (r3b2e3d)。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百四十七個目として、状態台帳の (r3b2e3c4d5e) を行った。人手 c_between_Lambda_half_and_twice_Lambda_half の Step 2 の具体版 c_le_twice_c_plus_physical には必要十分版を置かないと判断した（引いた主張を上限の性質と ℝ の四則演算でつなぐだけ）。既存の NecSuf/EvenSectorUpperBound.lean（Step 2 の前の形、Cauchy–Schwarz の形の形式化）とその特殊化 onsager_step3_c_le_two_c_plus ほかは、PermSector.lean と同じく形式化の記録として残し、説明・lean/README.md・lean/docs の対応表を合わせた。quad_le_quad_absVec は寄せない（使う側が記録だけ）。Lean の証明と通しの定理の型は不変。レビュー 3 回（1 回目の必須 3 件・任意 2 件、2 回目の必須 2 件・任意 2 件を直し、3 回目は必須 0 件）。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r3b2e3c5)（c_plus_value_c_sandwich_and_double_limit_of_log_Z）。注意: lake は ~/.elan/bin にあり、非対話のシェルの PATH に入っていない。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百四十六個目として、状態台帳の (r3b2e3c4d5d) を行った。人手 c_between_Lambda_half_and_twice_Lambda_half の Step 2 と 1 対 1 の Lean 具体版 c_le_twice_c_plus_physical（TheoremOnsagerExactSolution.lean。W_ℝ・ε_ℝ について Λ = c_+ なら c(M) ≤ 2Λ。準備の各行を同名の Lean 定理で引き、7 行・2 行・2 行の鎖を calc の同じ段で書いた）を足し、通しの経路の rayleighSup_sandwich_LambdaM_physical の Step 2 をこれに替えた。必要十分版の特殊化 onsager_step3_c_le_two_c_plus は任意の W の版として残し、通しの定理は使わない。通しの定理の型は不変。レビュー 2 回（1 回目の必須 3 件を直した）。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r3b2e3c4d5e)（必要十分版 NecSuf/EvenSectorUpperBound.lean を具体版と同じ手順へ寄せるか、置かない判断にするか）。注意: lake は ~/.elan/bin にあり、非対話のシェルの PATH に入っていない。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百四十五個目として、状態台帳の (r3b2e3c4d5c) を行った。人手 c_between_Lambda_half_and_twice_Lambda_half の Step 2 を W_ℝ・ε_ℝ で書き直し、散文の各行を既に足した主張を 1 つずつ引く準備（12 項）と、Λ = c_+ ≥ v̂^⊤W_ℝv̂ = … ≥ x^⊤W_ℝx/2 の 7 行・x^⊤W_ℝx ≤ 2Λ の 2 行・c(M) = sup𝓡 ≤ 2Λ の 2 行の鎖にした（主張と論法は不変）。SageMath の Step 2 の検算を新しい行に替えた（x 192 本、否定コントロール 3 種、PASS）。Lean は証明を変えず説明だけを合わせた。通しの定理の型は不変。レビュー（必須 0 件、任意 4 件のうち 3 件を直した）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r3b2e3c4d5d)（Lean の onsager_step3_c_le_two_c_plus を人手の鎖と 1 対 1 に）。注意: lake は ~/.elan/bin にあり、非対話のシェルの PATH に入っていない。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百四十四個目として、状態台帳の (r3b2e3c4d5b3) を行った。正規化したベクトルの残り 2 つを主張として足すと決め、人手 011_max_eigenvalue.ts に real_matrix_fixed_vector_stays_fixed_after_normalization（(Pv)_i = v_i なら (Pv̂)_i = v̂_i、準備 2 行と 4 行の鎖）と real_bilinear_value_of_normalized_vector（v̂^⊤Pv̂ = (v^⊤Pv)/‖v‖^2、準備 2 行と 4 行の鎖）を足した。SageMath の検算（630 段・350 段、否定コントロール計 3 件、AA で厳密、PASS）、Lean 具体版 2 ファイル（ThermodynamicLimit/RowLimitAndMaxEigenvalue/、人手と 1 対 1 の calc。必要十分版は置かない）。通しの定理の型は不変。レビュー 2 回（必須 0 件、任意 4 件を直した）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r3b2e3c4d5c)（c_between_Lambda_half_and_twice_Lambda_half の Step 2 の本文の書き換え）。注意: sage は ~/micromamba/envs/sage/bin にある（PATH に入れて run-all-checks.sh を実行する）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百四十三個目として、状態台帳の (r3b2e3c4d5b2) を行った。人手 002_linear_space_general.ts に主張 real_matrix_vector_product_commutes_with_real_scalar_multiple（w_k = c u_k なら (Pw)_i = c(Pu)_i、7 行の鎖）を足した。SageMath の検算（280 段、否定コントロール 2 種、PASS）、Lean 具体版 ClaimRealMatrixVectorProductCommutesWithRealScalarMultiple.lean（人手と 1 対 1 の calc）、必要十分版 NecSuf/MatrixVectorProductCommutesWithScalarMultiple.lean（非単位的な半環、c と P_ij の可換性を明示の仮定に）と導出。通しの定理の型は不変。レビュー 2 回で必須 1 件・任意 5 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r3b2e3c4d5b3)。注意: lake exe cache get は PATH に ~/.elan/bin を入れて実行する（入れないと mathlib をソースから組み始める）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百四十二個目として、状態台帳の (r3b2e3c4d5b)（正規化したベクトルの主張）を (d5b1)〜(d5b3) に割り、(r3b2e3c4d5b1) を行った。人手 011_max_eigenvalue.ts に主張 norm_of_normalized_real_vector_is_one（v ∈ ℝ^n, v ≠ 0、v̂_k := v_k/‖v‖ なら ‖v̂‖ = 1。準備は matrix_norm_triangle_inequality (1) からの ‖v‖ > 0・‖v‖^2 ≠ 0 と ‖x‖^2 = Σ|x_k|^2、主張は 9 行の鎖）を norm_of_vector_of_absolute_values_equals_norm の後へ足した。SageMath の検算（54 本で 891 段、否定コントロール 1 件、AA で厳密、PASS）、Lean 具体版 ClaimNormOfNormalizedRealVectorIsOne.lean（人手と 1 対 1 の calc。準備の vecNorm_sq_eq_sum_abs_sq を ClaimNormSquared…AtMostFour.lean からこのファイルへ移した。必要十分版は置かない）。通しの定理の型は不変。レビュー 3 回で必須 1 件・任意 9 件を直した（ℤ から ℝ への写像を名指さない前からの書き方 1 件は残した）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r3b2e3c4d5b2)（実数の行列とベクトルの積とスカラー倍の交換）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百四十一個目として、状態台帳の (r3b2e3c4d5)（`c_between_Lambda_half_and_twice_Lambda_half` の Step 2 の本文の書き換え）を (r3b2e3c4d5a)〜(d5d) に割り、(r3b2e3c4d5a) を行った。人手 011_max_eigenvalue.ts の real_bilinear_value_at_most_value_at_absolute_vector の後へ主張 norm_of_vector_of_absolute_values_equals_norm（u_k := |x_k| なら ‖u‖ = ‖x‖。def_matrix_norm・u の定義・square_of_real_absolute_value（q → |x_k|）・def_matrix_norm の 4 行の鎖）を足した。SageMath sagemath/check/norm_of_vector_of_absolute_values_equals_norm/（54 本、405 段、否定コントロール 1 件、AA で厳密、PASS）。Lean 具体版 ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimNormOfVectorOfAbsoluteValuesEqualsNorm.lean（人手と 1 対 1 の calc）。必要十分版は置かない。通しの定理の型は不変。レビューの必須 0 件・任意 3 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r3b2e3c4d5b)（正規化したベクトル v̂_k := v_k/‖v‖ の ‖v̂‖ = 1・ε_ℝv̂ = v̂・v̂^⊤W_ℝv̂ = v^⊤W_ℝv/‖v‖^2）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百四十個目として、状態台帳の (r3b2e3c4d4) を行った。人手 thermodynamic_limit_column_limit_and_closed_form.ts に主張 W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice（u_k ≥ 0、v_k := u_k + (ε_ℝu)_k なら v^⊤W_ℝv ≥ 2(u^⊤W_ℝu)。準備 3 つと 11 行の鎖。W_ℝ の対称性は使わず、交差項 2 つを非負性で落とす）を epsilon_real_commutes_with_W_real の後へ足した。SageMath の検算（864 段、PASS）、Lean 具体版 ClaimWRealBilinearValueAtSumOfNonnegativeVectorAndItsEpsilonRealImageIsAtLeastTwice.lean（人手と 1 対 1 の calc。必要十分版は置かない）。通しの定理の型は不変。レビュー 2 回で必須 2 件・任意 5 件を直した。次は (r3b2e3c4d5)（c_between_Lambda_half_and_twice_Lambda_half の Step 2 を (d1)〜(d4) の主張を引く形に書き換える）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百三十九個目として、状態台帳の (r3b2e3c4d3c) を行った。人手 thermodynamic_limit_column_limit_and_closed_form.ts に主張 norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four（‖u‖ = 1、v_k := u_k + (ε_ℝu)_k なら ‖v‖^2 ≤ 4。成分ごとの |v_k|^2 ≤ 2|u_k|^2 + 2|(ε_ℝu)_k|^2 を和に移し、‖ε_ℝu‖ = ‖u‖ で閉じる）を足した。Cauchy–Schwarz の P → I_ℝ の道は I_ℝ の主張が本文に無いので採らなかった。このために 000_calculation_formulae_00_09.ts に square_of_real_absolute_value（|q|^2 = q^2）と square_of_real_sum_is_at_most_twice_sum_of_squares（(a+b)^2 ≤ 2a^2+2b^2）を足した。SageMath 3 件 PASS、Lean 具体版 2 ファイル（人手と 1 対 1）、必要十分版 NecSuf/SquareOfAbsoluteValueAndOfSum.lean（環で通り、乗法の可換性は効かない）と導出。通しの定理の型は不変。レビューの必須 0 件・任意 6 件を直した。次は (r3b2e3c4d4)（v^⊤W_ℝv ≥ 2u^⊤W_ℝu）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百三十八個目として、状態台帳の (r3b2e3c4d3b) を行った。人手 thermodynamic_limit_column_limit_and_closed_form.ts に主張 sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero（u_k ≥ 0（全 k）かつ u ≠ 0、v_k := u_k + (ε_ℝu)_k なら v ≠ 0。u_{k_0} ≠ 0 なる k_0 で 4 行の鎖 v_{k_0} ≥ u_{k_0} > 0）を epsilon_real_preserves_nonnegative_vectors の後へ足した。SageMath の検算（532 段、PASS）、Lean 具体版 ClaimSumOfNonnegativeVectorAndItsEpsilonRealImageIsNonzero.lean（人手と 1 対 1 の calc。必要十分版は置かない）。通しの定理の型は不変。レビューの必須 0 件・任意 3 件を直した。次は (r3b2e3c4d3c)（‖u‖ = 1 なら ‖v‖^2 ≤ 4）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百三十七個目として、状態台帳の (r3b2e3c4d3) を (d3a)〜(d3c) に割り、(r3b2e3c4d3a) を行った。人手 thermodynamic_limit_column_limit_and_closed_form.ts に主張 epsilon_real_fixes_sum_of_vector_and_its_image（v_k := u_k + (ε_ℝu)_k なら ε_ℝv = v、各成分の 10 行の鎖）を epsilon_real_square_is_identity の後へ足した。SageMath の検算（140 段、PASS）、Lean 具体版 ClaimEpsilonRealFixesSumOfVectorAndItsImage.lean（人手と 1 対 1 の calc。必要十分版は置かない）。通しの定理の型は不変。レビューの必須 1 件・任意 1 件を直した。次は (r3b2e3c4d3b)（v ≠ 0）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百三十五個目として、状態台帳の (r3b2e3c4d2e) を行った。人手 011_max_eigenvalue.ts に主張 real_bilinear_value_with_nonnegative_entries_is_nonnegative（P_kl, x_k, y_l ≥ 0 なら x^⊤Py ≥ 0）と real_bilinear_value_of_scalar_multiple_vector（w_k = c u_k なら w^⊤Pw = (cc)(u^⊤Pu)、13 行の鎖）を別ブロックで足した。SageMath 2 件 PASS（6200 段・65 段）、Lean 具体版 ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultiple.lean（人手と 1 対 1）、必要十分版 NecSuf/BilinearValueNonnegativeAndScalarMultiple.lean と導出、NecSuf の有限型の添字の版 finite_sum_mul_left'・finite_sum_ge_term'。通しの定理の型は不変。レビュー 2 回で必須 2 件・任意 5 件を直した。次は (r3b2e3c4d2f)（x^⊤P(Qy) と x^⊤(PQ)y の類。(d4) の鎖が要る形だけ）。
2026-11-07: Lean の通しの証明のゴールラインの確認の二百三十六個目として、状態台帳の (r3b2e3c4d2f) を行った。人手 011_max_eigenvalue.ts に主張 real_bilinear_value_is_sum_with_real_matrix_vector_product（u^⊤Pv = Σ_k u_k(Pv)_k、4 行の鎖）と real_symmetric_matrix_moves_between_factors_of_sum_of_products（対称な Q で Σ_k(Qu)_kv_k = Σ_k u_k(Qv)_k、10 行の鎖）を別ブロックで足した（実数の行列の積の結合則が本文に無いので、(d4) の (ε_ℝu)^⊤W_ℝ(ε_ℝu) = u^⊤W_ℝu を行列とベクトルの積の等式で組む形）。SageMath 2 件 PASS（20 段・50 段）、Lean 具体版 ClaimRealBilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors.lean（人手と 1 対 1）、必要十分版 NecSuf/BilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors.lean と導出。通しの定理の型は不変。レビューで必須 2 件・任意 3 件を直した。次は (r3b2e3c4d3)（v := u + ε_ℝu の ε_ℝv = v・v ≠ 0・‖v‖^2 ≤ 4）。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百三十四個目として、状態台帳の (r3b2e3c4d2d) を行った。人手 011_max_eigenvalue.ts に主張 real_bilinear_value_is_additive_in_right_vector（w_l = y_l + z_l なら x^⊤Pw = x^⊤Py + x^⊤Pz、6 行の鎖）と real_bilinear_value_is_additive_in_left_vector（w_k = y_k + z_k なら w^⊤Px = y^⊤Px + z^⊤Px、7 行の鎖）を別ブロックで足した（ℝ^n の和は未定義なので w を成分の等式で与える）。SageMath 2 件 PASS（30 段・35 段）、Lean 具体版 ClaimRealBilinearValueIsAdditive.lean（人手と 1 対 1 の calc）、必要十分版 NecSuf/BilinearValueIsAdditive.lean（非単位的な半環、同じ段）と導出。通しの定理の型は不変。レビュー 3 回で必須 1 件・任意 9 件を直した（ℤ から ℝ への写像を名指さない前からの書き方 1 件は残した）。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r3b2e3c4d2e)（成分が非負の P・a・b で a^⊤Pb ≥ 0、スカラー倍 (cx)^⊤P(cx) = c^2 x^⊤Px）。

2026-11-07: Lean の通しの証明のゴールラインの確認の二百三十三個目として、状態台帳の (r3b2e3c4d2c) を行った。人手 011_max_eigenvalue.ts に主張 real_bilinear_value_of_symmetric_matrix_is_symmetric（対称な P で u^⊤Pv = v^⊤Pu、7 行の鎖）を足し、psd_cauchy_schwarz の準備をその参照に替えた。SageMath 1 件 PASS（psd_cauchy_schwarz の検算から準備を外した）、Lean 具体版（MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueOfSymmetricMatrixIsSymmetric.lean、人手と 1 対 1。psd_cauchy_schwarz の具体版もこれを引く。dotProduct_mulVec_eq_real_bilinear_value を RealMatrixBilinearFormAndNorm.lean へ移した）、必要十分版 NecSuf/BilinearValueOfSymmetricMatrixIsSymmetric.lean（非単位的な可換半環）と導出。通しの定理の型は不変。次は (r3b2e3c4d2d)。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百三十二個目として、状態台帳の (r3b2e3c4d2b) を行った。人手に主張 finite_double_sum_of_real_numbers_interchange（実数の二重の有限和の順序の入れ替え、n_1 の帰納法で finite_sum_of_real_sums を引く）を足し、psd_cauchy_schwarz の準備と real_matrix_vector_product_is_associative の名前だけの「有限和の順序の入れ替え」をその参照に替えた。SageMath 1 件（156 段）PASS、Lean 具体版（人手と 1 対 1 の calc と有限型の添字の系。real_matrix_vector_product_is_associative の Finset.sum_comm もこれに替えた）、必要十分版 NecSuf/FiniteDoubleSumInterchange.lean（加法の可換モノイドだけ）と導出。通しの定理の型は不変。次は (r3b2e3c4d2c)（対称な P での u^⊤Pv = v^⊤Pu を主張に切り出す）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百三十一個目として、状態台帳の (r3b2e3c4d2) を (r3b2e3c4d2a)〜(d2f) に割り、(r3b2e3c4d2a) を行った。人手に主張 finite_sum_of_real_sums（実数の有限和 Σ(a_j+b_j) = Σa_j + Σb_j、複素数の兄弟 finite_sum_of_complex_sums と同じ帰納法）を足した。SageMath 1 件 PASS、Lean 具体版（ClaimFiniteSumsOfRealNumbers.lean、人手と 1 対 1 の calc と有限型の添字の系）、必要十分版は既存の NecSuf.finite_sum_add_fin' の特殊化として導出。通しの定理の型は不変。次は (r3b2e3c4d2b)（実数の二重の有限和の順序の入れ替え）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百三十個目として、状態台帳の (r3b2e3c4d)（c_between_Lambda_half_and_twice_Lambda_half の Step 2 の書き直し）を (r3b2e3c4d1)〜(d5) に割り、(r3b2e3c4d1) を行った。人手 011_max_eigenvalue.ts に主張 real_bilinear_value_at_most_value_at_absolute_vector（成分が非負の実数の行列 P について u_k := |x_k| なら x^⊤Px ≤ u^⊤Pu。9 行の鎖）を足した。SageMath 1 件（40 組 920 段 PASS）、Lean 具体版（人手と 1 対 1 の calc）、必要十分版 NecSuf/BilinearValueAtMostValueAtAbsoluteVector.lean（係数は PosMulMono を持つ順序付きの結合的な環）と導出。通しの定理の型は不変。次は (r3b2e3c4d2)（Step 2 が使う実数の双線型値の性質のうち本文に無いもの）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百二十九個目として、状態台帳の (r3b2e3c4c2c) を行った。人手に主張 negated_row_configuration_is_involutive（-(-s) = s）と epsilon_real_preserves_norm（‖ε_ℝu‖ = ‖u‖。付け替え χ(k) := ord(-ord^{-1}(k)) が全単射で (ε_ℝu)_k = u_{χ(k)}、二乗和を finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing で付け替える）を足した。SageMath 2 件 PASS、Lean 具体版 ClaimEpsilonRealPreservesNorm.lean（人手と 1 対 1 の calc）と添字が有限型の付け替えの系、negSpinConf_negSpinConf を calc に。通しの定理の型は不変。次は (r3b2e3c4d)（c_between_Lambda_half_and_twice_Lambda_half の Step 2 を ε_ℝ・W_ℝ で書き直す）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百二十八個目として、状態台帳の (r3b2e3c4c2b3) を行った。人手に主張 finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing（{1,…,m} 上の全単射 π について Σ a_{π(j)} = Σ a_j、m についての帰納法で、π(k) = m+1 の項を末尾へ移し τ^π_k に帰納法の仮定を当てる）を足した。SageMath 1 件 PASS、Lean 具体版 ClaimFiniteSumOfRealNumbersReindexedByBijection.lean（人手と 1 対 1 の calc）、必要十分版 NecSuf/FiniteSumReindexedByBijection.lean（加法の可換モノイドと全単射だけ）と導出。通しの定理の型は不変。次は (r3b2e3c4c2c)（‖ε_ℝu‖ = ‖u‖）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百二十七個目として、状態台帳の (r3b2e3c4c2b2) を行った。人手に一つの添字を飛ばす写像 δ^m_k の 3 主張（飛ばした添字を値に取らない・単射・それ以外のすべてを値に取る）と、π(k) = m+1 の全単射 π について π(δ^m_k(j)) ∈ {1,…,m}・τ^π_k(j) := π(δ^m_k(j)) の定義・τ^π_k の全単射性を足した（実数の有限和の添字の付け替え不変性の準備）。SageMath 2 件 PASS、Lean 具体版 2 ファイル、必要十分版 NecSuf/BijectionComposedWithIndexSkippingMap.lean（値の範囲と定義は単射だけ）と導出。通しの定理の型は不変。次は (r3b2e3c4c2b3)（付け替えの主張そのもの）。単射・全射の定義ブロックが本文に無い件を状態台帳に残した。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百二十六個目として、状態台帳の (r3b2e3c4c2b) を (r3b2e3c4c2b1)〜(r3b2e3c4c2b3) に割り、(r3b2e3c4c2b1) を行った。人手 `000_calculation_formulae_00_09.ts` に定義 `def_index_skipping_map`（一つの添字を飛ばす写像 `δ^{m}_{k}`）と主張 `finite_sum_of_real_numbers_moves_one_term_to_end`（実数の有限和の一つの項は末尾へ移せる。`m` についての帰納法で、`m = 1` を `k = 1, 2`、帰納法の段を `k = m+2`・`k ≤ m+1` に分けた鎖）を足した。Lean 具体版 `DefinitionIndexSkippingMap.lean`（`skipIndex`）と `ClaimFiniteSumsOfRealNumbers.lean` の calc（人手と 1 対 1）、必要十分版 `NecSuf/FiniteSumMovesOneTermToEnd.lean`（加法の可換モノイドだけ）と特殊化。SageMath の検算（473 段、否定コントロール 44 件、PASS）。レビューの必須 0 件、任意 8 件を直した。check-end-to-end はこの時点で既に通る（ゴールラインの残りは状態台帳の確認項目）。次は (r3b2e3c4c2b2)。
2026-11-06: Lean の通しの証明のゴールラインの確認の二百二十五個目として、状態台帳の (r3b2e3c4c2) を (r3b2e3c4c2a)〜(r3b2e3c4c2c) に割り、(r3b2e3c4c2a) を行った。人手に `epsilon_real_preserves_nonnegative_vectors`（すべての `k` で `u_k ≥ 0` なら、すべての `k` で `(ε_ℝu)_k ≥ 0`。`k = ord(s)` と置き `epsilon_real_permutes_entries_by_spin_flip` の 3 行の鎖）を足した（c_between_Lambda_half_and_twice_Lambda_half の Step 2 の同一視を ε_ℝ で書き直す準備）。SageMath 1 件（PASS）、Lean `ClaimEpsilonRealPreservesNonnegativeVectors.lean`（人手と 1 対 1 の calc）。通しの定理の型は不変。次は (r3b2e3c4c2b)（実数の有限和が添字の全単射による付け替えで変わらないこと）。
2026-11-06: Lean の通しの証明のゴールラインの確認の二百二十四個目として、状態台帳の (r3b2e3c4c) を (r3b2e3c4c1)・(r3b2e3c4c2) に割り、(r3b2e3c4c1) を行った。人手に定義 `def_negated_row_configuration`（`-s`）と主張 `epsilon_entries_in_row_configuration_numbering`（`ε_{ord(s),ord(s')}` は `s' = -s` のとき `1_ℂ`、ほかは `0_ℂ`。クロネッカー積表示の成分の積）・`epsilon_real_permutes_entries_by_spin_flip`（`(ε_ℝu)_{ord(s)} = u_{ord(-s)}`）を足した（c_between_Lambda_half_and_twice_Lambda_half の Step 2 の同一視を ε_ℝ で書き直す準備）。SageMath 2 件（PASS）、Lean `ClaimEpsilonRealPermutesEntriesBySpinFlip.lean`（人手と 1 対 1 の calc）。通しの定理の型は不変。次は (r3b2e3c4c2)（`u ≥ 0` なら `ε_ℝu ≥ 0`、`‖ε_ℝu‖ = ‖u‖`）。
2026-11-06: Lean の通しの証明のゴールラインの確認の二百二十三個目として、状態台帳の (r3b2e3c4b) を行った。人手に `W_real_has_positive_entries`（W_ℝ の成分はすべて正。2 行の鎖と単射性）と `epsilon_real_commutes_with_W_real`（ε_ℝW_ℝ = W_ℝε_ℝ。ϱ が積を保つことと εW = Wε の 3 行の鎖）を足した（c_between_Lambda_half_and_twice_Lambda_half の Step 2 の同一視を ε_ℝ・W_ℝ で書き直す準備）。SageMath `sagemath/check/W_real_has_positive_entries/`・`epsilon_real_commutes_with_W_real/`（PASS）、Lean `ClaimEpsilonRealCommutesWithWRealAndWRealHasPositiveEntries.lean`（人手と 1 対 1 の calc）。通しの定理の型は不変。次は (r3b2e3c4c)（ε_ℝ が成分を符号反転で並べ替えることとその帰結）。
2026-11-06: Lean の通しの証明のゴールラインの確認の二百二十二個目として、状態台帳の (r3b2e3c4) を (r3b2e3c4a)〜(r3b2e3c4d) に割り、(r3b2e3c4a) を行った。人手に `epsilon_real_is_symmetric`（ε_ℝ は対称）と `epsilon_real_square_is_identity`（ε_ℝε_ℝ = I_{Mat(d,ℝ)}）を足した（c_between_Lambda_half_and_twice_Lambda_half の Step 2 の同一視を ε_ℝ で書き直す準備）。SageMath `sagemath/check/epsilon_real_is_symmetric/`・`epsilon_real_square_is_identity/`（PASS）、Lean `ClaimEpsilonRealIsSymmetricAndSquareIsIdentity.lean`（人手と 1 対 1 の calc）。通しの定理の型は不変。次は (r3b2e3c4b)（ε_ℝW_ℝ = W_ℝε_ℝ と W_ℝ の成分の正値性）。
2026-11-06: Lean の通しの証明のゴールラインの確認の二百二十一個目として、状態台帳の (r3b2e3c3) を行った。人手 `c_plus_equals_Lambda_half_integer` の主張の `x^⊤Wx` を `def_W_real` の `x^⊤W_ℝx` に直し、準備 1 の局所の `ι^n`・`W_ℝ := (w_kl)`・「`(·)_ℂ` の単射性」を `def_real_vector_inclusion`・`def_W_real`・`inclusion_rr_to_cc_is_injective` への参照に替え、準備 2 と Step 2 の `(Wq̄)_k` の鎖を一ステップ一定理に分けた。SageMath PASS、Lean はコメントだけ直した。次は (r3b2e3c4)（`c_between_Lambda_half_and_twice_Lambda_half` を `ε_ℝx = x` と `W_ℝ` で書き直す）。
2026-11-06: Lean の通しの証明のゴールラインの確認の二百二十個目として、状態台帳の (r3b2e3c2c3) を行った。人手 `def_sector_rayleigh_sup` の `𝓡_+` の条件を `x ∈ ℝ^{2^{M_col}}, ε_ℝx = x` に述べ直し、`x^{(+)}` を実数の側（成分 `Π_k(a_+)_{i_k}`）で定めて `ι(x^{(+)}) = b_+⊠⋯⊠b_+`・`ει(x^{(+)}) = ι(x^{(+)})`・`ε_ℝx^{(+)} = x^{(+)}` の鎖で示した。下流の `c_plus_equals_Lambda_half_integer`・まとめの (1)・章冒頭の remark の集合も揃えた。SageMath PASS、Lean の `evenUnit`・`epsilonR_mulVec_evenUnit` を人手と 1 対 1 に書き直した。次は (r3b2e3c3)（`c_plus_equals_Lambda_half_integer` の `x^⊤Wx` を `W_ℝ` で書き直す）。
2026-11-06: Lean の通しの証明のゴールラインの確認の二百十九個目として、状態台帳の (r3b2e3c2c2) を行った。Lean に数ベクトルのクロネッカー積 `vecKron`（人手 `def_kronecker` (1)）と `kronecker_product_rule` (3) の具体版 `kronecker_product_rule_mulVec`・証明の準備の具体版 `sum_over_multi_index_of_product_eq_product_of_sums`（`ClaimKroneckerProductRuleOnVectors.lean`）、必要十分版 `NecSuf/KroneckerProductRuleOnVectors.lean` とその特殊化を置いた。次は (r3b2e3c2c3)（人手 `def_sector_rayleigh_sup` の `𝓕^{(+)} ∩ ℝ^{2^{M_col}}` を `{x | ε_ℝx = x}` と述べ直し、`x^{(+)}` を実数の側で定める。Lean の `evenUnit`・`epsilonR_mulVec_evenUnit` を人手と 1 対 1 にする）。
2026-11-06: Lean の通しの証明のゴールラインの確認の二百十八個目として、状態台帳の (r3b2e3c2c) を (r3b2e3c2c1)〜(r3b2e3c2c3) に割り、(r3b2e3c2c1) を行った。人手に主張 `real_inclusion_preserves_finite_product`（`Π_j(r_j)_ℂ = (Π_j r_j)_ℂ`）を足した（SageMath PASS、Lean 具体版 `ClaimRealInclusionPreservesFiniteProduct.lean`、必要十分版 `NecSuf/MultiplicativeMapOfFiniteProduct.lean`）。次は (r3b2e3c2c2)（Lean に数ベクトルのクロネッカー積と `kronecker_product_rule` (3) の具体版を置く）。
2026-11-06: Lean の通しの証明のゴールラインの確認の二百十七個目として、状態台帳の (r3b2e3c2b) を行った。人手に定義 `def_epsilon_real`（`ε_ℝ := ϱ(ε)`）と主張 `epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors`（`ε_ℝx = x ⟺ ι(x) ∈ 𝓕^{(+)}`）を足し、`epsilon_is_real_symmetric` を `def_sector_rayleigh_sup` の前へ移した（SageMath PASS、Lean 具体版 `ClaimEpsilonRealFixedVectorIffInclusionInEvenEigenvectors.lean`、`epsilonR = ε_ℝ` の橋も置いた）。次は (r3b2e3c2c)（`def_sector_rayleigh_sup` の `𝓕^{(+)} ∩ ℝ^n` を `{x | ε_ℝx = x}` と述べ直す）。
2026-11-06: Lean の通しの証明のゴールラインの確認の二百十六個目として、状態台帳の (r3b2e3c2) を (r3b2e3c2a)〜(r3b2e3c2c) に割り、(r3b2e3c2a) を行った。人手に定義 `def_real_vector_inclusion`（`ι^n_{ℝ→ℂ}`）と主張 `real_vector_inclusion_is_injective`・`real_vector_inclusion_intertwines_matrix_vector_product` を足した（SageMath PASS、Lean 具体版 `ClaimRealVectorInclusion.lean`、`cvec` をそこへ移した）。次は (r3b2e3c2b)（`ε_ℝ := ϱ(ε)` と `ε_ℝx = x ⟺ ι(x) ∈ 𝓕^{(+)}`）。
2026-11-06: Lean の通しの証明のゴールラインの確認の二百十五個目として、状態台帳の (r3b2e3c) を (r3b2e3c1)〜(r3b2e3c5) に割り、(r3b2e3c1) を行った。人手 `def_sector_rayleigh_sup` の `𝓡_+` の値を `W_ℝ` の実数の二次形式 `x^⊤W_ℝx`（`def_real_bilinear_value`）にし、`c_plus_le_c` の `𝓡_+ ⊆ 𝓡` を値の包含で述べ直した（値・主張は不変）。Lean は注記だけ（証明は元から同じ式で 1 対 1）。SageMath は overview と prelude の式だけ。次は (r3b2e3c2)（`𝓕^{(+)} ∩ ℝ^n` の同一視を `ε_ℝ := ϱ(ε)` で述べ直す）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百十四個目として、状態台帳の (r3b2e3b) を行った。人手 `rayleigh_bounds_operator_norm` の行列とベクトルの積を `def_real_matrix_vector_product` にそろえ、`k = 0` と帰納法の段の根拠を新しく足した主張 `real_identity_matrix_is_left_unit_of_real_matrix_vector_product`・`real_matrix_vector_product_is_associative`（`002_linear_space_general.ts`）に替えた（値は不変）。SageMath の検算 2 件を足し PASS。Lean は 2 主張の具体版（`ClaimRealMatrixVectorProductAssociativityAndIdentity.lean`）と `finite_sum_of_real_scalar_multiples_fintype` を置き、`rayleigh_bounds_operator_norm_pow` の mathlib の `one_mulVec`・`mulVec_mulVec` を替えた。通しの定理の型は不変。次は (r3b2e3c)。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百十三個目として、状態台帳の (r3b2e3) を (r3b2e3a)〜(r3b2e3d) に割り、(r3b2e3a) を行った。人手 `partition_function_via_transfer_matrix`・`Z_equals_trace_of_W` ほかの `Z(K_1,K_2) = tr(…)`（ℝ の元と ℂ の元の等号）を `(Z(K_1,K_2))_ℂ = tr(…)` にし、`partition_function_sandwich` を準備 `(Z)_ℂ = tr(W^{N_row}) = T_ℂ` と単射性で `Z = T` を示してから `trace_power_sandwich` を当てる形に書き直した（不等号は ℝ の順序）。`c(M_col)` の式を `W_ℝ` にした。Lean は注記と ch011 の対応表だけ（証明は元から人手と 1 対 1）。SageMath `check/partition_function_sandwich/` を足した（PASS）。次は (r3b2e3b)（`rayleigh_bounds_operator_norm` の積を `def_real_matrix_vector_product` にそろえる）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百十二個目として、状態台帳の (r3b2e2) を行った。人手 `trace_power_sandwich` を `W_ℝ` の冪で書き直し、主張を `c^n ≤ Σ_k ((W_ℝ)^n)_kk ≤ 2^{M_col}c^n` にした（`tr(W^n)` はその `r_ℂ`。値は不変）。`(W_ℝ)^1 = W_ℝ` と成分の対称性を ϱ で運ぶ鎖にし、`moment_log_convexity`・`trace_power_upper_bound` の新しい形を引いた。SageMath に `check_varrho_lines` を足した（PASS）。Lean は注記と ch011 の対応表だけ直した（主張は不変、1 対 1 は (r5)・(r6)）。次は (r3b2e3)（`partition_function_sandwich` を `trace_of_W_power_via_W_real` で新しい主張につなぐ）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百十一個目として、状態台帳の (r3b2e) を (r3b2e1)〜(r3b2e3) に割り、(r3b2e1) を行った。人手 `moment_log_convexity` を `W_ℝ` の冪で書き直し、主張を `m_k := x^⊤(W_ℝ)^kx` にした（不等式は不変）。冪の分け方と `(W_ℝ)^{a+1} = W_ℝ(W_ℝ)^a` を ϱ で運ぶ鎖にし、`u^(a+1) = W_ℝu^(a)` を成分の鎖にした。SageMath に ϱ の行の検算を足した（PASS）。Lean は注記と対応表だけ直した（1 対 1 の具体版は (r6)）。通しの定理の型は不変。次は (r3b2e2)（`trace_power_sandwich` を `W_ℝ` で書き直す。いまは `moment_log_convexity` を旧い形で引いていて食い違っている）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百十個目として、状態台帳の (r3b2d) を行った。人手 `trace_power_upper_bound` を `W_ℝ` の冪で書き直し、主張を `Σ_k ((W_ℝ)^n)_kk ≤ 2^{M_col}c^n` にした（`tr(W^n)` はその `r_ℂ`。`trace_of_W_power_via_W_real`）。冪の対称性と指数法則を ϱ で運ぶ鎖にし、定義 `def_real_matrix_vector_product` を足した。SageMath に ϱ の行の検算を足した（PASS）。Lean は注記と対応表だけ直した（`trace_pow_le` を 1 対 1 にするのは (r5)）。通しの定理の型は不変。次は (r3b2e)（`trace_power_sandwich`・`partition_function_sandwich` ほかを `W_ℝ` で書き直す。`rayleigh_bounds_operator_norm` の積も `def_real_matrix_vector_product` にそろえる）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百九個目として、状態台帳の (r3b2c) を行った。人手に定義 `def_real_matrix_product`（実数の行列の積。式は `mat_mult` と同じで和が実数の有限和）と `def_real_identity_matrix`（実数の単位行列）、主張 `real_matrix_of_real_entry_matrix_preserves_product`（`(AB)_ℝ = A_ℝB_ℝ`、6 行の鎖と単射性）・`real_matrix_of_real_entry_matrix_preserves_power`（`A^q` の成分は実数で `(A^q)_ℝ = (A_ℝ)^q`、`q` の帰納法）を `002_linear_space_general.ts` に、主張 `trace_of_W_power_via_W_real`（`tr(W^q) = (Σ_k ((W_ℝ)^q)_kk)_ℂ`、4 行の鎖）を `thermodynamic_limit_row_limit_and_max_eigenvalue.ts`（`def_rayleigh_sup` の直前）に足した。`def_exp` の冒頭を、`K = ℂ` なら `mat_mult`・`def_identity_matrix`、`K = ℝ` なら新しい 2 つの定義を使うと書き直した。Lean は `MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealMatrixOfRealEntryMatrixPreservesProductAndPower.lean`（`realMatrixOfRealEntries_congr`・`real_matrix_of_real_entry_matrix_preserves_product`・`identity_matrix_entry_eq_real_identity_entry`・`identity_matrix_hasRealEntries`・`matrix_pow_hasRealEntries`・`real_matrix_of_real_entry_matrix_preserves_power`。必要十分版は置かない）と、`PhysicalPartitionFunctionSandwich.lean` の `trace_of_W_power_via_W_real`。`Matrix.map_pow` と `simp` で閉じていた `partitionFunction_eq_trace_physicalSymTransferR_pow` を、`partition_function_eq_trace_physicalSymTransferC`・`trace_of_W_power_via_W_real`・`physicalSymTransferR_eq_realMatrixOfRealEntries` の鎖と `inclusion_rr_to_cc_is_injective` に書き直した（仮定 `0 < K2` を足した。使う側の `partition_function_sandwich_physical` は元から持つ）。SageMath `sagemath/check/real_matrix_of_real_entry_matrix_preserves_product/`・`real_matrix_of_real_entry_matrix_preserves_power/`・`trace_of_W_power_via_W_real/`（PASS）。通しの定理の型は不変。`check-no-sorry.sh` の対象に、二百七個目で消した `realQuadForm_pos_of_map_posDef` の名前が残っていてスクリプトが失敗していたので、その行を消した。レビューの必須の指摘 3 件（実数の行列の積と単位行列を主張の中で定めていた、鎖の 3 行目の根拠がラベル参照でない、`trace_of_W_power_via_W_real` の主張に冪の主張の当てはめが混ざっていた）と任意の 4 件を直した。残した任意の指摘: (1) `W^q` の成分の実性を `power_of_real_symmetric_complex_matrix_is_real_symmetric` と `real_matrix_of_real_entry_matrix_preserves_power` の 2 つが示している（(r3b2d) でどちらを引くか統一する）。(2) `rayleigh_bounds_operator_norm` は `W_ℝ` の積に `mat_mult`・`identity_matrix_is_left_unit_of_mat_mult`・`mat_mult_associative` を引いている。実数の行列の結合則と左単位の主張がまだ無いので、(r3b2d)・(r3b2e) で `W_ℝ` の段を書き直すときに `def_real_matrix_product` で足して引く。次は (r3b2d)。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百八個目として、状態台帳の (r3b2b) を行った。人手 `rayleigh_bounds_operator_norm` を `W_ℝ`（`def_W_real`）で書き直し、`psd_cauchy_schwarz` の仮定を `W_real_is_symmetric` と新しい主張 `W_real_is_positive_semidefinite`（`u = 0` は 5 行の鎖）で満たした。最後の段を `nonnegative_real_order_from_squares` の参照にした。Lean の具体版 `rayleigh_bounds_operator_norm`・`_pow` を、必要十分版の特殊化から人手の鎖と同じ順の証明に書き直し（必要十分版からの導出は `_of_necSuf` に残した）、`W_real_is_positive_semidefinite` を足した。必要十分版の帰納法を人手の順にした。SageMath の検算 2 件（PASS）。レビューの必須 1 件・任意 4 件を直した。通しの定理の型は不変。次は (r3b2c)（`ϱ` が積と冪を保つ主張と `tr(W^n) = (tr((W_ℝ)^n))_ℂ`）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百七個目として、状態台帳の (r3b2) を (r3b2a)〜(r3b2e) に割り、(r3b2a) を行った。人手 `def_rayleigh_sup` の中で定めていた `W_ℝ := ϱ(W)` を独立の定義 `def_W_real` に切り出し、`psd_cauchy_schwarz` を `W` に当てるときに要る `W_ℝ` の対称性（`W_real_is_symmetric`）と正定値性（`W_real_is_positive_definite`。複素行列 `W` の正定値性から `ξ_k := (x_k)_ℂ` の 10 行の鎖で移す）を主張として足した。`def_rayleigh_sup` の `𝓡 ⊆ ℝ_{>0}`・`c(M_col) > 0` の根拠を鎖で書き、Lean の `rayleighSup_pos` をその鎖に合わせた。Lean は `PhysicalPartitionFunctionSandwich.lean` の `W_real_entry_symm`・`W_real_is_symmetric`・`conjugate_bilinear_value_of_real_vector_W`・`W_real_is_positive_definite`（`physicalSymTransferR_isSymm`・`physicalSymTransferR_posDef` はその読み替え）。`conjugateBilinearValue` の添字を有限集合へ一般化した。SageMath の検算 3 件（PASS）。レビューの必須 2 件・任意を直した。通しの定理の型は不変。次は (r3b2b)（`rayleigh_bounds_operator_norm` を `W_ℝ` で）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百六個目として、状態台帳の (r3b) を (r3b1)〜(r3b3) に割り、(r3b1) を行った。人手 `def_rayleigh_sup` の「`W` は実行列とみなせる」（同一視）を、新しく足した主張 `inclusion_rr_to_cc_is_injective` と定義 `def_real_matrix_of_real_entry_matrix`（成分がすべて実数の複素行列から実数の行列への写像 `ϱ`、略記 `B_ℝ`）による `W_ℝ := ϱ(W)` に替え、ブロックの中の `W` を `W_ℝ` にした。Lean は `DefinitionRealMatrixOfRealEntryMatrix.lean` と `physicalSymTransferR_eq_realMatrixOfRealEntries`・`rayleighSup_physicalSymTransferR_eq`（具体的な `W` の実成分の表示が `ϱ(physicalSymTransferC)` に等しい）。SageMath の検算 2 件を足した（PASS）。通しの定理の型は不変。レビューの必須の指摘は無し、任意 3 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r3b2)（このブロックを引くほかのブロックの `x^⊤Wx` を `W_ℝ` で書き直す）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百五個目として、状態台帳の (r3a2) を行った。人手 `def_rayleigh_sup` の `x^⊤Wx ≤ ΣΣ|W_ij|` の鎖の名前だけの根拠を、新しく足した定義 `def_real_absolute_value` と主張 7 つ（実数の絶対値との大小 2 つ・0 以下の実数の絶対値・三角不等式・積の絶対値・有限和の三角不等式・有限和の項ごとの大小）の参照にした（SageMath の検算 8 件を足した。全 PASS）。Lean は具体版・必要十分版・導出を足し、`rayleighSet_bddAbove` を人手と同じ上界の鎖にして `W` への仮定を外し、使わなくなった対称性・半正定値性の仮定を呼び出し側から連鎖的に外した。通しの定理の型は不変。次は (r3b)（「`W` は実行列とみなせる」を名前の付いた写像に替える）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百四個目として、状態台帳の (r3) を (r3a1)〜(r3c) に割り、(r3a1) を行った。人手 `def_rayleigh_sup` の `‖x‖ = 1` から `|x_i| ≤ 1` を出す鎖の名前だけの根拠を、`finite_sum_of_nonnegative_reals_is_at_least_each_term`・`definition_of_sqrt_r_positive`・`def_matrix_norm`・`nonnegative_real_order_from_squares` の参照にし、根号の中身の非負性を鎖の前に書いた。Lean は `DefinitionRayleighSup.lean` に同じ段の `abs_component_le_one_of_unit` を置き、`nonnegative_real_order_from_squares` の具体版（`MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimNonnegativeRealOrderFromSquares.lean`）・必要十分版（`NecSuf/NonnegativeOrderFromSquares.lean`）・導出、`finite_sum_of_nonnegative_reals_ge_term_fintype` を足した。通しの定理の型・SageMath は不変。レビューの必須 3 件・任意 5 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r3a2)（`|x^⊤Wx| ≤ ΣΣ|W_ij|` の鎖と `rayleighSet_bddAbove` の書き直し）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百三個目として、状態台帳の (r2e) を行った。人手 `W_is_real_symmetric_positive_definite` Step 3 の `W` の鎖の「スカラー倍と行列積の結合則」を `scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_factors_out_of_left_factor` を引く 2 行に割り（4 行 → 5 行）、Lean の `physicalSymTransferC_eq_smul_congruence` を同じ 5 段（`mul_smul_matrix_tensorPow`・`smul_mul_matrix_tensorPow`）にし、SageMath の鎖を合わせた（PASS）。通しの定理の型は不変。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。(r2) は済んだ。次は (r3)（`def_rayleigh_sup`）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百二個目として、状態台帳の (r2d) を行った。人手 `W_is_real_symmetric_positive_definite` の可逆性の段（`BB' = I` の 3 行、`B ∈ R^×`、`BV_2 ∈ R^×`、`W ∈ R^×` の 2 行）を `PhysicalPartitionFunctionSandwich.lean` の `physicalV1halfC_mul_physicalV1halfInvC`・`physicalV1halfC_isUnit`・`physicalV1halfC_mul_V2_isUnit`・`physicalSymTransferC_isUnit` として置いた。人手 `def_invertible_elements_of_R` (ii) の具体版（`DefinitionInvertibleElementsProduct.lean`）・必要十分版（`NecSuf/InvertibleElementsProduct.lean`）・導出と `TensorPow M` の系（`DefinitionInvertibleElementsProductFromNecSuf.lean`）を足した。check-no-sorry の対象に 13 個を足した（プライム付きの名前は二重引用符で囲む。囲まないと bash の配列が壊れて検査が落ちる）。通しの定理の型・本文・SageMath は不変。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2e)（Step 3 の「スカラー倍と行列積の結合則」を参照に替える）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百一個目として、状態台帳の (r2c3) を行った。人手 `W_is_real_symmetric_positive_definite` の Step 3 の転置の鎖を、`V_2^⊤ = V_2` の 4 行と `W^⊤` の 7 行（`transpose_of_matrix_product` を 2 回、`B^⊤ = B`、`V_2^⊤ = V_2`、`mat_mult_associative`）に書き直し、主張の「`W` の成分は実」を示す段（`real_scalar_multiple_of_real_entry_matrix_has_real_entries`、`product_of_real_entry_matrices_has_real_entries` を 2 回）を足した。Step 1 の `S_2` の実対称性と Step 3 冒頭の `V_2 = cA` の根拠を直した。Lean は具体的な `W` の `physicalSymTransferC_transpose`（7 段）・`physicalSymTransferC_isRealSymmetric` を置き、`physicalSymTransferR_isSymm` をそこから読む形に、`symTransfer_isSymm` を同じ 7 段にした。使われない `physicalV1halfR_isSymm`・`physicalV2R_isSymm` を消した。SageMath の検算を新しい行に合わせた（PASS）。通しの定理の型は不変。レビューの必須の指摘は無く、任意 6 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r2d)（`W` の可逆性）。

2026-11-06: Lean の通しの証明のゴールラインの確認の二百個目として、状態台帳の (r2c2e) を行った。`ClaimVPlusRealEntries.lean` の独自の `HasRealEntries` を消し、人手の定義 `MatrixHasRealEntries`・`MatrixIsRealSymmetric` の上で組み直した（人手 `iH_is_real_symmetric` の結論の Lean `S1plus_isRealSymmetric`・`S2_isRealSymmetric` を足し、`exp_of_real_symmetric_is_real_symmetric`・`real_smul_hasRealEntries`・`matrix_mul_hasRealEntries` を引く）。使われなくなった `entries_real_of_isHermitian_of_transpose` を消した。人手 `c_plus_equals_Lambda_half_integer` は 11-05 の書き直しで「`V^{(+)}` の成分は実」を使わなくなっており、Lean の `TheoremCPlusEqualsLambda.lean` は書き直し前の経路のままで 1 対 1 でないことを台帳に記録した。通しの定理の型・本文・SageMath は不変。レビューの必須 3 件・任意 4 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2c3)（`W^⊤ = W` の鎖）。

2026-11-06: Lean の通しの証明のゴールラインの確認の百九十九個目として、状態台帳の (r2c2d) を行った。`PhysicalPartitionFunctionSandwich.lean` の `physicalV1halfC_transpose`・`V2_transpose` を mathlib の `Matrix.exp_transpose` から人手の段（`½K_1D` の実対称性の 3 行の鎖、`exp_of_real_symmetric_is_real_symmetric` の具体版を `A → ½K_1D`・`A → S_2` で、`V_2^⊤` は `transpose_smul_tensorPow` の 4 段）へ書き直した。`S_2` の実対称性を `S2C_isRealSymmetric` にまとめ `expS2C_posDef` もそれ経由にした。通しの定理の型・本文・SageMath は不変。レビューの必須の指摘は無く、任意の 6 件（2 回のレビュー）を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2c2e)（`ClaimVPlusRealEntries.lean` の独自の `HasRealEntries` を人手の定義へ寄せる）。

2026-11-06: Lean の通しの証明のゴールラインの確認の百九十八個目として、状態台帳の (r2c2c3) を行った。人手 `exp_of_real_symmetric_is_real_symmetric` の Lean 具体版（`ClaimExpOfRealSymmetricIsRealSymmetric.lean`、`TensorPow M`。人手の 4 行と結論の適用と 1 対 1）を置いた。既存の主張を並べるだけなので必要十分版は置かない。`check-no-sorry.sh` の対象に、この定理と、百九十六個目の `exp_of_hermitian_is_hermitian` の具体版・導出・必要十分版の定理 20 個（入っていなかった）を足した。通しの定理の型は不変。レビューの必須の指摘は無く、任意の 1 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2c2d)（`physicalV1halfC_transpose`・`V2_transpose` の書き直し）。

2026-11-06: Lean の通しの証明のゴールラインの確認の百九十七個目として、状態台帳の (r2c2c2c) を行った。mathlib の `Matrix.IsHermitian.exp` を使っていた 5 か所を、人手 `exp_of_hermitian_is_hermitian` の具体版 `matExp_conjTranspose_of_conjTranspose_eq` に替えた（`posDef_exp_of_isHermitian` の `T^* = T`。主張は `TensorPow M` に狭めた）。`Vmat_posDef`・`VPlus_posDef`・`VPlusInv_posDef` の `B^* = B` は人手どおり `posDef_exp_of_isHermitian` の正定値性から読む形にした。`matExp_hasRealEntries` の転置の側も `matExp_transpose_of_transpose_eq` に替えた。通しの定理の型は不変。レビューの必須 1 件・任意 4 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2c2c3)（`exp_of_real_symmetric_is_real_symmetric` の Lean 具体版）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百九十六個目として、状態台帳の (r2c2c2b) を行った。人手 `exp_of_hermitian_is_hermitian` の Lean 具体版 `matExp_conjTranspose_of_conjTranspose_eq`（`ClaimExpOfHermitianIsHermitian.lean`、`TensorPow M`。冒頭の `I^* = I` は `identity_matrix_is_positive_definite` のエルミート性の 5 行、`(S^m)^* = S^m` の 3 行・6 行、部分和の成分の 8 行、極限の段と 1 対 1）、必要十分版 `NecSuf/SeriesOfHermitianIsHermitian.lean`（共役は `Star` だけ、複素共役の性質は仮定。交換律と `hc` は反例つきで削れない）、導出 `ClaimExpOfHermitianIsHermitianFromNecSuf.lean` を置いた。通しの定理の型は不変。レビューの必須の指摘は無く、任意の 4 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2c2c2c)（使う側の `Matrix.IsHermitian.exp` の置き換え）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百九十五個目として、状態台帳の (r2c2c2) を (r2c2c2a)〜(r2c2c2c) に割り、(r2c2c2a) を行った。人手 `star_preserves_norm_and_limits` の (1) 第 1 式・第 2 式・(2)・(3) の Lean 具体版（`ClaimStarPreservesNormAndLimits.lean`。人手の 7・8・5・5＋2 行と 1 対 1）、必要十分版 `NecSuf/StarPreservesNormAndLimits.lean`（共役は `Star` だけ、複素共役の性質は仮定。第 1 式は交換律が要る）、導出と `TensorPow M` の系 `conjTranspose_mul_tensorPow`・`conjTranspose_tendsto_tensorPow` を置いた。`congruence_isHermitian` と `ClaimPositiveDefinite.lean` の補助の `Matrix.conjTranspose_mul` を新しい具体版へ替えた。通しの定理の型は不変。レビューの必須 1 件・任意 3 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2c2c2b)（`exp_of_hermitian_is_hermitian` の Lean 具体版）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百九十四個目として、状態台帳の (r2c2c) を (r2c2c1)〜(r2c2c3) に割り、(r2c2c1) を行った。人手 `hermitian_and_transpose_invariant_matrix_is_real_symmetric`（`A^* = A` かつ `A^⊤ = A` なら実対称）と `exp_of_real_symmetric_is_real_symmetric` を `009_eigenvalues_of_V.ts` に足し、`W_is_real_symmetric_positive_definite` の Step 2 の散文（実対称行列の冪・部分和・極限）を新しい主張の `A → ½K_1D`・`A → S_2` の適用に書き直した。SageMath は検算フォルダ 2 つを足し、W の検算の Step 2 を合わせた。Lean は 1 つ目の主張の具体版・必要十分版（係数は `Star R` だけ）・導出を置いた。2 つ目の主張の Lean は、引く `exp_of_hermitian_is_hermitian` に Lean の具体版が無い（mathlib の `Matrix.IsHermitian.exp` 等に委ねている）ので、(r2c2c2) でそれを置いてから (r2c2c3) で置く。レビューの必須の指摘は無く、任意の指摘 4 件を直した。npm run check・verify-check-linkage・verify-every-proof-has-check・lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2c2c2)。

2026-11-05: Lean の通しの証明のゴールラインの確認の百九十三個目として、状態台帳の (r2c2b) を行った。人手 `exp_of_symmetric_is_symmetric`（`S^⊤ = S` なら `exp(S)^⊤ = exp(S)`。`exp_of_hermitian_is_hermitian` と同じ手順。`I^⊤ = I` は証明の冒頭の成分の鎖）を `009_eigenvalues_of_V.ts` に足し、SageMath `sagemath/check/exp_of_symmetric_is_symmetric/`、Lean 具体版 `matExp_transpose_of_transpose_eq`（`ClaimExpOfSymmetricIsSymmetric.lean`、`TensorPow M`）、必要十分版 `NecSuf/SeriesOfSymmetricIsSymmetric.lean`、導出、系 `transpose_tendsto_tensorPow` を置いた。前回の検算フォルダ `transpose_preserves_matrix_norm_and_limits` は、`verify-every-proof-has-check.ts` が overview の最初の対象ラベルしか読まないので `transpose_preserves_matrix_norm/`・`transpose_preserves_matrix_limits/` に分けた。通しの定理の型は不変。レビューの必須の指摘 1 件と任意の指摘 6 件を直した。次は (r2c2c)（人手「エルミートかつ転置で不変な複素行列は実対称」と `exp_of_real_symmetric_is_real_symmetric`、Step 2 の散文の書き直し）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百九十二個目として、状態台帳の (r2c2)（人手 `W_is_real_symmetric_positive_definite` の Step 2 の `B = exp(½K_1D)`・`A = exp(S_2)` の実対称性）を (r2c2a)〜(r2c2d) に割り、(r2c2a) を行った。人手に `transpose_preserves_matrix_norm`（`‖A^⊤‖ = ‖A‖`）と `transpose_preserves_matrix_limits`（`A_N → A` なら `A_N^⊤ → A^⊤`）を `009_eigenvalues_of_V.ts` の `star_preserves_norm_and_limits` の直後に足し、SageMath `sagemath/check/transpose_preserves_matrix_norm_and_limits/`、Lean の具体版 `matrix_transpose_norm`・`matrix_transpose_tendsto`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimTransposePreservesMatrixNormAndLimits.lean`）、必要十分版 `NecSuf/TransposePreservesMatrixNormAndLimits.lean`、導出を置いた。Step 2 は「実対称 ⟺ エルミートかつ転置で不変」の経路で主張にする方針（台帳）。`check-no-sorry.sh` に残っていた消えた定理名 `sigmaZ_mul_sigmaZ_transpose` を直した（検査が落ちていた）。次は (r2c2b)。

2026-11-05: Lean の通しの証明のゴールラインの確認の百九十一個目として、状態台帳の (r2c1b2b) を行った。人手 `W_is_real_symmetric_positive_definite` の Step 1 の `K_1D` の実対称性の Lean（`PhysicalPartitionFunctionSandwich.lean`）を、人手の鎖と 1 対 1 の `sigmaZ_transpose`・`sigmaZ_nextSite_mul_comm`・`sigmaZ_mul_sigmaZ_nextSite_transpose`・`K1D_transpose_succ`・`sigmaZ_hasRealEntries`・`K1D_hasRealEntries_succ` に書き直した（`D` の対角表示と `Matrix.diagonal_transpose` による旧証明を消した。`M = 0` は空和の補助）。`halfK1D_transpose` は `K1D_transpose` から得る形にした。通しの定理の型・本文・SageMath は不変。レビューの必須の指摘は無く、任意の指摘 5 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2c2)（Step 2 の `B`・`A` の実対称性を主張として立てる）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百九十個目として、状態台帳の (r2c1b2) を (r2c1b2a)・(r2c1b2b) に割り、(r2c1b2a) を行った。人手 `W_is_real_symmetric_positive_definite` の Step 1 の `K_1D` の実対称性を、散文から鎖（準備の `m^+` と可換性、`(σ^z_k)^⊤` の 5 行、`(σ^z_mσ^z_{m+1})^⊤` の 5 行（周期端を含む）、`(K_1D)^⊤` の 5 行、成分の実性の 2 段落）に書き直し、SageMath `check_step1_K1D_transpose_and_real_entries.sage`（`M_col = 1..6`、288 段 PASS、否定コントロール 18 件）を足した。Lean・通しの定理の型は不変。レビューの必須の指摘は無く、任意の指摘 3 件を直した。npm run check・verify-check-linkage・lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2c1b2b)（Lean を新しい鎖と 1 対 1 にする）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百八十九個目として、状態台帳の (r2c1b) を (r2c1b1)・(r2c1b2) に割り、(r2c1b1) を行った。(r2c1b) の鎖が引く人手 `product_of_real_entry_matrices_has_real_entries` に Lean が無かったので、具体版 `ClaimProductOfRealEntryMatricesHasRealEntries.lean`（`matrix_mul_hasRealEntries`、人手の 4 行の鎖と 1 対 1）、必要十分版 `NecSuf/ProductOfClosedEntries.lean`（`mul_entries_mem`。積・和で閉じることと和の添字が空でないこと）、導出 `ClaimProductOfRealEntryMatricesFromNecSuf.lean` を置いた。通しの定理の型は不変。本文と SageMath は不変。レビューの必須の指摘は無く、任意の指摘 3 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2c1b2) `K_1D` の実対称性の鎖。

2026-11-05: Lean の通しの証明のゴールラインの確認の百八十八個目として、状態台帳の (r2c) を (r2c1a)・(r2c1b)・(r2c2)・(r2c3) に割り、(r2c1a) を行った。`W_is_real_symmetric_positive_definite` の転置の鎖が名前だけで引く「転置の積の法則」を、人手の主張 `transpose_of_matrix_product`（`(AB)^⊤ = B^⊤A^⊤`、成分の鎖 5 行、`002_linear_space_general.ts`）として足し、SageMath（`sagemath/check/transpose_of_matrix_product/`、540 段 PASS）、Lean の具体版 `ClaimTransposeOfMatrixProduct.lean`、必要十分版 `NecSuf/TransposeOfMatrixProduct.lean`（`CommMagma`・`AddCommMonoid`）、導出と `TensorPow M` の系を置いた。通しの定理の型は不変。レビューの必須の指摘は無く、任意の指摘 2 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (r2c1b) `K_1D` の実対称性の鎖。

2026-11-05: Lean の通しの証明のゴールラインの確認の百八十七個目として、(r2b2) を行った。人手 `positive_real_multiple_preserves_positive_definite` の Lean を、旧 `posDef_smul_of_pos`（mathlib の `Matrix.smul_mulVec`・`dotProduct_smul` で閉じていた）から、人手のエルミート性の段（`real_multiple_isHermitian`）と正値性の 13 行の鎖と 1 対 1 の具体版 `ClaimPositiveRealMultiplePreservesPositiveDefinite.lean` に替えた。必要十分版 `NecSuf/PositiveMultiplePreservesPositiveDefinite.lean`（`Semiring`・`Star`、仮定 `hcomm`・`hincl`、`S` の `mul_pos`）と、導出・`TensorPow M` の系（`...FromNecSuf.lean`）を置き、呼び出し側 3 ファイルを差し替えた。通しの定理の型は不変。本文と SageMath は不変。レビューの必須の指摘 1 件と任意の指摘 3 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2c)（`K1D_hasRealEntries` を人手 Step 1 の論法へ、`halfK1D_transpose` の重複をまとめる）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百八十六個目として、(r2b) を行った。具体的な `W` の正定値性を人手 `W_is_real_symmetric_positive_definite` の Step 1・2（`K_1D` 実対称 → エルミート → `½K_1D` エルミート → `B`・`A` 正定値、`B'B = I`）と Step 3 の 4 行の鎖 → 合同変換 → 正の実数倍の順で係数 `ℂ` の `W` について示し（`physicalSymTransferC_posDef`）、実ベクトルの正定値性と挟み撃ち（`Z = tr(W^{N_row})` → `trace_power_sandwich`）をそこから読む形にした。人手 `real_multiple_of_hermitian_is_hermitian` の具体版・必要十分版・導出を足した。通しの定理の型は不変。本文と SageMath は不変。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2b2)（`posDef_smul_of_pos` を人手の 13 行の鎖に）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百八十五個目として、状態台帳の (r2) `W_is_real_symmetric_positive_definite` を (r2a)〜(r2d) に割り、(r2a) を行った。人手 `congruence_preserves_positive_definite`・`conjugate_bilinear_value_of_congruence` の具体版（`ClaimCongruencePreservesPositiveDefinite.lean`、各鎖と 1 対 1）、必要十分版（`NecSuf/CongruencePreservesPositiveDefinite.lean`）、特殊化と `TensorPow M` の系を置いた。通しの定理の型は不変（check-end-to-end は通る）。本文と SageMath は不変。次は (r2b)（`W` の正定値性を人手 Step 3 の順で）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百八十四個目として、台帳の「次は (d)」が済んだ項目（`sign_flip_conjugation` Step 3、五十七〜五十九個目）の古い記述だったことを確かめ、`thermodynamic_limit_row_limit_and_max_eigenvalue.ts` を洗い出して (r1)〜(r10) に割り、(r1) `Z_equals_trace_of_W` を行った。具体版を係数 `ℂ` の行列で人手の準備 2・準備 3・本体と同じ段の calc にし（`open_product_pow`・`symmetrized_pow_succ`・`trace_mul_pow_eq_trace_symmetrized_pow`）、具体的な `Z` の「とくに」`partition_function_eq_trace_physicalSymTransferC` を置き、必要十分版 `NecSuf/OpenProductPowAndCyclicTrace.lean`（モノイドと巡回的な写像）と特殊化・使う側の実行列の読み（`ClaimZEqualsTraceOfWFromNecSuf.lean`）を置いた。通しの定理の型は不変。本文と SageMath は不変。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (r2) `W_is_real_symmetric_positive_definite`。

2026-11-05: Lean の通しの証明のゴールラインの確認の百八十三個目として、`max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus` の (e) を行った。人手の (2) を兄弟の `max_eigenvector_in_even_sector` (1)・(4) と同じ一ステップ一定理の行（含意の鎖 3 行、`εQ̌ = Q̌` 3 行、`Q̌y = y` 4 行、`εy = y` 4 行）にし、SageMath の厳密版 `check_part2_chains_exact.sage`（414 件 PASS）を足し、Lean の行の注記を合わせた（証明の中身は不変）。主張と通しの定理の型は不変。次は状態台帳の (d)（`sign_flip_conjugation` Step 3）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百八十二個目として、`max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus` の (c) を行った。`ClaimMaxEigenvectorInEvenSectorViaTraceOfEpsilonVPlus.lean` の (2) を人手の行の順の鎖（`∃ s ∈ ℝ_{>0}, tr = s_ℂ` → `eta_univ_eq_one_iff_trace_pos` の `⟸` → `CheckFermi.epsilon_mul_Qproj_univ_of_eta`、前置き `Qproj_univ_mulVec_of_mem_range` と `checkFermiOf_Qproj_univ_mul_self`、最後の 3 行の calc と Lean で補った積の結合）にし、mathlib の `one_smul` と必要十分版の特殊化 `CheckFermi.Qproj_mul_self` をこのファイルから外した。主張と通しの定理の型は不変。本文と SageMath は不変。レビューの必須の指摘なし、任意の指摘 4 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (e) 人手のこの主張の (2) を一ステップ一定理に揃える。

2026-11-05: Lean の通しの証明のゴールラインの確認の百八十一個目として、`max_eigenvector_in_even_sector` の (b) 固有空間の言い換えを行った。具体的な `ψ̌` の `CheckFermi` と `CheckFermiSetup` の `Q̌_ε` が同じ行列であること（`checkFermiOf_Qproj_eq`、運ぶ段）を示し、`max_eigenvalue_of_V_plus_simple` (3) の集合の等号 `eigenspace_VPlus_max_eq_range_Qproj_univ`（一般）と `_checkFermiSetupOf`（具体）、言い換えの 2 行 `eigenspace_VPlus_max_subset_evenSector` を置いて主張に足した。(4) の冪等性は人手と 1 対 1 の `CheckFermiSetup.Qproj_mul_self` から運んだ `checkFermiOf_Qproj_univ_mul_self` に替えた。主張は強めただけで通しの定理の型は不変。本文と SageMath は不変。レビューの必須の指摘 1 件と任意の指摘 8 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (c) `ClaimMaxEigenvectorInEvenSectorViaTraceOfEpsilonVPlus.lean` の (2) の鎖を (a) の補題へ替える。

2026-11-05: Lean の通しの証明のゴールラインの確認の百八十個目として、`max_eigenvector_in_even_sector` の Lean を人手の鎖に揃える作業を (a)〜(c) に割り、(a) を行った。`TheoremMaxEigenvectorInEvenSector.lean` に準備 (P1) `neg_one_pow_mul_neg_one_pow`・(P2) `card_le_of_finset`、(2)〜(4) の鎖を `CheckFermi` の上の人手と 1 対 1 の calc（`eta_eq_neg_one_pow_sub_card`・`eta_eq_neg_one_pow_add_card`・`epsilon_mul_Qproj_eq_neg_one_pow_add_card`・`epsilon_eq_neg_one_pow_smul_parityProd`・`epsilon_mul_Qproj_univ_of_eta`・`Qproj_univ_mulVec_of_mem_range`・`epsilon_mulVec_of_mem_range_univ`）で置き、(1) を具体的な `V^{(+)}` の 3 行の含意 `vPlusDataOf_eta_univ_eq_one`、主張 (1)〜(4) を `max_eigenvector_in_even_sector` にした。主張と通しの定理の型は不変。本文と SageMath は不変。レビューの必須の指摘 1 件と任意の指摘 4 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (b) 固有空間の言い換え（`CheckFermiSetup` と `CheckFermi` の接続から）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百七十九個目として、(iii-c) 開鎖のスピン和の必要十分版 `NecSuf/OpenChainSpinSum.lean` を新しい具体版と同じ手順（`Φ`・`ς` による付け替え、二項の和の有限積の展開、`M_col = 2`・`M_col ≥ 3` の鎖）に書き直し、導出 `ClaimOpenChainSpinSumsFromNecSuf.lean` を具体版と同じ行の順の calc にし、旧い形の `OpenChainBond`・`openChainChange` 系・`prevSite` 系と旧い必要十分版を消した。(iii) を終えた。主張と通しの定理の型は不変。本文と SageMath は不変。レビューの必須の指摘 1 件（`check-no-sorry.sh` の `'` を含む名前の引用）と任意の指摘 8 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は `max_eigenvector_in_even_sector` の Lean を人手の鎖に揃える。

# MEMORY — exact-solution-of-2d-ising-model

2026-11-05: Lean の通しの証明のゴールラインの確認の百七十八個目として、(iii-b) `open_chain_endpoint_product_sum` の Lean を人手の新しい鎖に揃えた。`ClaimOpenChainSpinSums.lean` で、Step 2 の `M_col = 2` の 3 行（`prod_bondSpin_of_two`）・`M_col ≥ 3` の 4 行（`prod_bondSpin_of_ge_three`、可換性と結合性の段は `prod_bondSpin_rearrange`）・端点の積の 4 行（`endpoint_mul_exp_openChainEnergy_eq_prod`）・最後の 12 行（`open_chain_endpoint_product_sum`）を 1 対 1 の calc にし、旧い `prod_openChainBondSpin` を消した。主張と通しの定理の型は不変。本文と SageMath は不変。レビューの必須の指摘は無く、任意の指摘 4 件を直した。次は (iii-c) 必要十分版と旧い補題の整理。

2026-11-05: Lean の通しの証明のゴールラインの確認の百七十七個目として、開鎖のスピン和の Lean を人手の新しい鎖に揃える作業を (iii-a) `open_chain_partition_sum`・(iii-b) `open_chain_endpoint_product_sum`・(iii-c) 必要十分版と旧い補題の整理に割り、(iii-a) を行った。`ClaimOpenChainSpinSums.lean` で、`Φ` を結合の添字 `Fin (n + 1)` の `openChainPhiEquiv`（人手の逆の手続きを `Fin.induction` で書いた逆写像つき）、`ς` を `varsigmaEquiv`・`varsigmaWordEquiv` にし、準備の鎖 3 行と本体の 10 行を 1 対 1 の calc にした（`expansion_of_finite_product_of_two_term_sums_of_real`・`real_exp_of_finite_sum`・`finite_sum_of_real_scalar_multiples`）。主張と通しの定理の型は不変。本文と SageMath は不変。レビューの必須の指摘は無く、任意の指摘 2 件を直した。次は (iii-b)。

2026-11-05: Lean の通しの証明のゴールラインの確認の百七十六個目として、`trace_of_epsilon_V_plus` の (t9)（Step 5 の実数の鎖の左辺と 8 行、「ゆえに主張の等号が成り立つ」、Step 6）を行い、(t1)〜(t9) を終えた。`ClaimTraceEpsilonVPlusClosedForm.lean` に人手の 8 行と 1 対 1 の calc `spin_sums_combination_eq_closed_form` と 4 行目の根拠の補助 `finite_sum_of_constant_real`・`finite_sum_of_negated_constant_real` を置き、`trace_epsilon_VPlusOfTransfer_closed_form` をその合成にした（旧い `ring`・`Real.exp_nat_mul`・`mul_pow` の 4 段を消した）。Step 6 を人手どおり実数の鎖の左辺の正値性から出す `closed_form_of_trace_epsilon_V_plus_pos`（具体版 `cosh_sinh_basic_properties_3`・`real_exp_positive`）にした。主張と通しの定理の型は不変。本文と SageMath は不変。レビューの必須の指摘 1 件と任意の指摘 2 件を直した。次は `open_chain_partition_sum`・`open_chain_endpoint_product_sum` の Lean の具体版を 2026-11-04 の人手の鎖に揃える。

2026-11-05: Lean の通しの証明のゴールラインの確認の百七十五個目として、`trace_of_epsilon_V_plus` の (t8)（Step 5 の二つのトレースの鎖と組み立ての 11 行）を行った。`ClaimTraceEpsilonVPlusClosedForm.lean` に `trace_matExp_openChainD0_mul_epsilon_mul_V2`・`trace_matExp_openChainD0_mul_boundaryG_mul_V2`（人手と同じ 4 段ずつ）と補助 `finite_sum_over_spinConf_of_real_scalar_multiples`（具体版 `finite_sum_of_real_scalar_multiples` を 𝔐 の上の和へ当てる）を置き、`trace_epsilon_VPlusOfTransfer_eq_spin_sums` を人手の 11 行と 1 対 1 の calc にした（右辺は人手の `(cosh K_1(exp(-K_2M_col)S_cosh) + sinh K_1(exp(K_2M_col)S_sinh))_ℂ`）。Lean で補った中間 `trace_epsilon_VPlusOfTransfer_split` を消した。本文と SageMath は不変。レビューの必須の指摘 3 件と任意の指摘 3 件を直した。次は (t9)（Step 5 の実数の鎖の 9 行と Step 6）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百七十四個目として、`trace_of_epsilon_V_plus` の (t7)（Step 4 の二つの鎖）を行った。`ClaimTraceEpsilonVPlusClosedForm.lean` の `matExp_openChainD0_mul_epsilon_mul_V2_apply_self`・`matExp_openChainD0_mul_boundaryG_mul_V2_apply_self` を、左辺を人手の `exp(κD_0)(εV_2)`・`exp(κD_0)(GV_2)`、右辺を人手の並びの実数の包含にして、人手と同じ 7 段ずつの calc にした。1・2 段目の根拠（`mat_mult`・`complex_zero_times_is_zero`・`finite_sum_with_single_nonzero_term`）を `mul_apply_configBasisIso_of_single_nonzero` に、(a) の非対角成分と `G` の対角成分を `matExp_smul_openChainD0_apply_of_ne`・`boundaryG_apply_configBasisIso_of_ne`・`boundaryG_apply_configBasisIso_self` に、(b) を列の形 `epsilon_apply_configBasisIso_col` から使う `epsilon_apply_configBasisIso_of_ne`・`epsilon_apply_configBasisIso_neg_self`（`-(-s) = s` は `negSpinConf_negSpinConf`）に置き、行の形の 1 段だった `epsilon_apply_configBasisIso`・`epsilon_mul_apply_configBasisIso`・`matExp_smul_openChainD0_mul_apply`・`boundaryG_mul_apply` を消した。(c) の `V2_apply_configBasisIso_self`・`_neg_self` の右辺を人手の `exp(K_2M_col)`・`exp(-K_2M_col)` にして人手に無い `mul_comm` の段を除いた。Step 5 の `trace_epsilon_VPlusOfTransfer_eq_spin_sums` は型を変えずに新しい形を使うよう直しただけ（(t8) で人手の順序に揃える）。本文と SageMath は不変。レビューの必須の指摘 2 件（check-no-sorry の対象に消した補題が残っていた、結合則の行の対応の誤記）と任意の指摘 6 件を直した。次は (t8)。

2026-11-05: Lean の通しの証明のゴールラインの確認の百七十三個目として、`trace_of_epsilon_V_plus` の (t6)（Step 3 (a)(b)(c)）を行った。`ClaimTraceEpsilonVPlusMatrixEntries.lean` に、(a) の成分の 4 行（`openChainD0_apply_configBasisIso`・`boundaryG_apply_configBasisIso`）、対角性の読み取り `eq_diagonal_of_apply_configBasisIso`、`κD_0` の対角成分の 2 行 `smul_openChainD0_eq_diagonal`、`exp(κD_0)` の 2 行 `matExp_smul_openChainD0_apply`、(b) の 3 行 `epsilon_apply_configBasisIso_col`、(c) の項ごとの和 `sum_negSpin_mul_self` を人手と同じ段の calc で置いた。本文と SageMath は不変。レビューの必須の指摘は無し。次は (t7)（Step 4 の二つの鎖。(b) の列の形を引く段と `exp(K_2M_col)` の並びも合わせて直す）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百七十二個目として、`trace_of_epsilon_V_plus` の (t5b5) を行った。`ClaimExtractTaylor.lean` の 4 式を、人手どおり準備 `2(K_2^*)_ℂ = (2K_2^*)_ℂ`・各項の偶奇の鎖・`exponential_series_of_even_odd_power_terms` の適用（`toFinPowAlgEquiv M` で移して戻す）の calc にし、`K_1, K_2^*` を ℝ にした（使う側の主張の引数も ℝ。通しの定理の型は不変）。別の論法だった `hasSum_extract_taylor_*` と `ClaimExtractTaylorFromNecSuf.lean` を消し、補助 `SeriesSumUnderReindexToFin.lean` を置いた。本文と SageMath は不変。未決: `ClaimTActionsOnCheckFromNecSuf.lean` の必要十分版の手順のずれほか 2 件（状態台帳）。次は (t6)。

2026-11-05: Lean の通しの証明のゴールラインの確認の百七十一個目として、`trace_of_epsilon_V_plus` の (t5b4) を行った。真ん中の鎖 `exp_epsilon_mul_boundaryG`（`ClaimTraceEpsilonVPlusReduction.lean`、型は不変）を、人手どおり `exponential_series_of_even_odd_power_terms` を引く 3 行の calc にした。添字が `Conf M` の `TensorPow M` は、名前の付いた付け替え `toFinPowAlgEquiv M` で `Fin (2^M)` 添字へ移して当て、逆写像で戻す（人手の行でない段と明記）。人手と別の論法だった `matExp_smul_of_sq_eq_one` と `ClaimTraceEpsilonVPlusReductionFromNecSuf.lean` を消し、`NecSuf/ExpOfInvolution.lean` の対応を `two_by_two_transfer_identity` だけにした。本文と SageMath は不変。次は (t5b5)（`ClaimExtractTaylor.lean` を今の人手の鎖に合わせる）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百七十個目として、`trace_of_epsilon_V_plus` の (t5b3) を行った。`ClaimExponentialSeriesOfEvenOddPowerTerms.lean` に人手 `exponential_series_of_even_odd_power_terms` の中間目標「実数の評価」（5 行 × 2）・「ノルムの評価」（8 行）・`ε` の鎖（3 行）・級数の和の最後の鎖（3 行）を人手の行と 1 対 1 の calc で置き、主張そのもの `exponential_series_of_even_odd_power_terms`（`Matrix (Fin d) (Fin d) ℂ`、Frobenius ノルム、級数の和は部分和の `limUnder`）が立った。ノルムの評価と `ε` の鎖には必要十分版 `NecSuf/EvenOddSeriesNormEstimate.lean` と導出 `ClaimExponentialSeriesOfEvenOddPowerTermsFromNecSuf.lean` を置いた。本文と SageMath は不変。次は (t5b4)（`trace_of_epsilon_V_plus` の真ん中の鎖をこの主張を `TensorPow M` へ当てる形にする）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百六十九個目として、`trace_of_epsilon_V_plus` の (t5b2) を行った。`ClaimExponentialSeriesOfEvenOddPowerTerms.lean` に人手 `exponential_series_of_even_odd_power_terms` の `S_N`・`E_N`・`α_N`・`β_N`・`L` の定義と、中間目標「部分和」（11 行）・「差」（9 行）を人手の行と 1 対 1 の calc で置いた（`evenOddPartialSum_eq`・`evenOddPartialSum_sub_limit` ほか）。本文と SageMath は不変。レビューの必須の指摘（冒頭の対応表が古い）を直した。人手の「部分和」の 8・9 行目の書き方の未決 2 件は状態台帳へ。次は (t5b3)（実数の評価・ノルムの評価・`S_N → L`）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百六十八個目として、`trace_of_epsilon_V_plus` の (t5b) を (t5b1)〜(t5b5) に割り、(t5b1) を行った。真ん中の鎖が引く人手 `exponential_series_of_even_odd_power_terms` に Lean の具体版が無かったので、`EigenvalueProblem/ReductionToATheta/ClaimExponentialSeriesOfEvenOddPowerTerms.lean` を新しく置き、準備（冪の像・`a_n, b_n` の値・実数の差の像）と中間目標「各項」を人手の行と 1 対 1 の calc にした。本文と SageMath は不変。レビューの必須の指摘は無く、任意の指摘 2 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (t5b2)（部分和と差）。
2026-11-05: 全証明の SageMath 検算として、`second_derivative_log_divergence`（G'' の対数発散）に検算 `sagemath/check/second_derivative_log_divergence/` を付け、**未検算が 0 件になり runbook のゴールラインを満たした**（ゴール台帳を達成に更新、連続実行を一時停止）。代数の行はイデアル、各点の行は AA、積分と初等関数の値はボールと Arb の積分で確かめた。人手証明を直した（主張と定数は不変）: √·^(ℝ≥0) と r・t での書き直し、T ≥ 0 の欠け、平均値の定理を使っていた κ² log(1/κ) の単調性を (R4)・(R3) の鎖に、持ち込む数値の評価の明記と注記の使い道の更新。詳細と残した項目は `docs/tasks/sagemath-every-proof-state.md`。
2026-11-05: Lean の通しの証明のゴールラインの確認の百六十七個目として、`trace_of_epsilon_V_plus` の (t5) を (t5a)（Step 2 の最初の鎖と最後の鎖）と (t5b)（`exp(κ(εG))` の鎖と必要十分版の冪の補題の手順のずれ）に割り、(t5a) を行った。`V1plus_eq_exp_openChainD0_mul_exp` を人手の 3 行と同じ 3 段、`epsilon_mul_V1plus` を人手の 11 行と同じ 11 段（印 `人手 1`〜`人手 11`）の calc にした（型は不変）。`theorem_exp_product`・`commuting_matrix_commutes_with_exp` は既存の慣行どおり `Matrix.exp_add_of_commute`・`Commute.exp_right`。本文と SageMath は不変。レビューの必須の指摘は無く、任意の指摘 2 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (t5b)。
2026-11-05: Lean の通しの証明のゴールラインの確認の百六十六個目として、`trace_of_epsilon_V_plus` の (t4) を行った。`trace_epsilon_VPlusOfTransfer`（型は不変）の calc を人手 Step 1 の 6 行と 1 対 1 の段（印 `人手 1`〜`人手 6`）にし、人手が省いた括弧の付け替え（`mul_assoc`）と `A^2 := AA` を別の段にした（`simp only [mul_assoc]` を除いた）。`trace_cyclic` が `Matrix.trace_mul_comm` の 1 行であることは状態台帳に未決として記録した。本文と SageMath は不変。レビューの必須の指摘は無く、任意の指摘 2 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (t5)
2026-11-05: Lean の通しの証明のゴールラインの確認の百六十五個目として、`trace_of_epsilon_V_plus` の (t3) を行った。準備 (P5) の基底ベクトルの成分の 3 行（`basisVec_configBasisIso_apply`）と列の読み取りの 4 行（`mulVec_basisVec_configBasisIso_apply`）を人手と同じ段の calc にし（`ClaimTraceEpsilonVPlusMatrixEntries.lean`）、`eq_diagonal_of_mulVec_basisVec` をそれ経由にした。本文と SageMath は不変。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (t4)。
2026-11-05: Lean の通しの証明のゴールラインの確認の百六十四個目として、`trace_of_epsilon_V_plus` の (t2) を行った。準備 (P3) の `(εG)^{2j} = I`・`(εG)^{2j+1} = εG` を人手の帰納法と同じ段の calc （`pow_two_mul_of_sq_eq_one`・`pow_two_mul_add_one_of_pow_two_mul_eq_one`）にし、(P4) の `(κX)^n = κ^nX^n` を帰納法 `smul_pow_tensorPow` にして、`matExp_smul_of_sq_eq_one` の mathlib の `smul_pow`・`pow_mul` を外した。必要十分版 `NecSuf/ExpOfInvolution.lean` の冪の補題の手順が具体版とずれた件は状態台帳に未決として記録した（(t5) で直す）。次は (t3)（準備 (P5)）。
2026-11-05: 全証明の SageMath 検算として、`gamma_derivatives_in_kappa`（γ(θ, κ) の κ 微分と |∂γ/∂κ| ≤ 1）に検算 `sagemath/check/gamma_derivatives_in_kappa/` を付けた（未検算 1 件）。等号の行は多項式環のイデアルと κ の導分で、合成の微分の行と導関数の値は Sage の記号微分を AA に直して厳密に比べた。人手証明を直した（主張の式は不変、計算の誤りは無し）: √·^(ℝ≥0) の記法と S ≥ 0、(1) を sinh_of_arcsinh と平方根の一意性の鎖に、(2) の S > 0 を sinh_is_injective・sinh_zero の鎖に（κ < 0 で使えない cosh_sinh_basic_properties (3) を引いていた）、sinh γ > 0 を主張に、微分の鎖を 1 行 1 公式に、(3) を sinh²γ − sinh²κ ≥ 0 と背理法の鎖に。Lean は不変。次は second_derivative_log_divergence（状態台帳の「次の一歩」）。
2026-11-05: Lean の通しの証明のゴールラインの確認の百六十三個目として、`trace_of_epsilon_V_plus` を人手の並びで九つに割り（状態台帳）、先頭の準備 (P1)・(P2) を行った。`I_mul_smul_H1plus` を (P1) の 4 行と同じ 4 段の calc にし、(P2) の `commuting_with_scalar_multiple` の 3 回の適用を 3 定理（`openChainD0_mul_smul_epsilon_mul_boundaryG`・`smul_epsilon_mul_boundaryG_mul_smul_openChainD0`・`epsilon_mul_smul_openChainD0`）にして、使う側（`V1plus_eq_exp_openChainD0_mul_exp`・`epsilon_mul_V1plus`）の mathlib の `Commute.smul_left`・`smul_right` を差し替えた。必要十分版は置かない。本文と SageMath は不変。レビューの必須の指摘は無く、任意の指摘 3 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (P3)・(P4) の冪の帰納法。
2026-11-05: Lean の通しの証明のゴールラインの確認の百六十二個目として、`V1_plus_square_root_property` の具体版（`DefinitionV1PlusSquareRoot.lean`）を人手の準備の 2 本の鎖（`1_ℂ + 1_ℂ = 2_ℂ`、`c + c = iκ` の 10 行）と主張の 9 行と同じ段の calc にした。主張の型を `V1plusHalf M K1 ^ 2 = V1plus M K1` にし（使う側は `← sq`）、定義の係数と人手の `i·2_ℂ^{-1}` の差は `V1plusHalf_coeff_eq` で通した（定義を替える件は状態台帳に残る）。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は `trace_of_epsilon_V_plus`。
2026-11-05: 全証明の SageMath 検算として、`kappa_of_K_basic`（κ(K) の基本性質と臨界点 K_c）に検算 `sagemath/check/kappa_of_K_basic/` を付け、本文に無かった cosh' = sinh を主張 `cosh_derivative`（検算 `sagemath/check/cosh_derivative/`）として足した（未検算 2 件）。導関数の行は QQ(v) の導分と SR、K_c と (2) は QQ[w]・AA で厳密に、(4)・(5) の鎖は格子点 9 点ごとにボールと Arb の積分で確かめた。人手証明を直した（主張の数値は不変）: K_c ∈ ℝ_{>0}・cosh 2K_c = √2・√2 の評価を準備に、単調性を平均値の定理なしで (R3)(R4) の鎖に、(2) を同値の鎖に、(5) の K < K_c の積分の向きを a = min・b = max で、微分の公式を 1 行 1 つに。cosh(1/5)・sinh(1/5) の数値の評価は注記 remark_real_analysis_escape_chapter_E が持ち込む事実として明記した。二回のレビューで必須の指摘が無くなるまで直した。Lean は不変（新しい行との 1 対 1 は Lean の連続実行の受け持ち）。次は gamma_derivatives_in_kappa。

2026-11-05: Lean の通しの証明のゴールラインの確認の百六十一個目として、`epsilon_G_is_involution` の具体版（`ClaimEpsilonD0GCommuteAndDiagonalAction.lean`）を人手の準備の 5 行（`sigmaZ_mul_self`）と主張の 15 行（`epsilon_mul_boundaryG_sq`）と同じ段の calc にした。人手の `M_col ≥ 2` に合わせて `2 ≤ M` を取り（使う側 `exp_epsilon_mul_boundaryG` も）、11 段目は `siteOp_mul_comm` にサイト `1` と `M_col` の相異を渡す。旧い `boundaryG_mul_self` を消した。必要十分版は置かない。本文と SageMath は不変。レビューの必須の指摘は無く、任意の指摘 1 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は `V1_plus_square_root_property`。

2026-11-05: 全証明の SageMath 検算として、`isotropic_A_equals_one`（等方な場合 A = 1）の検算を付けた。旧いブロックが A = 1・K^* と κ(K) の定義・γ の式を一つに持っていたので、定義 `def_isotropic_dual_coupling`・`def_isotropic_kappa_of_K` と主張 `isotropic_kappa_equals_kappa_of_K`・`isotropic_gamma_in_kappa` に分け、三つの主張に `sagemath/check/<ラベル>/` を付けた（未検算 3 件）。K^* を本文に定義の無い def_transfer_matrix_symbols から引いていたのを `def_second_dual_coupling_constant`・`second_dual_coupling_relation` に引き直し、下流の引用と `kappa_of_K_basic` の (2) のつなぎを直した（計算の誤りは無し）。三回のレビューで必須の指摘が無くなるまで直した。npm run check・build:pdf・lake build・check-no-sorry・verify-check-linkage・run-all-checks 通過。次は kappa_of_K_basic。

2026-11-05: 全証明の SageMath 検算として、`critical_point_iff_kappa_zero`（臨界条件 s_1s_2 = 1 と K_1 = K_2^* と κ = 0 の同値）に検算 `sagemath/check/critical_point_iff_kappa_zero/` を付けた（未検算 4 件）。同値の各行を多項式環の両向きの倍元で、主張を QQ(t,u) の恒等式で厳密に、具体値を本文の exp のボールで確かめた。人手証明の根拠の引き違い（K_2^* の関係式と s_2 > 0）を直し、準備と (2)⟺(3)・κ = 0 ⟺ c_1 = s_1c_2 を同値の鎖にした（主張・計算は不変）。三回のレビューで指摘が無くなるまで直した。npm run check・build:pdf・lake build・check-no-sorry・verify-check-linkage・run-all-checks 通過。次は isotropic_A_equals_one。

2026-11-05: 全証明の SageMath 検算として、`gamma_kappa_identity`（γ を κ と A で書く恒等式）に検算 `sagemath/check/gamma_kappa_identity/` を付けた（未検算 5 件）。行の等号を多項式環のイデアルと本文の exp の形式冪級数で厳密に、具体値を本文の exp のボールで確かめた。人手証明を直した（計算の誤りは無し）: Step 2 を主張の左辺から始まる鎖に、Step 1・Step 3・偶関数性を一行一根拠の鎖に、γ_1 ≥ 1 に `gamma1_lower_bound_all_theta` を引き、平方根を √·^(ℝ≥0) に。全実数上の cos・sin と倍角公式のブロックが本文に無いことを状態台帳に記録した。二回のレビューで必須の指摘が無くなるまで直した。npm run check・build:pdf・lake build・check-no-sorry・verify-check-linkage・run-all-checks 通過。次は critical_point_iff_kappa_zero。
2026-11-05: Lean の通しの証明のゴールラインの確認の百六十個目として、`epsilon_D0_G_pairwise_commute` の具体版（`ClaimEpsilonD0GCommuteAndDiagonalAction.lean`）を人手の 3 つの準備（8 行・場合分け・14 行）と 3 つの鎖（5 行・3 行・5 行）と同じ段の calc にした。`εD_0 = D_0ε`・`D_0G = GD_0` は `M_col = r + 2` と置いて和を `Fin (r + 1)` へ読み替え、`2 ≤ M` を取る（使う側 `commute_openChainD0_epsilon_mul_boundaryG` も）。旧い `sigmaZ_mul_sigmaZ_mul_comm` を消した。必要十分版は置かない。本文と SageMath は不変。次は `epsilon_G_is_involution`。
2026-11-05: Lean の通しの証明のゴールラインの確認の百五十九個目として、`D0_G_diagonal_action` の具体版（`ClaimEpsilonD0GCommuteAndDiagonalAction.lean`。型は不変）を人手の準備の 7 行・開鎖項の 5 行・周期境界項の 8 行と同じ段の calc にした。2 つの根拠を兼ねていた段を分け、周期境界項は準備を引かずに 8 段を書き、積の包含は具体版 `real_inclusion_mul` を引く。必要十分版は置かない。本文と SageMath は不変。レビューの必須の指摘 1 件と任意の指摘 2 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は `epsilon_D0_G_pairwise_commute`。
2026-11-05: Lean の通しの証明のゴールラインの確認の百五十八個目として、`H1_plus_in_sigma_z_form` の (f4) 最後の 7 行の鎖を行った。`H1_plus_in_sigma_z_form`（型は不変）を人手の 7 行と 1 対 1 の 7 段の calc にし（`M_col = r + 2`、和は `Fin (r + 1)` の上。`Finset.filter` からの読み替え `sum_filter_not_last_eq_sum_castSucc` を 1・5 段目に含む）、使われなくなった旧い道の 3 定理を消した。これで `H1_plus_in_sigma_z_form` の Lean は人手の全ての鎖と 1 対 1。必要十分版は置かない。本文と SageMath は不変。レビューの必須の指摘は無く、任意の指摘 2 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は `D0_G_diagonal_action`。
2026-11-05: Lean の通しの証明のゴールラインの確認の百五十七個目として、`H1_plus_in_sigma_z_form` の (f3) 準備 4 を行った。人手の準備 4 の 17 行の鎖 `-(i(Y_{M_col}Z_1)) = ⋯ = εG` を新しい定理 `neg_I_smul_Y_lastSite_mul_Z_firstSite` の 17 段の calc として `ClaimH1PlusInSigmaZForm.lean` に置き、10 段目（`j → M_col`）のための補助 `siteProd_ite_ite_smul` を足した。旧い道（`neg_I_smul_Y_last_mul_Z_first` ほか）は最後の鎖がまだ使うので残した。必要十分版は置かない。本文と SageMath は不変。レビューの必須の指摘は無く、任意の指摘 4 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (f4) 最後の 7 行の鎖。

2026-11-05: 全証明の SageMath 検算として、`c_plus_equals_Lambda_half_integer`（c_+(M_col) = Λ̌_max = Λ^{(1/2)}_{M_col}）に検算 `sagemath/check/c_plus_equals_Lambda_half_integer/` を付けた（未検算 6 件）。本文の ψ̌ の数体と成分が QQ の V^{(+)}・W で全ての鎖を厳密に確かめ、c_+ を W_ℝ の F^{(+)} への制限の最大固有値として独立に作って比べた。人手証明を書き直した（主張・計算は不変）: ι^n: ℝ^n → ℂ^n と W_ℝ に名前を付けて ℝ の値と ℂ の値を (·)_ℂ でつなぎ、V^{(+)} の成分が実であることの散文を W と ε の成分が実であることからの成分の鎖に替え、結びの鎖を置いた。主張 `sum_over_binary_words_entrywise` を足して検算を付けた。三回のレビューで必須の指摘が無くなるまで直した。Lean は不変（新しい行との 1 対 1 は Lean の連続実行の受け持ち）。次は `gamma_kappa_identity`。
2026-11-05: Lean の通しの証明のゴールラインの確認の百五十六個目として、`H1_plus_in_sigma_z_form` の (f2) 準備 3 を行った。`I_smul_Y_mul_Z_next_of_not_last`（型は不変）の証明を人手の準備 3 の 11 行と 1 対 1 の calc に置き換え、補助 `siteProd_ite_smul`（`kronecker_multilinear` の `r = 1` の式）を足した。必要十分版は置かない。本文と SageMath は不変。レビューの必須の指摘は無く、任意の指摘 4 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (f3) 準備 4。

2026-11-05: Lean の通しの証明のゴールラインの確認の百五十五個目として、`H1_plus_in_sigma_z_form` を (f1) 準備 1・2・(f2) 準備 3・(f3) 準備 4・(f4) 最後の鎖に割り、(f1) を行った。`ClaimH1PlusInSigmaZForm.lean` に、人手の準備 1・2 のクロネッカー積表示の 7 本の鎖（`Y_kronecker_form`・`Z_nextSite_kronecker_form`・`sigmaZ_mul_sigmaZ_nextSite_kronecker`・`Y_lastSite_kronecker_form`・`Z_firstSite_kronecker_form`・`epsilon_kronecker_form`・`sigmaZ_lastSite_mul_sigmaZ_firstSite_kronecker`）を人手の各行と 1 対 1 で置いた。必要十分版は置かない。本文と SageMath は不変。レビューの必須の指摘は無く、任意の指摘 4 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (f2) 準備 3。

2026-11-05: 全証明の SageMath 検算として、`check_number_operator_is_hermitian`（ň_μ・Q̌_ε はエルミート）に検算 `sagemath/check/check_number_operator_is_hermitian/` を付けた（未検算 7 件）。(1)(2) を QQ(i)・円分体で、(3)(4) を本物の ψ̌ の数体で、複素共役を体の自己同型として厳密に確かめた。人手証明の根拠のラベルの取り違え 7 箇所を直し、クロネッカー積の共役転置と結びの鎖を成分の鎖に書き直した（主張・計算は不変）。次は `c_plus_equals_Lambda_half_integer`。
2026-11-05: Lean の通しの証明のゴールラインの確認の百五十四個目として、`trace_of_epsilon_V_plus_via_check_eigenvalues` の (e3) Step 7 の同値を行い、この主張の Lean を人手の Step 1〜7 と 1 対 1 にし終えた。`⟹`（`trace_pos_of_eta_univ_eq_one_step7`）・`⟸`（`eta_univ_eq_one_of_trace_pos_step7`。成分の比較と `ȟ = −1` の背理）・同値（`eta_univ_eq_one_iff_trace_pos_step7`、一般の `M` は `eta_univ_eq_one_iff_trace_pos`）を人手と同じ行の calc で置き、`⟸` が引く Step 5 の 1〜6 行目を `trace_epsilon_mul_V_step5_rows_one_to_six` に分けた。下流が使う `eta_univ_eq_one_of_trace_pos`（`0 < Re tr` の形、型は不変）は (3) から導く運ぶ段にした。必要十分版は置かない。本文と SageMath は不変。次は `H1_plus_in_sigma_z_form`。

2026-11-05: Lean の通しの証明のゴールラインの確認の百五十三個目として、`trace_of_epsilon_V_plus_via_check_eigenvalues` の (e2b) を行った。Step 6 の 4 本の鎖（`γ(θ̃_μ)/2 > 0`、`2sinh(γ(θ̃_μ)/2) > 0`、`Π_μ2sinh(γ(θ̃_μ)/2) > 0`、`ϰ > 0`）を `VPlusData.gam_half_pos`・`two_sinh_gam_half_pos`・`prod_two_sinh_gam_half_pos`・`traceFactor_pos_step6` として人手と同じ行で置き、`VPlusData.traceFactor_pos`（型は不変）をそれで組み直した。必要十分版は置かない。本文と SageMath は不変。レビューの必須の指摘 1 件（`check-no-sorry.sh` の `targets` への追加）と任意の指摘 1 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (e3)（Step 7 の同値）。

2026-11-05: Lean の通しの証明のゴールラインの確認の百五十二個目として、`trace_of_epsilon_V_plus_via_check_eigenvalues` の (e2) を (e2a) `cosh_sinh_basic_properties` (3) の具体版と (e2b) Step 6 の 4 本の鎖に割り、(e2a) を行った。`cosh_sinh_basic_properties` の (1)・(3) の具体版（人手の各行と 1 対 1）を `MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimCoshSinhBasicProperties.lean`、必要十分版を `NecSuf/HyperbolicBasicPropertiesFromMonotoneMap.lean`（環と `Invertible 2`、`e` の正値性・狭義単調性だけが効く）、特殊化を `ClaimCoshSinhBasicPropertiesFromNecSuf.lean` に置いた。本文と SageMath は不変。レビューの必須の指摘 2 件・任意の指摘 5 件を直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (e2b)。
2026-11-05: 全証明の SageMath 検算として、`gamma_is_continuous`（γ は ℝ 上で連続）に検算 `sagemath/check/gamma_is_continuous/` を付けた（未検算 8 件）。代数の行を `QQ`・`AA` で厳密に、連続性を区間の振れ幅の囲みが δ とともに縮むことで `RealBallField` で確かめた。人手証明を直した（計算の誤りは無し）: 本文で使われない周期 2π の主張とその証明を `notes/claims_unused_by_chapter_goals_not_adopted.ts` へ移し、結論に使われない Step 2 の準備を除き、各 Step に定義の blkref と (R0) の参照を置いた。三回のレビューで必須の指摘が無くなるまで直した。npm run check・build:pdf・lake build・check-no-sorry・check-docs-references・verify-check-linkage・run-all-checks 通過。Lean はコメントと ch012 の表だけ。次は check_number_operator_is_hermitian。
2026-11-05: Lean の通しの証明のゴールラインの確認の百五十一個目として、`trace_of_epsilon_V_plus_via_check_eigenvalues` の (e) を (e1) Step 5・(e2) Step 6・(e3) Step 7 に割り、(e1) を行った。Step 5 の 8 行の鎖を `VPlusData.trace_epsilon_mul_V_step5`（人手と同じ行の calc）で置き、`VPlusData.trace_epsilon_mul_V`（型は不変）をそれで証明し直した（`M = 0` は mathlib の `simp`）。旧い証明の `NecSuf.sum_powerset_signed_exp` は具体版から使われなくなったので別証の扱いへ書き直した。本文と SageMath は不変。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (e2)。
2026-11-05: Lean の通しの証明のゴールラインの確認の百五十個目として、`trace_of_epsilon_V_plus_via_check_eigenvalues` の (d2) を行った。Step 4 の 2 本目の和の鎖 `Σ_εť_ε = … = ϰ` を `VPlusData.sum_checkT_eq_traceFactor` として人手と同じ行の calc で置いた（人手の `M_col` が `r + 1`、和は `binaryWordRealSum r`、`ϰ` は `VPlusData.traceFactor`。運ぶ段は `e ∈ {0,1}` を ℝ の `1`・`0` へ付け替える 1 段だけ。必要十分版は置かない）。本文と SageMath は不変。レビューで必須の指摘は無し。次は (e) Step 5〜7。
2026-11-05: Lean の通しの証明のゴールラインの確認の百四十九個目として、`trace_of_epsilon_V_plus_via_check_eigenvalues` の (d) Step 4 を (d1) 1 本目の 7 行の鎖と (d2) 2 本目の和の 14 行の鎖に割り、(d1) を行った。人手 `finite_product_of_real_products` の具体版 `Ising2D.finite_product_of_real_products`（`ClaimFiniteProductOfRealProducts.lean`）・必要十分版 `NecSuf.finProdLeft_mul'`（`NecSuf/FiniteProductOfProducts.lean`。`(ab)(cd) = (ac)(bd)` だけが効く）・特殊化 `finite_product_of_real_products_of_necSuf` を置き、`ť_ε = … = (Π_μw̌_μ^{(ε_μ)})(2sinh 2K_2)^{M_col/2}` の 7 行を `VPlusData.checkT_eq_prod_checkW_mul`（準備 `checkW`、運ぶ段 `checkLambda_finsetOfWord`・`ite_eq_one_eq_val_real`）として人手と同じ行の calc で置いた。本文と SageMath は不変。レビューの必須の指摘は無し（任意の 2 件を直した）。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (d2)。
2026-11-05: 全証明の SageMath 検算として、`epsilon_commutes_with_W`（εW = Wε と W が F^(+) を保つこと）に検算 `sagemath/check/epsilon_commutes_with_W/` を付けた（未検算 9 件）。準備・本体の鎖・F^(+) の鎖の全行を、M_col = 1..5 で exp の値を Laurent 多項式環の不定元に置いて厳密に確かめた（浮動小数点なし）。人手証明を直した（主張は不変、計算の誤りは無し）: 結合律と可換性を同時に当てていた鎖を一行一定理の 11 行にし、準備を (∵) の鎖にし、主張文に帰属を書き、別名を S := V_1^{1/2} にした。二回のレビューで必須の指摘が無くなるまで直した。npm run check・build:pdf・lake build・check-no-sorry・verify-check-linkage・run-all-checks 通過。Lean は不変（新しい鎖との 1 対 1 は Lean の連続実行の受け持ち）。次は gamma_is_continuous。
2026-11-05: 全証明の SageMath 検算として、`W_has_positive_entries`（W の成分はすべて正）に検算 `sagemath/check/W_has_positive_entries/` を付けた（未検算 10 件）。準備・Step 1・Step 2・Step 3 の全ての鎖と主張を、exp(½K_1)・exp(K_2) を Laurent 多項式環の不定元に置いた一般の場合と、K_1 = 2 log y・K_2 = log x の具体の場合（B は固有値の射影から作る）で厳密に確かめた（M_col = 2..5、浮動小数点なし）。人手証明を直した（主張の中身は不変、計算の誤りは無し）: 散文の Step を (∵) とラベル参照の鎖にし、主張文に添字の読み方・複素数の z > 0 の読み方・任意の k, l への言い換えを書いた（下流が任意の行・列番号で使っているため）。二回のレビューで必須の指摘が無くなるまで直した。npm run check・build:pdf・lake build・check-no-sorry・verify-check-linkage・run-all-checks 通過。Lean は不変（新しい鎖との 1 対 1 は Lean の連続実行の受け持ち）。次は epsilon_commutes_with_W。
2026-11-05: Lean の通しの証明のゴールラインの確認の百四十八個目として、`trace_of_epsilon_V_plus_via_check_eigenvalues` の (c) Step 3 を行った。`η_ε(Λ̌_ε)_ℂ = … = (ť_εȟ)_ℂ` の 7 行を `VPlusData.eta_mul_checkLambda_eq_checkT_mul_checkH`（人手と同じ行の calc）で置き、準備の `ȟ` を `CheckFermi.checkH`、`ť_ε` を `VPlusData.checkT` とした。必要十分版 `NecSuf.signed_term_eq_map_mul'`（`CommSemigroup R`・`Mul S`。`q` が `−1` の冪であることは効かない）を `NecSuf/SignedTermAsImageOfReorderedProduct.lean` に置いた。本文と SageMath は不変。次は (d) Step 4。
2026-11-05: Lean の通しの証明のゴールラインの確認の百四十七個目として、`trace_of_epsilon_V_plus_via_check_eigenvalues` の (b) Step 2 を行った。`(Π_{μ≤k}ǔ^{(ε_μ)})_ℂ = (−1_ℂ)^{k−|ε|_k}` の `k` の帰納法を `checkU_prod_eq_neg_one_pow`（人手の 5・7・6・6 行と同じ順・同じ行の calc）で置き、必要十分版 `NecSuf.map_prod_two_valued_eq_pow'`（`Mul R`・`Monoid S`。`s = −1` は効かない）を `NecSuf/PowerFromProductOfTwoValuedFactors.lean` に置いた。本文と SageMath は不変。次は (c) Step 3。
2026-11-05: Lean の通しの証明のゴールラインの確認の百四十六個目として、`trace_of_epsilon_V_plus_via_check_eigenvalues` を人手の Step の単位で (a) Step 1・(b) Step 2・(c) Step 3・(d) Step 4・(e) Step 5〜7 に割り、(a) を行った。Step 1 の 13 行の鎖を `VPlusData.trace_epsilon_mul_V_step1`（人手と同じ行の calc。`M_col = r + 1`、和は `NecSuf.binWordSum r`）で置き、`trace_epsilon_mul_V_eq_sum`（型は不変）をこの鎖と `finsetOfWord` の付け替えで示す形にした（人手の範囲外の `M = 0` は mathlib）。旧 `epsilon_mul_V_mul_Qproj` は削った。必要十分版は不要（既存の具体版の組み合わせだけ）。本文と SageMath は不変。次は (b)。
2026-11-05: 全証明の SageMath 検算として、`limit_of_log_Z_in_N_row`（N_row → ∞ の極限）に検算 `sagemath/check/limit_of_log_Z_in_N_row/` を付け、そのために足した主張 `real_log_of_power`（log(a^n) = n log a。検算 `sagemath/check/real_log_of_power/`）と定義 `def_power_of_real_number`（実数の冪）を置いた（未検算 11 件）。人手証明の根拠をラベル参照にし、極限の段を ε・N_0 の鎖にし、誤った「実数解析へ移行していない」を実対数と極限による ℝ 脱出の宣言に替えた（主張は不変、計算の誤りは無し）。本文の W（M_col = 2, 3）と N_row ≤ 60 で、Z は QQ・c は AA の厳密、log の行は RealBallField(512)。二回のレビューで必須の指摘が無くなるまで直した。npm run check・build:pdf・lake build・check-no-sorry・verify-check-linkage・run-all-checks 通過。Lean は不変（新しい鎖との 1 対 1 は Lean の連続実行の受け持ち）。次は W_has_positive_entries。
2026-11-05: 全証明の SageMath 検算として、`trace_power_sandwich`（c(M_col)^n ≤ tr(W^n) ≤ 2^{M_col}c(M_col)^n）に検算 `sagemath/check/trace_power_sandwich/` を付けた（未検算 12 件）。証明の根拠の欠けを直した（主張は不変、計算の誤りは無し）: 望遠鏡積を二つの帰納法に、二次形式のトレース評価を絶対値・平方根を使わない半正定値性の鎖に、「W^n は正定値」を moment_log_convexity の正値性を単位ベクトル w := ‖z‖^{-1}z に当てる鎖に、連続性を暗に使っていた「t^n と上限の可換」を正の実数の冪の比較と背理法にした。正定値有理行列と本文の W（M_col = 2, 3）で QQ・AA の厳密計算。二回のレビューで必須の指摘が無くなるまで直した。npm run check・build:pdf・verify-check-linkage・run-all-checks 通過。Lean は不変（新しい鎖との 1 対 1 は Lean の連続実行の受け持ち）。次は limit_of_log_Z_in_N_row。
2026-11-05: Lean の通しの証明のゴールラインの確認の百四十五個目として、`epsilon_eigenvalue_on_check_Q` の (4b) を行った。`epsilon_eq_parityProd`（型は不変）を人手の `εQ̌_ε = c(PQ̌_ε)` の 7 行（`epsilon_mul_Qproj_eq_smul_parityProd_mul`・`neg_one_pow_mul_self`）と `ε = εI = … = cP` の 9 行（`epsilon_eq_parityProd_succ`。和は `NecSuf.binWordSum`、付け替えは `finsetOfWord`・`sum_Qproj_eq_binWordSum`・`binWordSum_Qproj`）と同じ行の calc にした（人手の範囲外の `M = 0` は `eq_of_mul_Qproj_eq`）。必要十分版 `NecSuf/ParityFormFromSignsOnProjections.lean`（`neg_one_pow_mul_self'`・`mul_eq_smul_mul_of_sign_pow'`・`eq_smul_of_mul_eq_smul_mul'`）と特殊化 `*_of_necSuf` を足した。本文と SageMath は不変。レビューの必須の指摘（`SemigroupAction` へ弱める）を直した。これで `epsilon_eigenvalue_on_check_Q` は済んだ。次は `trace_of_epsilon_V_plus_via_check_eigenvalues`。
2026-11-05: 全証明の SageMath 検算として、`moment_log_convexity`（モーメント列 x^⊤W^kx の正値性と対数凸性）に検算 `sagemath/check/moment_log_convexity/` を付けた（未検算 13 件）。証明を、本文に無い行列の積の転置を使わずに x^⊤(W^b(BW^a))x = (W^bx)^⊤B(W^ax)（B = I, W）を成分で示す形に書き直し、正値性の「W が可逆なので W^ax ≠ 0」を正定値性からの帰納法にした（主張の不等式は不変、計算の誤りは無し）。正定値有理行列と本文の W（M_col = 2, 3）で QQ の厳密計算。二回のレビューで必須の指摘が無くなるまで直した。npm run check・build:pdf・verify-check-linkage・run-all-checks 通過。Lean は不変。次は trace_power_sandwich。
2026-11-05: Lean の通しの証明のゴールラインの確認の百四十四個目として、`epsilon_eigenvalue_on_check_Q` の (4a) を行った。`(I − 2ň_μ)Q̌_ε = (1 − 2ε_μ)Q̌_ε` の 10 行（`parityFactor_mul_Qproj`）と `P_kQ̌_ε = p_kQ̌_ε` の帰納法（`finProdLeft_mul_Qproj`）を人手と同じ行の calc にし、`parityProd` を左から掛ける有限積 `NecSuf.finProdLeft` で定義し直した（`epsilon_eq_parityProd` の型は不変）。必要十分版は `NecSuf/FactorsActingAsScalarsOnProjection.lean`（`NonAssocRing`・`SemigroupAction` まで弱めた）。旧 `NecSuf.noncommProd_mul_of_mul_eq_smul` は削った。本文と SageMath は不変。次は (4b)。

2026-11-05: 全証明の SageMath 検算として、`trace_power_upper_bound`（tr(W^n) ≤ 2^{M_col}c(M_col)^n）に検算 `sagemath/check/trace_power_upper_bound/` を付けた（未検算 14 件）。本文に無かった「行列の冪の指数法則」「成分が実の行列の積は成分が実」「実対称な複素行列の冪は実対称」を主張 `matrix_power_exponent_law`・`product_of_real_entry_matrices_has_real_entries`・`power_of_real_symmetric_complex_matrix_is_real_symmetric` として足し（それぞれ同名の検算付き）、本体の証明を、本文に無い行列の積の転置を使わずに mat_mult の成分と対称性で ‖u‖^2・u^⊤Wu に着く鎖に書き直した（主張は不変、計算の誤りは無し）。一般の半正定値有理行列 28 組と本文の W（M_col = 2, 3）で QQ・AA の厳密計算。三回のレビューで必須の指摘が無くなるまで直した。npm run check・build:pdf・lake build・check-no-sorry・verify-check-linkage・run-all-checks 通過。Lean は不変。次は moment_log_convexity。
2026-11-05: Lean の通しの証明のゴールラインの確認の百四十三個目として、`epsilon_eigenvalue_on_check_Q` の (3) `η_ε = η_{(1,…,1)}(−1)^{M_col−|ε|}` を行った。`eta_eq_eta_univ_mul`（型は不変）を、補数の個数の帰納法と `ring` で閉じる証明から、人手の `k := M_col − |ε|` の帰納法（`k = 0` の 4 行、`k ≥ 1` の 7 行の鎖）と同じ行の calc に組み直した（`eta_eq_eta_univ_mul_of_sub_card`・`eta_eq_neg_eta_insert`。`eta_univ_eq_aux` は削った）。必要十分版は新しいファイル `lean/Ising2D/NecSuf/SignAfterReplacingComponents.lean`（値の集合は `Monoid`・`HasDistribNeg` だけ。乗法の交換則の行は `−1` の可換性だけで、`R` の可換則は効かない）と特殊化 `*_of_necSuf`。本文と SageMath は不変。レビューで必須の指摘なし。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は (4) を (4a)・(4b) に割って (4a) から（状態台帳）。
2026-11-05: Lean の通しの証明のゴールラインの確認の百四十二個目として、`epsilon_eigenvalue_on_check_Q` の (2c) を行った。符号の反転則 `eta_insert` を、行列の上の必要十分版の系から、人手と同じ数ベクトルの鎖（`im Q̌_ε` の 0 でない元 `q` を 1 次元性を使わずに取り、冒頭の `εq = η_ε q` の 5 行、Step 1〜3、Step 3 の後半の 6 行、0 でない成分で約す）に組み直した（型は不変）。人手の範囲外の `M = 1` は Step 2 の縮めた鎖で埋めた。必要十分版 2 本（`NonUnitalSemiring`）と特殊化、`eta_insert_of_necSuf` を足した。本文と SageMath は不変。次は (3)（`η_ε = η_{(1,…,1)}(-1)^{M-|ε|}` の帰納法を人手の鎖に）。
2026-11-04: Lean の通しの証明のゴールラインの確認の百四十一個目として、`epsilon_eigenvalue_on_check_Q` の (2b2) を行った。Step 2 の後半の `Π' := ∏_{ν≠μ}A_ν`（`NecSuf.finProdLeftOmitting`）と `ψ̌_μ^†Π' = Π'ψ̌_μ^†`、`A_μ^ε q = q`（5 行）・`Π'q = q`（5 行）・`Q̌_{ε'}(ψ̌_μ^† q) = ψ̌_μ^† q`（10 行）を人手と同じ行の calc の具体版（`ClaimEpsilonEigenvalueOnCheckQ.lean`）と必要十分版（`NecSuf/SignReversalOnGeneratorVector.lean`、`NonAssocRing`・`NonUnitalSemiring`）で置いた。本文と SageMath は不変。次は (2c)（(2) の冒頭の鎖、Step 3 の後半、約分、`eta_insert` の組み替え）。
2026-11-04: Lean の通しの証明のゴールラインの確認の百四十個目として、`epsilon_eigenvalue_on_check_Q` の (2b) を (2b1)・(2b2) に割り (2b1) を行った。Step 2 の `ň_μψ̌_μ^† = ψ̌_μ^†` の 13 行（`CheckFermi.nOp_mul_cre`。必要十分版 `NecSuf.num_mul_cre'` を同じ 13 行で置き、既存の `num_mul_cre` をその系にした）、`A_μ^ε = I − ň_μ`・`A_μ^{ε'} = ň_μ` の 8 行ずつ（`defFactor_of_notMem`・`defFactor_of_mem`）、`ν ≠ μ` の `A_ν^{ε'} = A_ν^ε`、可換性 `XA_ν^δ = A_ν^δX`（`commute_defFactor_of_commute`）と `X → ň_κ`・`A_κ^δ`・`ψ̌_μ^†` の 3 つの使い方を、人手と同じ行の calc で置いた。本文と SageMath は不変。次は (2b2)（`Π'` と 3 本の鎖）。
2026-11-04: Lean の通しの証明のゴールラインの確認の百三十九個目として、`epsilon_eigenvalue_on_check_Q` の (2) を (2a)〜(2c) に割り (2a) を行った。Step 1 の 3 本の鎖（`ň_μ q = 0`・`ψ̌_{M+1−μ}(ψ̌_μ^† q) = q`・背理法）と Step 3 の前半の 9 行の鎖を、人手と同じ行の calc の具体版と必要十分版（`NecSuf/SignReversalOnGeneratorVector.lean`。Step 3 はスカラー環を係数と分け、効くのは `SMulCommClass` だけ）で置いた。`eta_insert` は未組み替え。本文と SageMath は不変。次は (2b) の Step 2。

2026-11-04: 全証明の SageMath 検算として、`rayleigh_bounds_operator_norm`（‖Wx‖ ≤ c(M_col)‖x‖ と冪の版）に検算 `sagemath/check/rayleigh_bounds_operator_norm/` を付けた（未検算 15 件）。一般の半正定値有理行列 157 組と本文の W（M_col = 2, 3）で、c(M_col) を AA の最大固有値として作り上限であることを確かめたうえで、全ての行を QQ・AA で厳密に確かめた。人手証明の飛びを直した（y^⊤(Wx) と y^⊤Wx をつなぐ行が無かった、帰納法で本文に無い W^kW = WW^k を使っていた。主張は不変、Lean は不変）。上流の W の ℂ/ℝ の同一視は状態台帳に記録。次は `trace_power_upper_bound`。

2026-11-04: 全証明の SageMath 検算として、`W_is_real_symmetric_positive_definite`（W は実対称正定値で可逆）に検算 `sagemath/check/W_is_real_symmetric_positive_definite/` を付けた（未検算 16 件）。肩の行は実の不定元の多項式環、exp を含む行は √t・√(2s_2) を含む実の数体で厳密計算。人手証明の可逆性の段が複素の x に x^⊤Wx を使っていた誤りを、BB' = I・V2_invertible・可逆元の積による W ∈ R^× の証明に直した（主張の内容は不変、Lean は不変で 1 対 1 は Lean の連続実行の受け持ち）。次は `rayleigh_bounds_operator_norm`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百三十八個目として、`epsilon_eigenvalue_on_check_Q` を (1)〜(4) に割り (1) を行った。具体版を人手の鎖（`Q̌q = q`・`Q̌(εq) = εq`・`q = (ηη)q`・`(ηη−1)q = O`・成分による `η ∈ {±1}`・`(εQ̌)x = (ηQ̌)x`・列ごとの行列の等式・一意性の 6 行）と同じ行の calc にし、`eta` を `exists_eta_with_generator` の選択にした（型は不変）。本文の `mat_columnwise` に Lean の具体版・必要十分版・`TensorPow M` の系を置いた。本文と SageMath は不変。二回のレビューで必須の指摘が無くなるまで直した。次は同じ主張の (2)。

2026-11-04: Lean の通しの証明のゴールラインの確認の百三十七個目として、`epsilon_anticommutes_with_check_Z_Y` の (4) を行った。具体版 `CheckFermi.commute_epsilon_nOp`（3 行）・`commute_epsilon_defFactor`（`εI = Iε`・3 式・`A_ν` の 5 行）・`commute_epsilon_Qproj_succ`（`Q̌_ε` の 3 行）を人手の鎖と同じ calc にし、本文の `product_of_anticommuting_matrices_commutes`・`commuting_with_scalar_multiple` の具体版・必要十分版・`TensorPow M` の系を足した。必要十分版 `NecSuf.commute_parity_num` を同じ 3 行に直し、`Q̌_ε` の側の `NecSuf.commute_parity_finProdLeft_defFactor` ほかを置いた（係数の関係 `d = 1 − c` と `ň` の冪等性は効かない）。本文と SageMath は不変。次は `epsilon_eigenvalue_on_check_Q`。

2026-11-04: 全証明の SageMath 検算として、`Z_equals_trace_of_W`（Z = tr(W^{N_row})）に検算 `sagemath/check/Z_equals_trace_of_W/` を付けた（未検算 17 件）。不定元・QQ(i) の行列と、exp を不定元に置いた QQ(q,r) の本文の行列で厳密計算。人手証明の計算の誤りは無し。散文の証明を def_exp (1) の冪による二つの帰納法と結合律・単位律の (∵) 付きの鎖にした（主張と本体の順は不変、Lean は不変）。次は `W_is_real_symmetric_positive_definite`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百三十六個目として、`epsilon_anticommutes_with_check_Z_Y` の (3) を行った。具体版を人手の `(Ψ, p, q)` の 9 行と同じ calc（`epsilon_anticomm_two_term`、`epsilon_anticomm_checkPsiDag`・`epsilon_anticomm_checkPsi`）にし、`epsilon_anticomm_of_isCheckMode` をそれで示した。必要十分版 `NecSuf.anticomm_add_smul` を同じ 7 段で置き、Lincomb の仮定を `DistribSMul 𝕜 A`（`𝕜` に構造なし）まで下げた（(2) も同じ）。本文と SageMath は不変。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は同じ主張の (4)。

2026-11-04: 全証明の SageMath 検算として、`max_eigenvector_in_even_sector`（η_{(1,…,1)} = +1 と最大固有ベクトルが偶セクターに属すること）に検算 `sagemath/check/max_eigenvector_in_even_sector/` を付けた（未検算 18 件）。本文の ψ̌ と実際の V^{(+)} で数体 E_1・AA・QQbar の厳密計算。人手証明の計算の誤りは無し。散文の推論と定義の無い負の冪を (∵) 付きの鎖にした（主張は不変、(4) の εQ̌ = Q̌ は Lean の具体版と同じ経路）。次は `Z_equals_trace_of_W`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百三十五個目として、`eigenvalue_problem_eigenvector_of_max_eigenvalue.ts` の名前だけの根拠を洗い出した（本文は SageMath 検算の連続実行がほぼ書き直し済みで、残るのは `trace_of_epsilon_V_plus` の行列の冪の定義 5 か所（`def_exp` (1) へ）、ℝ の冪の 3 行、`open_chain_*` の分配則 2 か所（`finite_sum_of_real_scalar_multiples` へ）。Lean は検算の連続実行が残した 9 ブロックの具体版を新しい鎖に合わせる）。先頭の `epsilon_anticommutes_with_check_Z_Y` (2) を行い、具体版を人手の 9 行と同じ calc（`epsilon_anticomm_phase_sum`・`epsilon_anticomm_checkZ_succ`・`checkY_succ`）にし、必要十分版 `NecSuf.anticomm_sum_smul` を同じ 7 段の calc に書き直して仮定を減らした（積の結合律・単位元・𝕜 の加法は効かない）。本文と SageMath は不変。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は同じ主張の (3)。

2026-11-04: 全証明の SageMath 検算として、`trace_of_epsilon_V_plus`（tr(εV^{(+)}) の閉じた式と正値性）に検算 `sagemath/check/trace_of_epsilon_V_plus/` を付けた（未検算 19 件）。K_1 = 2 log p、K_2 = log q と置き、行列の exp をスペクトル射影で QQ(i) に組んで全ての鎖を厳密に確かめた。値の誤りは無し。証明を準備 (P1)〜(P5)・Step 1〜6 の (∵) 付きの鎖に書き直し（成分は ord(s) と包含 (·)_ℂ で、0 の項は finite_sum_with_single_nonzero_term）、主張文に ℂ の左辺と ℝ の右辺の等号の読み方を書いた（主張は不変）。Lean は変えていない（`ClaimTraceEpsilonVPlus*.lean` と新しい鎖の 1 対 1 は Lean の連続実行の受け持ち）。npm run check・build:pdf・lake build・check-no-sorry・verify-check-linkage・run-all-checks 通過。次は `max_eigenvector_in_even_sector`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百三十四個目として、`V_plus_eigenvalues_with_c_value_and_strict_maximum` の (4) の後半の散文（最大元の存在と max）を書き下した。定義 `def_maximum_value_of_real_family`・主張 `maximum_value_of_real_family_is_unique`・記号の定義 `def_max_of_real_family` を `000_calculation_formulae_00_09.ts` に足して引く形にし、Lean に具体版・必要十分版（`NecSuf/MaximumValueOfFamilyIsUnique.lean`、`≤` と反対称律だけ）と主張の 6 つ目の連言を、SageMath に (4) の新しい行と一意性の検算を足した。次は `eigenvalue_problem_eigenvector_of_max_eigenvalue.ts` の名前だけの根拠の洗い出し。

2026-11-04: Lean の通しの証明のゴールラインの確認の百三十三個目として、`max_eigenvalue_of_V_plus_simple` と `V_plus_eigenvalues_with_c_value_and_strict_maximum` に残る名前だけの根拠を洗い出した（前者は高校教科書レベルで省略してよい ℝ の四則・分配則・移項だけなので残す）。後者の (3) の 5 行の鎖（「最大のものは全ての ε_μ = 1」「1 − ½ = ½」「分配法則」）を、`max_eigenvalue_of_V_plus_simple` (1)・`eigenvalues_of_V_plus` (2) の置き方 `Λ̌_max := Λ̌_{(1,…,1)}` と値を引く 2 行の鎖二本にし、置き方を `eigenvalues_of_V_plus` の主張 (2) に書き足した（内容は不変）。Lean は同じ行の calc 二本（値の行は `checkBigLambda_max_eq`、連言 4 の和を人手と同じ `Fin M` の上の和に）。SageMath は `V_plus_eigenvalues_with_c_value_and_strict_maximum/check_goal_chain.sage` を直して 24 組 PASS。次は同じ主張の (4) の最大元の散文。

2026-11-04: Lean の通しの証明のゴールラインの確認の百三十二個目として、人手 `eigenvalues_of_V_plus` の (e)（`Λ̌_maxΛ̌_min`）を書き下した。「指数部分が互いに打ち消し合う」「定数 c の決定」を、積の 20 行の鎖（`scalar_exp_product`・`scalar_exp_zero`・`def_second_transfer_matrix_prefactor`・`definition_of_sqrt_r_positive` ほか）と `(Λ̌_maxΛ̌_min)_ℂ = c^2` の 8 行の鎖（`real_inclusion_preserves_product`・`constant_c_value_even_sector`・`def_power_of_complex_number`）にし、ℝ の元と ℂ の元を等号で結んでいた主張文の括弧書きを直した（内容は不変）。Lean は `checkBigLambda_max_mul_min_eq_sq_prefactor`・`checkBigLambda_max_mul_min`（結論を自然数冪に）・`checkBigLambda_max_mul_min_eq_c_sq`（同じ行の calc）。SageMath は `sagemath/check/eigenvalues_of_V_plus/check_part2_product_chains.sage`。レビューの必須の指摘を直した。未解決: 本文に ℝ の自然数冪の定義のブロックが無い。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は同じファイルの `max_eigenvalue_of_V_plus_simple`・`c_value_eigenvalues_and_strict_maximum` の名前だけの根拠。

2026-11-04: 全証明の SageMath 検算として、`V1_plus_square_root_property`（((V_1^{(+)})^{1/2})^2 = V_1^{(+)}）に検算 `sagemath/check/V1_plus_square_root_property/` を付けた（未検算 20 件）。人手証明の計算の誤りは無し。「X の定義と同類項の加法」の一行を、c := (i2_ℂ^{-1})(K_1)_ℂ を二つ足すと i(K_1)_ℂ になる準備の鎖（記号は κ := (K_1)_ℂ。theorem_exp_product の係数の体 K と分けた）と、def_finite_sum_of_matrices・finite_sum_of_scalar_multiples_of_one_matrix（r = 2）・def_finite_sum_of_complex_numbers の行に分け、主張文に M_col ∈ ℤ_{≥2} と A^2 := AA を書いた（主張は不変）。Lean の `DefinitionV1PlusSquareRoot.lean` は変えていない（新しい行の分け方との 1 対 1 は Lean の連続実行の受け持ち）。次は `trace_of_epsilon_V_plus`。

2026-11-04: 全証明の SageMath 検算として、`open_chain_partition_sum`・`open_chain_endpoint_product_sum`・`open_chain_spin_sums_positive`（1 次元開鎖の二つのスピン和とその正値性）に検算 `sagemath/check/<ラベル>/` を付けた（未検算 21 件）。値の誤りは無し。exp(KE(s)) = Π exp(Kt_m) の根拠が theorem_exp_product（行列の主張）を指していた誤りを real_exp_of_finite_sum に、M_col = 2 で定義の無い空の積を使っていた段を場合分けに直し、積の展開を ς(e) := 2e − 1 による付け替えと expansion_of_finite_product_of_two_term_sums_of_real_numbers の行にした（主張は不変）。Lean は `ClaimOpenChainSpinSums.lean` の注記の根拠名だけを直した（新しい行との 1 対 1 は Lean の連続実行の受け持ち）。次は `V1_plus_square_root_property`。

2026-11-04: 全証明の SageMath 検算として、`epsilon_D0_G_pairwise_commute`（εD_0 = D_0ε、εG = Gε、D_0G = GD_0）と `epsilon_G_is_involution`（(εG)^2 = I）に検算 `sagemath/check/epsilon_D0_G_pairwise_commute/`・`sagemath/check/epsilon_G_is_involution/` を付けた（未検算 24 件）。人手証明の計算の誤りは無し。符号の括り出し・結合律・二重の符号反転・因子の並べ替えを一行にまとめていた段をラベル参照の行の鎖に分け、準備を内容の名前で置き、(εG)^2 = I の ε^2 = I の根拠が epsilon_projector_properties (1) を指していた誤りを epsilon_square_and_eigenvalues に直した（主張は不変）。Lean の `ClaimEpsilonD0GCommuteAndDiagonalAction.lean` は変えていない（新しい行との 1 対 1 は Lean の連続実行の受け持ち）。次は `open_chain_partition_sum`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百三十一個目として、人手 `eigenvalues_of_V_plus` の (d2)（`Λ̌_max`・`Λ̌_min` の値）を書き下した。ℝ の有限和から共通の因子を外へ出す主張 `finite_sum_of_real_scalar_multiples` を足し（SageMath・Lean 具体版・必要十分版 `NecSuf.finite_sum_mul_left_fin'`・特殊化）、ǧ(1,…,1) の 4 行・ǧ(0,…,0) の 5 行・Λ̌_max・Λ̌_min の 4 行の鎖二本にした。Lean は `gval_univ_eq_half_sum`・`gval_empty_eq_neg_half_sum`・`checkBigLambda_max_eq`・`checkBigLambda_min_eq`。検算は `check_part2_extreme_values_chains.sage`。次は (e) `Λ̌_maxΛ̌_min = c^2` の鎖。

2026-11-04: Lean の通しの証明のゴールラインの確認の百三十個目として、人手 `eigenvalues_of_V_plus` の (d) を (d1) 大小の比較・(d2) `ǧ(1,…,1)`・`ǧ(0,…,0)` の値に割り、(d1) を行った。大小の比較の散文を、`r_μ`・`w_μ ≥ 0` の前置き、`ǧ` の 7 行の鎖二本、移項、`x ≤ y` なら `exp(x) ≤ exp(y)` の場合分け、`Λ̌` の 9 行の鎖二本にした（内容は不変）。Lean は具体版 `gval_le_gval_univ`・`gval_empty_le_gval`・`real_exp_le_exp_of_le`・`checkBigLambda_le_checkBigLambda_univ`・`checkBigLambda_empty_le_checkBigLambda`、必要十分版 `NecSuf.sum_weight_le_univ`・`sum_weight_empty_le` を同じ並びに書き直した（`Nonempty ι` は手順のためだけに要る）。SageMath は `sagemath/check/eigenvalues_of_V_plus/check_part2_comparison_chains.sage`。次は (d2)（ℝ の有限和から定数を外へ出す主張を足して `Λ̌_max`・`Λ̌_min` の表式を示す）。

2026-11-04: Lean の通しの証明のゴールラインの確認の百二十九個目として、人手 `eigenvalues_of_V_plus` の (c)（`Λ̌_ε > 0`）を前置きの 2 つの不等号と 5 行の鎖に書き下し、(1) と合わせて固有値が正の実数を ℂ へ移した元であることを結んだ。`Λ̌_ε` の定義の所属を `ℝ` にし、所属 `ℝ_{>0}` を引いていた 2 か所も直した。Lean は `checkBigLambda_pos` の calc と `eigenvalue_VPlus_eq_positive_real`、SageMath は `sagemath/check/eigenvalues_of_V_plus/check_part2_positivity_chain.sage`。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は (d)（大小の比較）。

2026-11-04: 全証明の SageMath 検算として、`D0_G_diagonal_action`（D_0f_{ι(s)} = (Σ s(m)s(m+1))_ℂ f_{ι(s)}、Gf_{ι(s)} = (s(M_col)s(1))_ℂ f_{ι(s)}）に検算 `sagemath/check/D0_G_diagonal_action/` を付けた（未検算 26 件）。準備・開鎖項・周期境界項の鎖の全ての行を本文の定め方の成分の式で組み、M_col = 2..6・全ての s で QQ(i) で厳密に確かめた（等号・主張 6757 件、否定コントロール 20 件）。人手証明の計算の誤りは無し。名前だけの根拠（行列作用の複素線型性・スカラー倍の結合律・有限和への分配法則）をラベル参照にし、積の結合律と σ^z の作用を一行にまとめていた段を mat_mult_associative の行で分け、係数に ℝ→ℂ の包含を書いた（値は不変）。主張文に M_col ∈ ℤ_{≥2} を書いた。一回のレビューで必須の指摘は無し。Lean の `ClaimEpsilonD0GCommuteAndDiagonalAction.lean` は変えていない。新しい人手の行の分け方と 1 対 1 でない段（`sigmaZ_mul_sigmaZ_mulVec_basisVec_spin` の最後の段が ofReal_mul と mul_comm を一段にまとめる、`openChainD0_mulVec_basisVec` の最後の段が ofReal_sum と sum_smul を人手と逆順で一段にまとめる）は Lean の連続実行の受け持ち。次は `epsilon_D0_G_pairwise_commute`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百二十八個目として、人手 `eigenvalues_of_V_plus` の (b)（対角化可能性の段落）を書き下した。`Q̌_εy = y` の 8 行・`V^{(+)}y = (Λ̌_ε)_ℂy` の 5 行・任意の 0 でない `q_ε` の族が基底になる段落・固有値がどれもある `(Λ̌_ε)_ℂ` に等しいことの背理法を足し、主張文の未定義の「重複度」を外した（内容は不変）。Lean は `VPlus_mulVec_of_mem_range`・`exists_eigenBasis_VPlus_of_joint_eigenspaces`・`exists_checkBigLambda_eq_of_eigenvalue` ほか。SageMath は `check_part1_diagonalizability_chains.sage`。三回のレビューで必須の指摘が無くなるまで直した。次は (c)（状態台帳）。

2026-11-04: 全証明の SageMath 検算として、`H1_plus_in_sigma_z_form`（iH_1^{(+)} = D_0 + εG）に検算 `sagemath/check/H1_plus_in_sigma_z_form/` を付けた（未検算 27 件）。人手証明の計算の誤りは無し。他のブロックの証明の途中（V1_in_Z_Y_epsilon の Step 0）とラベルの無い「相異なるサイトの因子は可換」を根拠にしていたので、新しい主張 `pauli_y_times_pauli_x`・`pauli_x_times_pauli_z`（検算付き）を足し、証明をクロネッカー積表示の (∵) 付きの鎖に書き直した（主張は不変）。Lean の `ClaimH1PlusInSigmaZForm.lean` は不変で、新しい鎖と新しい二つの主張との 1 対 1 は Lean の連続実行の受け持ち。次は `D0_G_diagonal_action`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百二十七個目として、人手 `eigenvalues_of_V_plus` を (a) (1) の固有関係・(b) 対角化可能性・重複度・総個数・(c) 正値性・(d) 大小の比較・(e) `Λ̌_maxΛ̌_min` に割り、(a) を行った。(1) を名前だけの根拠から 9 行の鎖二本にし、Lean の `VPlus_mul_Qproj`・`Qproj_mul_VPlus` を同じ行の calc にした。SageMath は `sagemath/check/eigenvalues_of_V_plus/`。`constant_c_value_even_sector` の `s_2 = sinh 2K_2` の根拠を `def_indexed_hyperbolic_abbreviations` に直した。次は (b)（状態台帳）。

2026-11-04: Lean の通しの証明のゴールラインの確認の百二十六個目として、人手 `constant_c_value_even_sector`（同日に SageMath の連続実行が準備・Step 1〜5 に書き直した）の Lean を 1 対 1 に書き直した。必要十分版を `NecSuf.const_eq_of_trace_chains`（Step 4・5。ℂ は零を持つ群、包含は積を保つ単射、ℝ は順序体）に替え、`positive_real_square_injective` の具体版・必要十分版と `trace_basic_properties` (4) の人手の形 `trace_similarity_invariant` を足した。主張は仮定 `c ≠ 0`（人手の `c ∈ ℂ^×`）を受け取る。二回のレビューで必須の指摘が無くなるまで直した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は `eigenvalues_of_V_plus`。

2026-11-04: 全証明の SageMath 検算として、`trace_of_epsilon_V_plus_via_check_eigenvalues`（tr(εV^{(+)}) = η_{(1,…,1)}ϰ_ℂ、ϰ > 0、η = +1 ⟺ tr > 0）に検算 `sagemath/check/trace_of_epsilon_V_plus_via_check_eigenvalues/` を付けた（未検算 28 件）。名前だけの根拠と散文を (∵) 付きの Step 1〜7 の鎖に書き直し、主張を (1)(2)(3) に分けた（値は不変）。新しい主張 `finite_product_of_real_products` と検算を足した。Lean は不変で、新しい鎖との 1 対 1 は Lean の連続実行の受け持ち。次は `H1_plus_in_sigma_z_form`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百二十五個目として、人手 `trace_V_plus_is_positive` の Lean を 1 対 1 にした。人手 `trace_of_positive_definite_is_positive` の具体版 `ClaimTraceOfPositiveDefiniteIsPositive.lean`・必要十分版 `NecSuf/TraceOfPositiveDefinite.lean`（係数は `Star` 付きの半環で積の可換律は効かない、正値の側は前順序と `AddLeftMono` だけ）・`TensorPow M` の系を足し、`trace_VPlus_pos` を `∃ r > 0, tr = r_ℂ` の形にしてそれに通した。人手の `Σ r_k ≥ r_1` の名前だけの根拠を `finite_sum_of_nonnegative_reals_is_at_least_each_term` の参照にした（値は不変）。三回のレビューで必須の指摘が無くなるまで直した。lake build・check-no-sorry・check-end-to-end・check-docs-references・npm run check・verify-check-linkage 通過。次は `constant_c_value_even_sector`。

2026-11-04: 全証明の SageMath 検算として、`epsilon_eigenvalue_on_check_Q`（εQ̌_ϵ = η_ϵQ̌_ϵ と符号の反転則、ε = η_{(1,…,1)}(−1)^{M_col}Π(I − 2ň_μ)）に検算 `sagemath/check/epsilon_eigenvalue_on_check_Q/` を付けた（未検算 29 件）。本文の ψ̌ で M_col = 2, 3 の全ての鎖と主張を数体で厳密に確かめた。計算の誤りは無し。人手証明は主張を変えずに、名前だけの根拠と散文の推論を (∵) 付きの鎖に直し、他のブロックの証明の途中を引いていた Step 2 を Q̌_δ の定義の因子を直接使う形にした。Lean は不変。次は `trace_of_epsilon_V_plus_via_check_eigenvalues`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百二十四個目として、人手 `V_plus_is_invertible` の Lean を 1 対 1 にした（人手は既に名前だけの根拠が無く、変えていない）。人手 `exp_of_negative_is_left_inverse` の具体版 `ClaimExpOfNegativeIsLeftInverse.lean`・必要十分版 `NecSuf/ExpNegMulExp.lean`（係数の積の可換律は効かない）・`TensorPow M` の系を足し、Step 1 をそれに通した。`VPlusInv` の係数を人手の `((2s_2)^{M/2})^{-1}` の式にし、`one_smul` を `one_smul_tensorPow` に替えた。三回のレビューで必須の指摘が無くなるまで直した。lake build・check-no-sorry・check-end-to-end・check-docs-references 通過。次は `trace_V_plus_is_positive`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百二十三個目として、人手 `V_plus_is_positive_definite` の名前だけの根拠を直した（主張の値は不変）。Step 1 の `(V_1^{(+)})^{1/2}` の鎖を 9 行に分け、`S_1^{(+)}`・`S_2` を `i(K_1)_ℂH_1^{(+)}`・`i(K_2^*)_ℂH_2` に揃え、Step 3 を鎖にした。i/2 の読みが本文で三通りあったので、`def_V1_plus_square_root` に `i/2 := i·2_ℂ^{-1}` を書き、新しい主張 `real_inclusion_of_one_half_is_inverse_of_two`（`(1/2)_ℂ = 2_ℂ^{-1}`）でつなぎ、`symmetrized_transfer_matrix_on_sectors`・`trace_of_epsilon_V_plus` を合わせた。Lean は `VPlus_eq_smul` を人手と 1 対 1 の 7 段にし、`real_inclusion_half_eq_inv_two` を足した。SageMath は 3 か所。七回のレビューで必須の指摘が無くなるまで直した。`VPlus_posDef` が 1 対 1 でない件などは状態台帳に残した。次は `V_plus_is_invertible`。

2026-11-04: 全証明の SageMath 検算として、`epsilon_anticommutes_with_check_Z_Y`（ε は Ž・Y̌・ψ̌ と反可換、ň・Q̌ と可換）に検算 `sagemath/check/epsilon_anticommutes_with_check_Z_Y/` を付けた（未検算 30 件）。(1) を QQ(i)、(2) の鎖を QQ(ζ_{4M})（M_col ≤ 5）、(3) の鎖を不定元の係数で、(3)(4) の全ての鎖を本文の ψ̌ で数体に厳密に確かめた。人手証明の計算の誤りは無し。根拠の誤り（本文に無い「epsilon_commutes_with_transfer_matrices の Step 1」、Ž の定義でない def_half_integer_modes）を直し、散文を一行ずつの鎖にした（主張は不変）。Lean の ClaimEpsilonAnticommutesWithCheckZY.lean は新しい鎖と 1 対 1 でない（Lean の連続実行の受け持ち）。次は `epsilon_eigenvalue_on_check_Q`。

2026-11-04: 全証明の SageMath 検算として、`max_eigenvalue_of_V_plus_simple`（Λ̌_max = Λ^{(1/2)}_{M_col} であり単純固有値）に検算 `sagemath/check/max_eigenvalue_of_V_plus_simple/` を付けた（未検算 31 件）。050 の (1)〜(3) の検算 4 本を内容の名前で移し、実際の V^{(+)} と本文の ψ̌ の Q̌_ε で主張 (1)(2)(3) と鎖を E_1・QQbar・AA で厳密に確かめる検算を足した（等号 759・不等号 120・否定 30。固有多項式の根の全体が {Λ̌_ε}、最大の根が Λ̌_max で重複度 1、固有空間が im Q̌_{(1,…,1)}）。人手証明の計算の誤りは無し。(2) の散文を (∵) 付きの鎖と def_second_transfer_matrix_prefactor の参照にした（主張は不変）。Lean の checkBigLambda_lt_checkBigLambda_univ の (2s_2)^{M/2} > 0 は旧い論法のままで 1 対 1 でない（Lean の連続実行の受け持ち）。次は `epsilon_anticommutes_with_check_Z_Y`。

2026-11-04: 全証明の SageMath 検算として、`constant_c_value_even_sector`（c = ((2s_2)^{M_col/2})_ℂ）に検算 `sagemath/check/constant_c_value_even_sector/` を、Step 2 の散文から切り出した新しい主張 `conjugation_commutes_with_matrix_exp`（T_B(exp(X)) = exp(T_B(X))）に検算 `sagemath/check/conjugation_commutes_with_matrix_exp/` を付けた（未検算 32 件）。本文の ψ̌ から作った V̌' で c を成分の比から作り、Step 3〜5 と c = a を QQbar で厳密に確かめた（等号 438・否定 18。準備・Step 1・2 は等号 328・否定 52）。人手証明の計算の誤りは無し。各段を鎖に、ℂ の商を逆元の積に、符号の確定を positive_real_square_injective に直した（値は不変）。Lean の ClaimConstantCEvenSector・NecSuf/ConstantC は旧い道筋のままで 1 対 1 でない（Lean の連続実行の受け持ち）。次は `max_eigenvalue_of_V_plus_simple`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百二十二個目として、人手 `trace_of_check_Vprime` の Step 4 の (4c) を行った。主張文と表題を `tr(V̌') = tr((V̌')^{-1}) = (Π_μ 2cosh(γ(θ̃_μ)/2))_ℂ` と `Π_μ 2cosh(γ(θ̃_μ)/2) ∈ ℝ_{>0}` に書き分け（ℂ の値に `> 0` を書いていたのをやめた。値は不変）、Step 4 の最後の鎖を ℝ の不等号だけにし、Step 5 に Step 1 の鎖・`real_inclusion_preserves_sum_over_binary_words`・Step 2 の鎖の 3 行の鎖と、主張の等号を Step 3・Step 5 の鎖で組む 2 行を置いた。Lean は人手と 1 対 1 の `CheckFermiSetup.trace_Vprime_step5`・`prod_two_cosh_half_pos_step4` を足し、`trace_Vprime_pos` の `M = r + 1` を `trace_Vprime` を通らずにこの 2 つで組んだ（型は不変）。SageMath は `sagemath/check/trace_of_check_Vprime/check_step5_chain.sage`（等号 9、不等号 3、否定コントロール 10）。一回のレビューで必須の指摘は無く、任意の指摘のうち最後の段落の鎖化、Lean の古い説明、否定コントロールの説明を直した。残した任意の指摘: 下流 `constant_c_value_even_sector` が `tr(V̌') = tr((V̌')^{-1}) > 0`・`tr(V̌') ∈ ℝ_{>0}` を引いたままで、主張の新しい形（`(r)_ℂ`、`r ∈ ℝ_{>0}`）に合わせる（そのブロックを扱うときに）。次は同じファイルの `V_plus_is_positive_definite` から文書順に名前だけの根拠を棚卸しする。

2026-11-04: 全証明の SageMath 検算として、`trace_V_plus_is_positive`（tr(V^{(+)}) ∈ ℝ_{>0}）に検算 `sagemath/check/trace_V_plus_is_positive/` を付けた（未検算 33 件）。実際の V^{(+)} で証明の二行と主張を AA・QQbar で厳密に確かめる検算と、有理数の結合定数で def_exp の部分和のボールで確かめる検算。人手証明の計算の誤りは無し。散文の証明を (∵) 付きの二行にし、主張と準備に出典（`def_hermitian_positive_definite`・`inclusion_rr_to_cc`・`def_jordan_wigner_Z_matrices`）を書いた。Lean の `trace_VPlus_pos` は mathlib の `PosDef.trace_pos` へ委ねている（Lean の連続実行の受け持ち）。次は `constant_c_value_even_sector`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百二十一個目として、人手 `trace_of_check_Vprime` の Step 4 の (4b) を行った。本文に主張 `finite_product_of_positive_reals_is_positive`（正の実数の有限積は正、`000_calculation_formulae_20_29.ts`）を足し、Step 4 の最後の行の名前だけの根拠「正数の有限積は正」をそれへのラベル参照にした（主張は不変）。Lean は具体版 `Ising2D.finite_product_of_positive_reals_is_positive`（人手の行と 1 対 1）、必要十分版 `NecSuf.finProdLeft_pos'`（`Mul`・`Zero`・`LT` と「`0<a`・`0<b` なら `0<ab`」だけ）、導出を置き、`trace_Vprime_pos` の `M = r + 1` の `Finset.prod_pos` を外した。SageMath は `sagemath/check/finite_product_of_positive_reals_is_positive/`。次は (4c)（Step 4 の最後の鎖の 1 行目 `tr(V̌') = Π 2cosh`（∵ Step 1--2）を ℂ と ℝ の値の包含 `(·)_ℂ` を通す形にする）。

2026-11-04: 全証明の SageMath 検算として、`V_plus_is_invertible`（V^{(+)} の逆行列の明示）に検算 `sagemath/check/V_plus_is_invertible/` を付けた（未検算 34 件）。050 の check_10・check_27 を移し、実際の指数行列で Step 1〜3・最後の行・主張を QQbar で厳密に確かめる検算と def_exp の部分和のボールの検算を足した。人手証明の計算の誤りは無し。Step 1 を `matrix_double_negation`・`exp_of_negative_is_left_inverse` の鎖に、(2s_2)^{-M_col/2} を主張で ℝ の逆数として定義、最後の段落を `def_invertible_elements_of_R` を引く二行にした。Lean は Step 1 の calc を合わせ、`VPlus_isUnit_and_inv_eq` を足した。次は `trace_V_plus_is_positive`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百二十個目として、人手 `trace_of_check_Vprime` の Step 4 を (4a) 各 μ の鎖と `cosh_at_least_one` の Lean、(4b) 正数の有限積は正の主張、(4c) 最後の鎖の ℂ と ℝ の値の包含、の三つに割り、(4a) を行った。人手は変えていない。人手 `cosh_at_least_one` の具体版 `Ising2D.cosh_at_least_one`（含意の 3 式と鎖の 3 行と 1 対 1）、必要十分版 `NecSuf.one_add_two_mul_sq_ge_one'`（全順序の半環と `ExistsAddOfLE`・`PosMulMono`・`AddLeftMono` だけ）、導出 `cosh_at_least_one_of_necSuf` を置き、Step 4 の各 μ の 3 行 `2cosh(γ/2) ≥ 2·1 = 2 > 0` を `CheckFermiSetup.two_cosh_half_step4` にして `trace_Vprime_pos` が使う（`Real.cosh_pos`・`linarith` を外した）。次は (4b)。

2026-11-04: Lean の通しの証明のゴールラインの確認の百十九個目として、人手 `trace_of_check_Vprime` の Step 3 の (3d) を行った。最後の行の名前だけの根拠「Step 1--2 の V̌' のトレース表示」を、Step 2 の鎖・`real_inclusion_preserves_sum_over_binary_words`・Step 1 の鎖をそれぞれ右辺から左辺へ当てる 3 行にした（主張は不変）。Lean は `trace_Vprime_inv` の `M = r + 1` の最後の段を人手の 18〜22 行目と 1 対 1 の 5 段にし、人手 `cosh_is_even` の具体版 `Ising2D.cosh_is_even`（`ClaimCoshIsEven.lean`）・必要十分版 `NecSuf.symmetrized_sum_is_even'`・導出を置いた。SageMath は `trace_of_check_Vprime/check_step3_final_lines.sage`。次は Step 4（「cosh x ≥ 1」「正数の有限積は正」と、`tr(V̌') = Π 2cosh` が ℂ の値と ℝ の値を (·)_ℂ を通さずに結んでいる件）。

2026-11-04: Lean の通しの証明のゴールラインの確認の百十八個目として、人手 `trace_of_check_Vprime` の Step 3 の (3c) を行った。名前だけの根拠「Step 2 を γ → −γ として適用」を、冒頭の `exp(−ǧ(ε)) = Π_μ exp((−γ(θ̃_μ))(ε_μ − 1/2))` の 4 行の鎖（新しく足した主張 `finite_sum_of_negated_real_numbers` を引く）と、トレースの鎖の 10〜17 行目（Step 2 の展開と 6 行を γ → −γ で書き下したもの）にし、Step 3 を 1 つの鎖にした（主張は不変）。Lean は人手と 1 対 1 の `CheckFermiSetup.exp_neg_gval_step3_product`・`sum_exp_neg_gval_step3_expansion` と `prod_step2_cosh` を −γ で使う段、`finite_sum_of_negated_real_numbers` の具体版・必要十分版（明示の仮定 `-(a + b) = -a + -b` だけ）。SageMath は `finite_sum_of_negated_real_numbers/` と `trace_of_check_Vprime/` の `check_step3_exp_product.sage`・`check_step3_expansion_and_cosh.sage`。残りは (3d)（最後の `= tr(V̌')` の行と、Lean の `trace_Vprime_inv` の最後の段）。

2026-11-04: 全証明の SageMath 検算として、`V_plus_is_positive_definite`（V^{(+)} は正定値）に検算 `sagemath/check/V_plus_is_positive_definite/` を付けた（未検算 35 件）。K_1 = 2 log y・K_2 = log x と選んで Step 1〜3 の全ての行と主張を AA で厳密に、同じ行を def_exp の部分和のボールでも確かめた。人手証明の計算の誤りは無し。根拠を三か所直した（Step 1 の最後の段落を `scalar_multiple_factors_out_of_right_factor`・`..._left_factor` の鎖に、S_2 のエルミート性を `real_symmetric_matrix_is_hermitian` に、係数の正値性に `def_second_transfer_matrix_prefactor`）。Lean はコメントの根拠名だけ合わせた。次は `V_plus_is_invertible`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百十七個目として、人手 `trace_of_check_Vprime` の Step 3 の (3b) を行った。`tr((V̌')^{-1})` を、Step 1 と同じ根拠で 5 行目だけ `eigenvalues_of_inverse_of_check_Vprime` を引く 8 行と `real_inclusion_preserves_sum_over_binary_words` の 1 行の 9 行の鎖で `(Σ_ε exp(−ǧ(ε)))_ℂ` にした（主張は不変）。Lean は人手と 1 対 1 の `CheckFermiSetup.trace_Vprime_inv_step3`、SageMath は `sagemath/check/trace_of_check_Vprime/` の `check_step3_chain.sage`（1〜8 行、SageMath の連続実行が先に足した）と `check_step3_real_inclusion.sage`（9 行目）。残りの「Step 2 を γ → −γ として適用」「Step 1--2 の V̌' のトレース表示」は (3c)・(3d)。

2026-11-04: 全証明の SageMath 検算として、`trace_of_check_Vprime`（tr(V̌') = tr((V̌')^{-1}) = Π 2cosh(γ/2) > 0）に検算 `sagemath/check/trace_of_check_Vprime/` を付けた（未検算 36 件）。050 の Step 1・Step 2 の 5 本を内容の名前で移し（件数は元と一致）、Step 3 の行列の部（(V̌')^{-1} での Step 1 の鎖の繰り返し、−X̌）、Step 3・4 の値、主張そのもの、本文の ψ̌ での実行を足した。人手証明の計算の誤りは無し。Step 4 の cosh x ≥ 1 の根拠を性質を持たない `cosh_sinh_basic_properties` から `cosh_at_least_one` に直し、Step 3 の「cosh は偶関数」を `cosh_is_even` を引く行に分けた（Lean は不変）。三回のレビューで必須の指摘が無くなるまで直した。次は `V_plus_is_positive_definite`。

2026-11-04: 全証明の SageMath 検算として、`eigenvalues_of_inverse_of_check_Vprime`（(V̌')^{-1}Q̌_ε = (exp(−ǧ(ε)))_ℂQ̌_ε）に検算 `sagemath/check/eigenvalues_of_inverse_of_check_Vprime/` を付けた（未検算 37 件）。050 の旧い検算を移して行列の部と実数の値の部に分け（模型の段数は元と一致）、主張そのものの検算と本文の ψ̌（M_col = 2, 3）で走らせる検算を足した。人手証明の計算の誤りは無し。次は `trace_of_check_Vprime`（状態台帳の「次の一歩」）。

2026-11-04: 全証明の SageMath 検算として、`eigenvalues_of_check_Vprime`（V̌' の固有値）に検算 `sagemath/check/eigenvalues_of_check_Vprime/` を付けた（未検算 38 件）。050 の 7 本を内容の名前で移し（模型の段数は元と一致）、ň_μ・γ_μ の供給元 `_vprime_settings.sage` で本文の ψ̌（M_col = 2, 3）でも同じ鎖を確かめ、主張そのもの（対角化と固有値の重複度、正値、縮退の組の実在）の検算を足した。人手証明は主張文を「im Q̌_ε の 0 でない各元は固有ベクトル」に直し、直和の段落に (4) の参照を足した（計算の誤りは無し）。次は `eigenvalues_of_inverse_of_check_Vprime`（Lean の連続実行が足した新しい主張）。

2026-11-04: 全証明の SageMath 検算として、`check_joint_eigenspace_decomposition`（ň_μ の同時固有空間分解）に検算 `sagemath/check/check_joint_eigenspace_decomposition/` を付けた（未検算 38 件）。050 の番号付きの 10 本を内容の名前で移し（模型で 12486 段、元と一致）、ň_μ の供給元を `_number_operators.sage` で模型と本文の ψ̌ に切り替えられるようにして、本文の ψ̌（M_col = 2, 3）でも同じ鎖と主張を厳密に確かめた（鎖 8998 段・主張 654 件）。主張 (1)〜(5) そのものの厳密な検算も足した。人手証明の計算の誤りは無し。次は `eigenvalues_of_check_Vprime`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百十六個目として、人手 `trace_of_check_Vprime` の Step 3 の名前だけの根拠「Step 1〜2 を γ → −γ として適用」を扱い始めた。本文の `V̌'`・`ǧ` は `γ(θ̃_μ)` に固定した記号で代入できる主張が無いので、Step 3 を (3a)〜(3d) に割り、(3a) として新しい主張 `eigenvalues_of_inverse_of_check_Vprime`（`(V̌')^{-1}Q̌_ε = (exp(−ǧ(ε)))_ℂQ̌_ε`。`eigenvalues_of_check_Vprime` と `(V̌')^{-1}V̌' = I` からの 11 行の鎖）を `trace_of_check_Vprime` の直前に足した（Step 3 本体はまだ変えていない）。Lean は人手と 1 対 1 の `CheckFermiSetup.Vprime_inv_mul_Qproj`（`ClaimTraceCheckVprime.lean`）。必要十分版は置かない。SageMath は 050 の check_eigenvalues_of_inverse_of_check_Vprime（厳密に 308 行、球で 1488 行、否定コントロール 84 件）。一回のレビューで必須の指摘は無く、任意の指摘 5 件を直した。次は (3b)（Step 3 のトレースの鎖）。

2026-11-04: Lean の通しの証明のゴールラインの確認の百十五個目として、人手 `trace_of_check_Vprime` の Step 2 の最後の 2 行（「`1 − 1/2 = 1/2`、`0 − 1/2 = −1/2` と ℝ の和の交換則」「`cosh x = (exp x + exp(−x))/2`」）を、ℝ の `1 − 1/2 = 1/2`・`0 − a = −a`・`a(−b) = −(ab)`・`a·(1/2) = a/2`・`b = 2·(b/2)` と `def_cosh_sinh` を右辺から左辺へ引く 6 行にした（主張は不変。和の交換の行は要らなくなった）。Lean は人手の 6 行と 1 対 1 の `CheckFermiSetup.prod_step2_cosh` を置き、`trace_Vprime` の `M = r + 1` を Step 1・Step 2 の全行と 1 対 1 の段だけで通した。SageMath は 050 の check_trace_of_check_Vprime_step2_cosh。三回のレビューで、残った必須の指摘は無い（二回目の必須の指摘は同名の別の定理の読み違いで、文言だけ限った）。次は Step 3（「Step 1〜2 を γ → −γ として適用」「cosh は偶関数」）。

2026-11-04: 全証明の SageMath 検算として、`trace_of_check_number_operator_product`（ň_μ と I − ň_μ の積のトレースは 2^{M_col−k}）に検算 `sagemath/check/trace_of_check_number_operator_product/` を付けた（未検算 39 件）。050 の check_47 を移して鎖の組み立てを `_chains.sage` へ出し（33321 段で元と一致）、本文の ψ̌ を一つの数体 K := E_1 に置いて同じ鎖と主張を厳密に確かめる `check_with_check_psi.sage` を足した（M_col = 2, 3、12354 件）。人手証明の計算の誤りは無し。二回のレビューで必須の指摘 2 件と任意の指摘 4 件を直した。次は `check_joint_eigenspace_decomposition`。

2026-11-04: 全証明の SageMath 検算として、`check_number_operator_idempotent`（ň_μ^2 = ň_μ）と `check_number_operators_commute`（ň_μň_ν = ň_νň_μ）に検算 `sagemath/check/check_number_operator_idempotent/`・`sagemath/check/check_number_operators_commute/` を付けた（未検算 40 件）。050 の check_28・check_29・check_23（二つに分けた）を移し、本文の ψ̌ を数体の行列として作って同じ鎖を厳密に確かめる検算を足した（M_col = 2, 3）。人手証明の計算の誤りは無かった。次は `trace_of_check_number_operator_product`（050 の check_47 を移す）。詳細は docs/tasks/sagemath-every-proof-state.md。

2026-11-04: 全証明の SageMath 検算として、`sign_flip_conjugation`（符号反転共役 U）に検算 `sagemath/check/sign_flip_conjugation/` を付けた（未検算 42 件）。050 に番号付きで在った各行の検算 12 本（check_09・check_11〜21）を内容の名前で移し（中身は不変、旧い名前との対応は overview の「由来」）、主張そのものと Step 4 の最後の段落の検算（`M_col = 2..6`、`QQ(i)` の厳密等号 218 段）を足した。人手証明の計算の誤りは無し。最後の段落が文章だけの推論である件を状態台帳の「本文の誤り」に記録した。次は `check_number_operator_idempotent`。

2026-11-04: Lean の通しの証明のゴールラインの確認の百十四個目として、人手 `trace_of_check_Vprime` の Step 2 の名前だけの根拠「直前の積表示と、有限個の因子の積の展開」を、直前の鎖を各項へ入れる行と、新しい主張 `expansion_of_finite_product_of_two_term_sums_of_real_numbers`（`002_linear_space_general.ts`。帰納法の段が引く `real_sum_over_binary_words_distributes_in_left_factor` も足した）を右辺から左辺へ引く行の 2 行にした（主張は不変）。Lean は具体版 `binaryWordRealSum_mul`・`expansion_of_finite_product_of_two_term_sums_of_real`（`ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbers.lean`）、既存の必要十分版からの導出、人手と 1 対 1 の `CheckFermiSetup.sum_exp_gval_step2_expansion` を置き、`trace_Vprime` を `M = r + 1` でそれ経由にした。SageMath は新しい 2 ディレクトリと 050 の check_trace_of_check_Vprime_step2_expansion。次は Step 2 の (2d)（`exp(γ(1 − 1/2)) + exp(γ(0 − 1/2)) = exp(−γ/2) + exp(γ/2)` と cosh の行）。

2026-11-04: Lean の通しの証明のゴールラインの確認の百十三個目として、人手 `trace_of_check_Vprime` の Step 2 の名前だけの根拠「実数の指数法則（`theorem_exp_product` (n=1)）」を、`ǧ` の定義を開く行と新しい主張 `real_exp_of_finite_sum`（`003_exp_linear_map.ts`。`scalar_exp_product` を引く `m` の帰納法）を引く行の 2 行の鎖にした（主張は不変）。定義 `def_finite_product_of_real_numbers`（`000_calculation_formulae_20_29.ts`）を足した。Lean は具体版 `real_exp_of_finite_sum`（`MathematicalTools/MatrixExponentialAndCommutators/ClaimRealExpOfFiniteSum.lean`）、必要十分版 `NecSuf.map_finSumLeft`（`NecSuf/AdditiveToMultiplicativeMapOfFiniteSum.lean`）と導出、人手と 1 対 1 の `CheckFermiSetup.exp_gval_step2_product` を置き、`exp_gval_eq_prod` を `M = r + 1` でそれ経由にした。SageMath は `sagemath/check/real_exp_of_finite_sum/` と 050 の check_trace_of_check_Vprime_step2_exp_product。次は Step 2 の (2c)（有限個の因子の積の展開の ℝ 版）。

2026-11-03: Lean の通しの証明のゴールラインの確認の百十二個目として、人手 `trace_of_check_Vprime` の Step 2 の先頭に、Step 1 の ℂ の和 `Σ_ε (exp ǧ(ε))_ℂ` を ℝ の和の包含 `(Σ_ε exp ǧ(ε))_ℂ` へ移す 1 行を置いた（主張は不変）。本文に主張 `real_inclusion_preserves_sum`（`000_calculation_formulae_00_09.ts`）、定義 `def_sum_over_binary_words_of_real_numbers` と主張 `real_inclusion_preserves_sum_over_binary_words`（`002_linear_space_general.ts`）を足した。Lean は具体版 `real_inclusion_add`・`binaryWordRealSum`・`binaryWordComplexSum_ofReal`、必要十分版 `NecSuf.binWordSum_map`（`f := ↑`）からの導出、具体版から運んだ系 `binWordSum_ofReal` を置き、`CheckFermiSetup.trace_Vprime` の運ぶ段をそれ経由にした。SageMath は `real_inclusion_preserves_sum/`・`real_inclusion_preserves_sum_over_binary_words/` と 050 の check_trace_of_check_Vprime_step2_real_inclusion。次は同じ Step 2 の指数法則の行（状態台帳の「次の一歩」）。

2026-11-03: Lean の通しの証明のゴールラインの確認の百十一個目として、人手 `trace_of_check_Vprime` の Step 1 を、名前だけの根拠から 1 行 1 主張の 8 行の鎖にした（主張は不変）。本文に定義 `def_sum_over_binary_words_of_complex_numbers`、主張 `trace_of_sum_over_binary_words`・`trace_of_scalar_multiple` を足した。Lean は具体版 `trace_binaryWordMatrixSum`・`trace_of_scalar_multiple`（`ClaimTraceOfSumOverBinaryWords.lean`）と `CheckFermiSetup.trace_Vprime_step1`、必要十分版は `NecSuf.binWordSum_map` からの導出。SageMath は新しい 2 ディレクトリと 050 の check_trace_of_check_Vprime_step1_chain。次は同じブロックの Step 2（ℂ の和と ℝ の和の食い違いを含む。状態台帳の「次の一歩」）。

2026-11-03: Lean の通しの証明のゴールラインの確認の百十個目として、人手 `eigenvalues_of_check_Vprime` を棚卸しし、証明の最後の段落の名前だけの根拠「`exp(ǧ(ε)) > 0`」を `real_exp_positive`（`x → ǧ(ε)`）を引く 1 行にした（主張は不変。`ǧ` の定義の和は `def_finite_sum_of_real_numbers`）。Lean に人手 `real_exp_positive` の具体版 `Ising2D.real_exp_positive`（`MathematicalTools/MatrixExponentialAndCommutators/ClaimRealExpPositive.lean`）と必要十分版 `NecSuf/PositivityOfAdditiveToMultiplicativeMap.lean`・導出を置き、`CheckFermiSetup.exp_gval_pos` をそれ経由にした。SageMath は 050 の check_eigenvalues_of_check_Vprime_positivity。Step 4 の最後の直和と対角化の段落は「直和を定めるブロックが無い」件に残した。人手の exp と mathlib の `Real.exp` の一致を Lean で示していない件を状態台帳に足した。次は同じファイルの `trace_of_check_Vprime` から棚卸しを続ける。

2026-11-03: 全証明の SageMath 検算として、`iH_is_real_symmetric`（S_1^{(+)}・S_2 は実対称でエルミート）に検算 `sagemath/check/iH_is_real_symmetric/` を付けた（未検算 43 件）。050 に番号付きで在った各行の検算 11 本（check_22・check_37〜46）を内容の名前でこのディレクトリへ移し、レビューの必須の指摘（転置の鎖の否定コントロールが Y_1Z_2 と称して σ_1^yσ_2^z を見ていた）を直した。人手証明は Step 0 の使われていない可換性の文を外しただけ（主張は不変、計算の誤りは無し）。二回のレビューで必須の指摘が無くなった。次は `sign_flip_conjugation`（050 の check_09・check_11〜21 を同じく移す）。

2026-11-03: Lean の通しの証明のゴールラインの確認の百九個目として、人手 `check_joint_eigenspace_decomposition` を棚卸しし、証明の冒頭で根拠なしに置いていた `Q̌_ε = ∏R_μ^{(ε_μ)}` を、定義の因子 `ε_μň_μ + (1−ε_μ)(I−ň_μ)` が `R_μ^{(ε_μ)}` に等しいことの二場合の 10 行の鎖と、各因子へ同時に適用する 2 行の鎖にした（主張は不変）。Lean に人手と 1 対 1 の `defFactor_one`・`defFactor_zero`・`defFactor_eq_rFactor`・`Qproj_eq_finProdLeft_rFactor` を置き、SageMath は 050 の check_48。次は同じファイルの `eigenvalues_of_check_Vprime` から棚卸しを続ける（状態台帳 `docs/tasks/lean-end-to-end-state.md` の「次の一歩」）。

2026-11-03: Lean の通しの証明のゴールラインの確認の百八個目として、人手 `trace_of_check_number_operator_product`（ň とその補の積のトレース）の名前だけの根拠（「分配則とトレースの線型性」、因子ごとの可換性から積との可換性を言う散文、巡回性の行の結合律）を 1 行 1 主張の鎖にし、帰納法を有限積の定義どおり最後の因子を分ける形にした（主張は不変）。Lean に人手と 1 対 1 の具体版 `CheckFermiSetup.trace_projFactor_finProdLeft` と同じ手順の必要十分版 `NecSuf/TraceOfNumberOperatorProductByLastFactor.lean`・導出を置き、`tr(Q̌_ε) = 1` の鎖 `trace_Qproj_step4` をそれ経由にした。SageMath は 050 の check_47。二回のレビューの指摘を直した。次は同じファイルの `check_joint_eigenspace_decomposition` から棚卸しを続ける。

2026-11-03: 全証明の SageMath 検算として、`def_check_number_operator`（ň_μ := ψ̌_μ^† ψ̌_{M_col+1−μ} の定義と、共役添字の対合・X̌ と V̌' の書き換え）に検算 `sagemath/check/def_check_number_operator/` を付けた（未検算 44 件）。(1) の対合は `ZZ[M, μ]` と M_col = 2..40 の `ZZ` で、(2) の X̌ の鎖は γ を独立な不定元に置いて数体 E_μ の中で厳密に、γ の実際の値の X̌ と V̌' = exp(X̌) はボールで確かめた。人手証明の散文を等号の鎖に替え、主張 (2) の実数係数を (·)_C で書き、主張 (1) の根拠の取り違え（対合から添字の帰属を出していた）を直した（計算の誤りは無し、中身は不変）。二回のレビューで指摘が無くなるまで直した。次は `iH_is_real_symmetric`。

2026-11-03: 全証明の SageMath 検算として、`T_V_plus_eq_T_check_Vprime`（T_{(V^{(+)})} = T_{(V̌')}）に検算 `sagemath/check/T_V_plus_eq_T_check_Vprime/` を付けた（未検算 45 件）。V̌' を含まない行（復元公式、準備 1 の第 1 の鎖、Step 1 の第 1〜第 6 等号、Step 2 の V^{(+)} の側）は数体 F の中で厳密に、V̌' を含む行と主張（全ての行列単位と標本）は V̌' = exp(X̌) をボールで囲んで、結合定数 3 組 × M_col = 2..4 で確かめた。人手証明を一ステップ一定理の鎖に書き直した（計算の誤りは無し、主張は不変）: 旧 Step 1 の「単位的環準同型かつ線型」を、def_T_g の T_g・def_check_Vprime (2) の T_{(V̌')} と mat_conj の T'_g を結ぶ準備 1 の鎖に替え、復元公式を recover_Z_Y_from_check_Z_Y の主張の形にそろえ、旧 Step 2 の線型性 1 行を 13 個の等号に開き、閉包を Z_Y_generate_algebra の (iii) に合わせて和とスカラー倍に分けた。二回のレビューで指摘が無くなるまで直した。Lean は触っていない（このモジュールの lake build・check-no-sorry.sh は通る）。

2026-11-03: Lean の通しの証明のゴールラインの確認の百七個目として、`iH_is_real_symmetric` の (i3e) を行った。使う側が引く `S1plus_isHermitian`・`S1plus_transpose`・`S2_isHermitian`・`S2_transpose` を `ClaimPositiveDefinite.lean` から `ClaimIHPauliForm.lean` の末尾へ移し、`M_col ≥ 2` では人手の Step 3 の鎖（因子ごとの転置と成分の実性 → 実対称 → エルミート）そのものにした（型は不変。係数 `star K = K` は `real_coefficient_of_star_eq` で `(K.re)_ℂ` に読む。人手の主張の範囲外の `M ≤ 1` は反可換性の補助で埋める）。旧 `S2_isHermitian` の証明は `S2_isHermitian_by_anticommutation` として整数運動量の経路の `Vmat_posDef` 用に残した。人手証明と SageMath は不変。これで `iH_is_real_symmetric` の件は済んだ。

2026-11-03: Lean の通しの証明のゴールラインの確認の百六個目として、`iH_is_real_symmetric` の (i3d3) 実対称 ⇒ エルミートを行った。`def_hermitian_positive_definite` の最後の段落（定義の中の主張）を、定義 `def_real_symmetric_complex_matrix` と主張 `real_symmetric_matrix_is_hermitian`（6 行の成分の鎖）に切り出し（009）、それを引いていた `iH_is_real_symmetric` Step 3・`V_plus_is_positive_definite` Step 2・`W_is_real_symmetric_positive_definite` Step 2 を新しいラベルを引く形にした（主張は不変）。Lean は具体版 `ClaimRealSymmetricMatrixIsHermitian.lean`・定義 `DefinitionRealSymmetricComplexMatrix.lean`、必要十分版 `NecSuf/HermitianOfStarFixedSymmetricEntries.lean` と導出、`S2_isHermitian_of_real_symmetric`・`S1plus_isHermitian_of_real_symmetric`（`ClaimIHPauliForm.lean`）。SageMath は `real_symmetric_matrix_is_hermitian/` と 050 の check_46。次は (i3e) Lean の `S1plus_isHermitian` ほかを人手の Step 3 の論法へ直す。

2026-11-03: 「2 次元 Ising 模型の厳密解（Onsager の自由エネルギー）」の証明で、二重極限から閉形式までの三段を一続きの式鎖にして、各等号の根拠を行末に明記した。主張と使用する根拠は不変。

2026-11-03: Lean の通しの証明のゴールラインの確認の百五個目として、`iH_is_real_symmetric` の (i3d2) 成分の実性を行った。人手証明に主張 `sum_of_real_entry_matrices_has_real_entries`・`difference_of_real_entry_matrices_has_real_entries`・`finite_sum_of_real_entry_matrices_has_real_entries`（002）を足し、主張と Step 1〜3 の係数の位置の `K_1, K_2^* ∈ ℝ` を `(K_1)_ℂ`・`(K_2^*)_ℂ` と明示し、Step 3 の結論の「実係数の有限和なので成分がすべて実数」をそれらと `real_scalar_multiple_of_real_entry_matrix_has_real_entries` を引く 2 段落に替えた（主張は不変）。Lean は具体版 `ClaimSumsOfRealEntryMatricesHaveRealEntries.lean`、必要十分版 `NecSuf/SumsOfClosedEntries.lean` と導出、鎖 `S2_hasRealEntries`・`S1plus_hasRealEntries`（`ClaimIHPauliForm.lean`）を人手と 1 対 1 で置いた。SageMath は `sagemath/check/` の 3 件と 050 の check_45。次は (i3d3) 実対称 ⇒ エルミート。

2026-11-03: Lean の通しの証明のゴールラインの確認の百四個目として、`iH_is_real_symmetric` の (i3d) を (i3d1) 転置・(i3d2) 成分の実性・(i3d3) 実対称 ⇒ エルミートに割り、(i3d1) を行った。人手証明に主張 `transpose_of_matrix_sum`・`transpose_of_matrix_scalar_multiple`・`transpose_of_matrix_difference`・`transpose_of_finite_sum_of_matrices`（002）を足し、Step 3 に `(S_2)^⊤ = S_2`（5 行）と `(S_1^{(+)})^⊤ = S_1^{(+)}`（7 行）の鎖を置いて、最後の段落の「転置について対称」をそれらを引く形にした（主張は不変）。Lean は具体版 `matrix_transpose_add`・`matrix_transpose_smul`・`matrix_transpose_sub`・`finite_sum_transpose_of_matrices`（`MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimTransposeOfMatrixSumsAndScalarMultiples.lean`）、必要十分版 `NecSuf/TransposeOfMatrixSums.lean` と導出・`TensorPow` の系、鎖 `S2_transpose_by_pauli_form`・`S1plus_transpose_by_pauli_form`（`ClaimIHPauliForm.lean`）を人手と 1 対 1 で置いた。SageMath は `sagemath/check/transpose_of_*` の 4 件と 050 の check_44。次は (i3d2)。

2026-11-03: 全証明の SageMath 検算として、`T_V_plus_eq_T_check_Vprime_on_check_Z_Y`（T_{(V^{(+)})} と T_{(V̌')} は Ž, Y̌ 上で一致する）に検算 `sagemath/check/T_V_plus_eq_T_check_Vprime_on_check_Z_Y/` を付けた（未検算 46 件）。準備は不定元と数体で、本体の T_{(V^{(+)})} 側は数体で厳密に、T_{(V̌')} を含む行と主張はボールで確かめた。人手証明は、他の証明の中の結合律と未証明の (A, B)I = (A, B) に頼っていた Step 1 を準備 1・準備 2 の 1 行 1 根拠の鎖に替え、Step 2・3 を一本の鎖にまとめた（中身は不変、計算の誤りは無し）。未解決: Lean の `checkZY_row_eq_rowMul_checkPmat_inv` は人手の準備 2 と 1 対 1 でない（状態台帳の申し送り）、`diagonalization_check_P_D` が P̌ の可逆性を主張していない（状態台帳の本文の誤り）。次は `T_V_plus_eq_T_check_Vprime`。

2026-11-03: Lean の通しの証明のゴールラインの確認の百三個目として、`iH_is_real_symmetric` の (i3c3) `G` の成分の実性を行った。人手証明に定義 `def_real_factor_of_pauli_y`（`R^y`）、主張 `pauli_y_is_i_times_real_factor`（`σ^y = iR^y`）・`real_factor_of_pauli_y_has_real_entries`（006）・`real_scalar_multiple_of_real_entry_matrix_has_real_entries`（002）を足し、Step 3 の `G` の段落を 7 行の鎖 `G = (-1)_ℂ(R^y⊠σ^x⊠⋯⊠σ^x⊠R^y)` とそれらを引く段落に替えた（主張は不変）。Lean は `pauliY_eq_I_smul_pauliYReal`・`pauliYReal_hasRealEntries`・`real_smul_hasRealEntries`（必要十分版 `NecSuf/ScalarMultipleOfClosedEntries.lean`）・`boundaryYXY_eq_neg_one_smul_real`・`boundaryYXY_hasRealEntries` を人手と 1 対 1 で置いた。SageMath は 3 件の新設と 050 の check_43。レビューの必須の指摘は無く、任意の指摘 3 件を直した。次は (i3d) 行列の和・スカラー倍の転置と実係数の和の成分の実性。

2026-11-03: 全証明の SageMath 検算として、`action_of_T_check_Vprime_on_check_psi`（T_{(V̌')} の ψ̌ への作用）に検算 `sagemath/check/action_of_T_check_Vprime_on_check_psi/` を付けた（未検算 47 件）。行列の代数の行は不定元と円分体上の多項式環で厳密に、exp の値に依る行はボールで確かめた。人手証明は、根拠のブロックなしに使っていた交換子の線型性・exp(cI) = exp(c)I・極限の一意性を準備 1〜8 の 1 行 1 根拠の鎖にし、Step 1・1' を commutator_via_anticommutators から、Step 3〜6 を [X̌, W] = cW の一般の W, c で一度だけ示す形にした（中身は不変、計算の誤りは無し）。主張は (exp(±γ))_C の形。未解決: Lean の matExp_conj_eigen は人手の Step 3〜6 と 1 対 1 でない（状態台帳の申し送り）。次は `T_V_plus_eq_T_check_Vprime_on_check_Z_Y`。

2026-11-03: 全証明の SageMath 検算として、`def_check_Vprime`（V̌' の定義）に検算 `sagemath/check/def_check_Vprime/` を付けた（未検算 48 件）。(1) は円分体と不定元の多項式環で厳密に、(2) は級数の段を厳密に、exp(±X̌) の値をボールで確かめた。人手証明の (1) が γ_2(−θ̃_μ) ≠ 0 の根拠に、それを述べない gamma_2_theta_tilde_nonzero を引いていた誤りを直し、(1)(2) を 1 行 1 根拠の鎖にした（中身は不変）。Lean は不変（(2) の対応の見直しを Lean の連続実行へ申し送り）。次は `action_of_T_check_Vprime_on_check_psi`。

2026-11-03: Lean の通しの証明のゴールラインの確認の百二個目として、`iH_is_real_symmetric` の (i3c2) を行った。人手証明に主張 `identity_matrix_of_order_two_has_real_entries`・`pauli_x_has_real_entries`・`pauli_z_has_real_entries` を足し、Step 3 の `σ_m^x`・`σ_m^zσ_{m+1}^z` の成分の実性と `epsilon_is_real_symmetric` の成分の実性を、それらと `kronecker_of_real_entry_matrices_has_real_entries` を引く形にした。Lean は `ClaimPauliMatricesHaveRealEntries.lean`・`sigmaX_hasRealEntries`・`sigmaZ_castSucc_mul_sigmaZ_succ_hasRealEntries`・`epsilon_hasRealEntries` を人手と 1 対 1 で置き、`epsilon_is_real_symmetric` の型を `MatrixHasRealEntries` で述べ直した。SageMath は 5 件。次は (i3c3) `G` の成分の実性。

2026-11-03: Lean の通しの証明のゴールラインの確認の百一個目として、`iH_is_real_symmetric` の (i3c) 成分の実性を (i3c1)〜(i3c3) に割り、(i3c1) 道具を行った。新しい定義 `def_matrix_with_real_entries`（成分がすべて `inclusion_rr_to_cc` の像）、主張 `finite_product_of_real_inclusions_is_real`（帰納法）と `kronecker_of_real_entry_matrices_has_real_entries` を人手証明に足し、Lean は `MathematicalTools/KroneckerProductAndMultiFactorBasis/` に人手と 1 対 1 の具体版（`real_inclusion_mul`・`finite_product_of_real_inclusions_is_real`・`MatrixHasRealEntries`・`siteProd_hasRealEntries`）、必要十分版 `NecSuf/KroneckerOfRealEntryMatrices.lean`（効いているのは積で閉じることだけ）と導出を置いた。`ClaimVPlusPositiveDefinite.lean` の `Complex.ofReal_mul` 2 か所を `real_inclusion_mul` に替えた。SageMath は 2 件（不定元で厳密）。レビューの必須の指摘 2 件と任意の指摘 3 件を直した。`lake build`・`check-no-sorry.sh`・`check-end-to-end.sh`・`check-docs-references.sh`・論文側 `npm run check`・対応検査は通る。次は (i3c2) `σ_m^x`・`σ_m^zσ_{m+1}^z` の成分の実性の鎖。

2026-11-03: 全証明の SageMath 検算として、`commutation_V_plus_check_psi`（V^{(+)} と ψ̌ の交換関係）に検算 `sagemath/check/commutation_V_plus_check_psi/` を付けた（未検算 49 件）。準備は不定元で、本体の 17 式と主張は M_col = 2..4 で数体の中で厳密に確かめた。人手証明は結合律の散文と定義の無い「行ベクトルへの作用」を射影 pr_l による根拠付きの鎖に直し、P̌^{-1}・Ď の成分・(exp(±γ))_C の読み方を明示した（中身は不変）。計算の誤りは無かった。Lean は注記のみ更新。次は `def_check_Vprime`。

2026-11-03: Lean の通しの証明のゴールラインの確認の百個目として、`iH_is_real_symmetric` の (i3b) Step 3 の転置の鎖を扱った。`σ_m^x`・`σ_m^zσ_{m+1}^z`・`G` の転置を名前だけで述べていたのを、5・5・11 行の鎖（`kronecker_transpose`・`transpose_of_*`・`negation_is_scalar_multiple_by_minus_one`・`kronecker_multilinear` 2 回・`scalar_multiple_is_associative`・`scalar_multiple_by_one`）に替えた（主張は不変）。Lean は `kronecker_transpose` の具体版 `siteProd_transpose_apply`/`siteProd_transpose` を `MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerTranspose.lean` に `calc` で置き、必要十分版 `NecSuf/KroneckerTranspose.lean` と導出を足し、`ClaimIHPauliForm.lean` に `sigmaX_transpose`・`sigmaZ_castSucc_mul_sigmaZ_succ_transpose`・`boundaryYXY_transpose` を人手と 1 対 1 で置いた。SageMath は 050 の check_41（306 段）。`check-end-to-end.sh` は通っている。次は (i3c) 成分の実性。

2026-11-03: Lean の通しの証明のゴールラインの確認の九十九個目として、`iH_is_real_symmetric` の (i3) Step 3（実対称性）を (i3a)〜(i3e) に割り、(i3a) 2 次の行列の転置を扱った。新しい主張 `transpose_of_identity_matrix_of_order_two`・`transpose_of_pauli_x`・`transpose_of_pauli_z`・`transpose_of_pauli_y`（`006_Z_Y_anticommutation.ts`）を足し、Step 3 冒頭の散文をその参照に替えた（主張は不変）。Lean は同名の 4 定理を `DefinitionTransferMatrixSymbols.lean` に人手と 1 対 1 の `calc` で置き、`matrix_transpose_apply`（`def_matrix_transpose`）を足した。SageMath は `sagemath/check/transpose_of_*` の 4 件（未検算は 50 件のまま）。`check-end-to-end.sh` は通っている。次は (i3b) `σ_m^x`・`σ_m^zσ_{m+1}^z`・`G` の転置の鎖。

2026-11-03: 全証明の SageMath 検算として、`anticommutator_of_check_psi`（ψ̌ の反交換関係）に検算 `sagemath/check/anticommutator_of_check_psi/` を付けた（未検算 50 件）。行列の鎖は円分体の行列で（準備 2 は係数を不定元に）、係数の鎖は一般の点のイデアル（対照つき）と、結合定数 4 組 × M_col = 2..6 の円分体に |γ_2| を添えた体で厳密に確かめた（浮動小数点・ボールなし）。人手証明は、散文の双線型性を `anticommutator_of_finite_sums_of_scalar_multiples` の展開に、`abs_basic_properties` が述べていない |−z| = |z|・|z̄| = |z| を成分の鎖に、場合分けと ℂ の符号・逆元の規則を鎖に直し、係数を u^∓・h と置いて包含の像と ℝ への脱出を明示した（中身は不変）。計算の誤りは無かった。Lean は不変（注記の段の名前の見直しは Lean の連続実行へ申し送り）。次は `commutation_V_plus_check_psi`。

2026-11-03: 全証明の SageMath 検算として、`periodicity_of_check_fermi`（γ_1, γ_2 の 2π 周期性、θ̃ の添字の M_col 周期性、共役添字 M_col+1−μ での γ_2 の入れ替え・γ_1・γ の不変性・P̌ の入れ替え）に検算 `sagemath/check/periodicity_of_check_fermi/` を付けた（未検算 51 件）。一般の点は鎖の各行を根拠の関係だけのイデアル・有理関数体で（対照つき）、具体値は結合定数 4 組 × M_col = 2..8 で円分体と QQbar により厳密に確かめた（浮動小数点・ボールなし）。人手証明は、本文に無い「exp(iθ) = cos θ + i sin θ」と cos の偶性を `euler_formula_cos_sin` からの準備の鎖に、「(1) が従う」「成分が書けることが分かる」の散文を γ_1・γ_2・γ・P̌ の鎖に直し、角度を像の記号 k_R で書き、P̌ の主張を行列で明示し、全実数上の cos・sin の周期性を前提とすることを主張に書いた（中身は不変）。計算の誤りは無かった。Lean は不変。次は `anticommutator_of_check_psi`。

2026-11-03: Lean の通しの証明のゴールラインの確認の九十八個目として、`iH_is_real_symmetric` の (i2d) Step 2 の境界項 `Y_{M_col}Z_1 = (-i)G` の鎖を扱った。名前だけの根拠（定義・`σ_1^z` は他の因子と可換・Step 0）と束ねた段を、準備の `Y_{M_col}`・`Z_1`・`G` のクロネッカー積表示と、1 行に 1 つずつ根拠を引く 8 行の鎖に替えた（主張は不変）。Lean は `Y_last_mul_Z_zero` を 1 対 1 の `calc` 8 段に、SageMath は 050 の check_40。`check-end-to-end.sh` は通っている。次は (i3) Step 3 の実対称性の論証ほか（状態台帳 `docs/tasks/lean-end-to-end-state.md`）。

2026-11-03: Lean の通しの証明のゴールラインの確認の九十七個目として、`iH_is_real_symmetric` の (i2c) Step 2 の `Y_mZ_{m+1} = (-i)σ_m^zσ_{m+1}^z` の鎖を扱った。名前だけの根拠（相異なる因子は可換・`σ^xσ^x = I`・Step 0）を、準備の `Y_m`・`Z_{m+1}`・`σ_m^zσ_{m+1}^z` のクロネッカー積表示と、1 行に 1 つずつ根拠を引く 9 行の鎖に替えた（主張は不変）。Lean は `sigmaZ_castSucc_mul_sigmaZ_succ_kronecker`（新規）と `Y_castSucc_mul_Z_succ` を 1 対 1 の `calc` に、SageMath は 050 の check_39。`check-end-to-end.sh` は通っている。次は (i2d) 境界項 `Y_{M_col}Z_1` の鎖（状態台帳 `docs/tasks/lean-end-to-end-state.md`）。

2026-11-03: Lean の通しの証明のゴールラインの確認の九十六個目として、`iH_is_real_symmetric` の (i2b) Step 1 の `Z_mY_m = (-i)σ_m^x` の鎖を扱った。名前だけの根拠（可換性で寄せる・`σ^xσ^x = I`・Step 0）を、準備の `Z_m`・`Y_m` のクロネッカー積表示（`site_pauli_prefix_product_kronecker_form`）と、`kronecker_product_rule` (1)・`pauli_matrix_products`・`identity_matrix_is_left_unit_of_mat_mult`・Step 0・`kronecker_multilinear`・`def_site_pauli_matrices` を 1 行に 1 つずつ引く 8 行の鎖に替えた（主張は不変）。Lean は `Z_mul_Y_same` を 1 対 1 の 8 段の `calc` に、SageMath は 050 の check_38。`check-end-to-end.sh` は通っている。次は (i2c) Step 2 の `Y_mZ_{m+1}` の鎖の根拠（状態台帳 `docs/tasks/lean-end-to-end-state.md`）。

2026-11-03: Lean の通しの証明のゴールラインの確認の九十五個目として、`iH_is_real_symmetric` の (i2) を四つに割り、(i2a) Step 0 の「相異なるサイトに置かれた σ_j^a・σ_k^b は可換」の散文を扱った。主張 `distinct_site_pauli_matrices_commute`（`partition_function_transfer_matrix_representation.ts`）を足し、場合分けの 3 つの鎖と `tensor_commutation_from_all_sites` を引く 3 行の鎖で示して、Step 0 をその参照にした。Lean は `tensor_commutation_from_all_sites` の具体版 `siteProd_commute_of_sitewise_commute`（新規）、`siteOp_mul_comm` を 1 対 1 の証明へ、必要十分版 `NecSuf/SitewiseCommute.lean` と導出 2 本。SageMath は `distinct_site_pauli_matrices_commute/`。次は (i2b) Step 1 の `Z_mY_m` の鎖の根拠（状態台帳 `docs/tasks/lean-end-to-end-state.md`）。

2026-11-03: Lean の通しの証明のゴールラインの確認の九十四個目として、`iH_is_real_symmetric` を割り、その (i1) Step 0 の三つの 2×2 の積を行った。「行列積の成分計算」「σ の行列表示」を `mat_mult`・`pauli_matrix_products`・`def_matrix_scalar_multiple` と ℂ の事実を 1 段に 1 つずつ使う鎖にし（`σ^zσ^y`・`σ^yσ^x` は `V1_in_Z_Y_epsilon` の Step 0 と同じ鎖、`σ^xσ^z = (-i)σ^y` は新しい 11 行）、準備に `(-i)·i = 1`・`(-i)·(-i) = -1` を置き、鎖の終わりを `(-i)σ` に揃えた。Lean は `pauliX_mul_pauliZ_eq` を 11 段の calc にし、`negI_mul_I_eq_one`・`negI_mul_negI_eq_neg_one` を足した。SageMath は 050 の check_37。次は (i2) Step 0 の可換性の散文と Step 1・Step 2 の鎖の「相異なる因子どうしは可換」「σσ = I」。

2026-11-03: Lean の通しの証明のゴールラインの確認の九十三個目として、`max_eigenvalue_of_V_plus_simple` (1) を行った。本文に有限集合の上の和の定義が無いので、`def_Theta_delta_M` を集合から添字 `μ` の族 `θ^{(δ)}_{M_col,μ}` へ、`def_Lambda_delta_M` の和を添字の和へ改め（Lean の `LambdaM` と一致、値は不変）、(1) を 4 行の鎖に、`onsager_free_energy_expression` の単射性と付け替えの段落を展開の 1 行にした。Lean は `checkBigLambda_univ_eq_LambdaM` を 4 段の calc に。SageMath は `050` の `check_max_eigenvalue_simple_step1_lambda_half_chain`。次は `iH_is_real_symmetric`（状態台帳 `docs/tasks/lean-end-to-end-state.md`）。

2026-11-03: Lean の通しの証明のゴールラインの確認の九十二個目として、`max_eigenvalue_of_V_plus_simple` の (n2) (3) の後半を行った。人手証明の名前だけの根拠「0 でない複素数なので割ることができて」「`x = Σ_ε Q̌_εx` の `ε ≠ (1,…,1)` の項が消え」「逆向きは `eigenvalues_of_V_plus` (1) と `eigenvalues_of_check_Vprime` の Step 4 と同じ計算」を、`d := (Λ̌_{ε'})_ℂ − (Λ̌_max)_ℂ` の差の 4 行・割り算の 5 行・項を消す 4 行・`Q̌y = y` の 8 行・`V^{(+)}y = Λ̌_max y` の 6 行の鎖にした（主張は不変）。Lean は `Qproj_mulVec_eq_zero_of_eigen`・`colVec_eq_Qproj_mul_of_zero`・`VPlus_mulVec_of_mem_range_Qproj_univ`（逆向きは Lean に無かった）と必要十分版 `NecSuf.act_eq_smul_of_proj_fixed`・導出、`NecSuf.eq_proj_of_eigen` の割り算の段の calc。SageMath は 050 の `check_max_eigenvalue_simple_step3_eigenspace_chains.sage`。次は (n3) (1) の `Θ^{(1/2)}_{M_col}` の元が相異なる散文と和の付け替え。

2026-11-03: 全証明の SageMath 検算として、`lambda_eq_exp_gamma_theta_tilde`（λ_{±,μ} = exp(±γ(θ̃_μ)) と λ_+ > 1 > λ_- > 0）に検算 `sagemath/check/lambda_eq_exp_gamma_theta_tilde/` を付けた（未検算 52 件）。一般の点は鎖の各行を根拠の関係だけのイデアルで、具体値は 140 組で円分体に |γ_2| を添えた体（等号）と AA（順序）により厳密に、t = arccosh(g) だけをボールで確かめた。人手証明は、r > 0 の根拠を `gamma_2_theta_tilde_nonzero`・`abs_basic_properties` (3) の鎖に、sinh t = r を `cosh_sinh_basic_properties` (3)(4) の当てはめに、Step 3 の名前だけの根拠を `real_exp_strictly_increasing`・`scalar_exp_zero`・`real_exp_positive` に直した（主張は不変）。計算の誤りは無かった。Lean は不変（Step 1 の対応の見直しは Lean の連続実行へ申し送り）。次は `periodicity_of_check_fermi`。

2026-11-03: 全証明の SageMath 検算として、`gamma1_gt_1_theta_tilde`（γ_1(θ̃_μ) ≥ 1、> 1）と `gamma_theta_tilde_mu_positive`（γ(θ̃_μ) > 0）に検算 `sagemath/check/<ラベル>/` を付けた（未検算 53 件）。不等号の行は差が前提の正・非負の量の和・積に多項式として等しいことを、具体値は結合定数 4 組 × M_col = 2..8 の全 μ で円分体と AA により厳密に、γ = log w の値だけを RealBallField のボールで確かめた。人手証明は、前者の根拠の無い cos θ̃ ≤ 1・c_1 > s_1 > 0 による γ_1 > 0 を `gamma1_lower_bound_all_theta` からの g ≥ 1・g > 0 に、「γ_2 ≠ 0 より |γ_2|^2 > 0」を `gamma_2_theta_tilde_nonzero`・`abs_basic_properties` (3) の鎖に、後者の γ ≥ 0・cosh γ = γ_1 の根拠を `arccosh_properties` (1)(2) に直し、値を関数 γ と別の文字 t で置いた（主張は不変）。計算の誤りは無かった。Lean は不変で `lake build`・`check-no-sorry.sh` は通る。Lean の連続実行への申し送りは状態台帳。次は `lambda_eq_exp_gamma_theta_tilde`。

2026-11-03: Lean の通しの証明のゴールラインの確認の九十一個目として、`max_eigenvalue_of_V_plus_simple` を三つに割り、(2) の二つの鎖を行った。定義 `def_finite_sum_of_real_numbers` と主張 `finite_sum_of_real_differences`・`finite_sum_of_nonnegative_reals_is_at_least_each_term` を足し、`ǧ(1,…,1) − ǧ(ε)` の鎖を 10 行に、`Λ̌_ε` の鎖を 4 行にした（主張は不変）。Lean は新しい 2 主張の具体版・必要十分版・導出と、人手と 1 対 1 の calc `gval_lt_gval_univ`・`checkBigLambda_lt_checkBigLambda_univ`。SageMath は新しい 2 ディレクトリと 050 の `check_max_eigenvalue_simple_step2_strict_inequality_chains.sage`。次は (3) の後半（状態台帳の「次の一歩」）。

2026-11-03: 全証明の SageMath 検算として、`det_A_theta_tilde`（det A(θ̃_μ) = 1 とその帰結）に検算 `sagemath/check/det_A_theta_tilde/` を付けた（未検算 55 件）。証明の行を `_chains.sage` に写し、一般の点ではその行が引く関係だけのイデアルで、具体値では結合定数 4 組 × M_col = 2..8 の全 μ で全行と主張を厳密に確かめた。人手証明は、散文のつなぎを準備と一操作ずつの鎖に組み直し、根拠の無かった u^2 + v^2 = 1 と γ_2(−θ) の表示を `euler_formula_cos_sin`・`exp_of_negative_i_real_as_cos_minus_i_sin`・`def_A_theta` の (2,1) 成分からの鎖に、行列の `theorem_exp_product` を `scalar_exp_product` に直した（主張は不変）。計算の誤りは無かった。Lean は不変（注記の段の名前の見直しは Lean の連続実行へ申し送り）。次は `gamma1_gt_1_theta_tilde`。

2026-11-03: 全証明の SageMath 検算として、`relation_of_gamma_2_theta_tilde`（γ_2(−θ̃_μ) = −conj(γ_2(θ̃_μ)) とその帰結）に検算 `sagemath/check/relation_of_gamma_2_theta_tilde/` を付けた（未検算 56 件）。一般の点の鎖と、結合定数 4 組 × M_col = 2..8 の全 μ の具体値（円分体・AA・角度 a + bπ）で全行を厳密に確かめた。人手証明は、γ_2(−θ) の表示を Euler の式からの鎖に、共役・z conj(z) = |z|^2・i = (0,1) の根拠を正しいブロックに、(3)(4)(5) を極座標表現と平方根の定義からの鎖に直した（主張は不変）。計算の誤りは無かった。次は `det_A_theta_tilde`。

2026-11-03: Lean の通しの証明のゴールラインの確認の九十個目として、`eigenvalues_of_check_Vprime` の (m5) Step 4 の後半の鎖を行った。人手の鎖を `mat_mult_associative`（`q → 1`）・Step 3 の極限の鎖・`scalar_multiple_factors_out_of_left_factor`（`p → 1`）の 1 行 1 主張の 5 行にし、Lean の `Vprime_mulVec_of_mem_range` を同じ 5 段の calc に、`Qproj_mulVec_Qproj_mulVec` の最後の行を `Qproj_sq_step1` の 1 操作にした（2 定理は `M_col = r + 1` で述べる）。系 `smul_mulVec_tensorPow` を足した。SageMath は `050` の `check_eigenvalues_of_check_Vprime_step4_eigenvector_chain.sage`。次は `max_eigenvalue_of_V_plus_simple` の名前だけの根拠（状態台帳の「次の一歩」）。

2026-11-03: Lean の通しの証明のゴールラインの確認の八十九個目として、`eigenvalues_of_check_Vprime` の (m4b) を行った。Lean の `Vprime_mul_Qproj`・`Qproj_mul_Vprime` を、人手の Step 3・Step 3' の極限の鎖の 7 行と 1 対 1 の calc（`limUnder atTop`・部分和の鎖・乗法の連続性・スカラー倍の収束・極限の一意性）にした。人手 `matrix_multiplication_continuity` の Lean の具体版 `matrix_mul_right_tendsto`・必要十分版 `NecSuf.mul_right_tendsto'`・`TensorPow M` の系を足し、必要十分版の特殊化は `ClaimEigenvaluesCheckVprimeFromNecSuf.lean` へ移した。人手証明と SageMath は不変。lake build・check-no-sorry.sh・check-end-to-end.sh・check-docs-references.sh は通った。次は (m5)（Step 4 の後半の鎖）。数の exp の級数の極限・実数と複素数の exp の一致・極限の一意性・行列の exp 級数の収束の 4 つは Lean の具体版が無く mathlib で閉じている。

2026-11-03: Lean の通しの証明のゴールラインの確認の八十八個目として、`eigenvalues_of_check_Vprime` の (m4a) Step 3・Step 3' の人手の極限の鎖を直した。最後の行が引いていた `real_exp_series_converges` は非負の実数しか覆わず、`ǧ(ε) < 0`（例えば `ε = 0`）で根拠にならなかった。主張 `matrix_multiplication_continuity_in_right_factor`・`scalar_sequence_times_matrix_converges` を `002_linear_space_general.ts` に足し、鎖を `scalar_exp_is_limit_of_partial_sums`（`K = ℂ`）・新しい主張・`complex_exp_of_real_argument` で書き直した（Step 3' は右の因子が動く形の連続性を引く）。主張文に右辺の実数の係数を ℂ の元にして掛けることを書いた（強さは不変）。Lean は新しい 2 主張の具体版・必要十分版・導出（`MathematicalTools/VectorAndMatrixNormsAndConvergence/`、`NecSuf/ContinuityOfProductsAndScalarMultiples.lean`）。SageMath は新しい 2 ディレクトリと `050` の `check_eigenvalues_of_check_Vprime_step3_limit_chains.sage`。次は (m4b): Lean の `Vprime_mul_Qproj`・`Qproj_mul_Vprime` を人手の極限の鎖と 1 対 1 の calc にする。

2026-11-03: 全証明の SageMath 検算として、`gamma_2_theta_tilde_nonzero`（γ_2(θ̃_μ) ≠ 0）に検算 `sagemath/check/gamma_2_theta_tilde_nonzero/` を付けた（未検算 57 件）。結合定数を exp(2K_i) が有理数の組に取り、角度を円分体に置いて全行を厳密に確かめた。人手証明は、第 1 因子が 0 でない理由を本文に無い Euler の公式から逆元を作る鎖（scalar_exp_product・scalar_exp_zero）へ、零因子の一般論を逆元を使う鎖へ直し、成分・奇偶・矛盾の散文を鎖にした（主張は不変）。計算の誤りは無かった。次は `relation_of_gamma_2_theta_tilde`（状態台帳の「次の一歩」）。

2026-11-03: Lean の通しの証明のゴールラインの確認の八十七個目として、`eigenvalues_of_check_Vprime` の (m3) Step 3・Step 3' の部分和の鎖を行った。定義 `def_finite_sum_of_complex_numbers_from_index_zero`・`def_finite_sum_of_matrices_from_index_zero`（添字 0 からの和を添字 1 からの和へずらす）を足し、名前だけの根拠「有限和と行列積の分配法則」「有限和からの共通因子のくくり出し」を 1 行 1 主張の 8 行の鎖にした（主張は不変）。Lean は `partialExpSum`・`partialExpSum_mul_Qproj`・`Qproj_mul_partialExpSum`（人手と 1 対 1 の calc）。SageMath は 050 の `check_eigenvalues_of_check_Vprime_step3_partial_sum_chains.sage`。次は (m4)。極限の鎖の最後の行が引く `real_exp_series_converges` は `a ≥ 0` だけを覆い、`ǧ(ε) < 0` の場合を覆わないので先に直す。

2026-11-03: Lean の通しの証明のゴールラインの確認の八十六個目として、`eigenvalues_of_check_Vprime` の (m2) Step 1 の右から掛ける形の鎖を行った。主張 `finite_sum_of_matrices_distributes_in_right_factor`（`C(ΣX_j) = Σ(CX_j)`。帰納法）を `002_linear_space_general.ts` に足し、「同じ計算を (3) の右から掛ける形に対して行えば」と名前だけで済ませていた段落を、`Q̌_εX̌` から始める 1 行 1 主張の 14 行の鎖にした（主張は不変）。Lean は新しい主張の具体版 `ClaimFiniteSumOfMatricesDistributesInRightFactor.lean`（`mul_finite_sum_of_matrices`）、必要十分版 `NecSuf/MatrixMulFiniteSum.lean`（左分配則と有限和の定義だけが効く）、`TensorPow M` の系 `mul_finite_sum_tensorPow`、一般の `M` の (3) の右から掛ける形 `Qproj_mul_nOp`、人手と 1 対 1 の calc `Qproj_mul_Xop_step1`。`Qproj_mul_Xop` は型を変えずに `M = r + 1` でこの鎖から示し、人手の範囲外の `M = 0` は可換性による `Qproj_mul_Xop_of_commute`。SageMath は `sagemath/check/finite_sum_of_matrices_distributes_in_right_factor/` と `050` の `check_eigenvalues_of_check_Vprime_step1_right_chain.sage`（PASS）。レビューの必須の指摘は記録の更新だけで、任意の指摘 2 件（新しい主張の帰納の段の代入に「同時に置き換える」を添えた、SageMath の overview の「108 段」を「108 組」に直した）を直した。残した任意の指摘: 左右の鎖の `scalar_multiple_is_associative` の行は mathlib の `smul_smul` で閉じている（具体版と `TensorPow M` の系が無い。既存の件）。次は (m3)。

2026-11-03: 全証明の SageMath 検算として、`def_gamma1_gamma2_of_theta`（γ_1・γ_2 の定義と A(θ) をそれで書く主張）と `gamma1_lower_bound_all_theta`（γ_1(θ) ≥ cosh(2K_1 − 2K_2^*) ≥ 1）に検算 `sagemath/check/<ラベル>/` を付けた（未検算 58 件）。等号の行は多項式のイデアルと有理関数体で、不等号の行は差の積の形と実代数的数の具体値で厳密に確かめた。人手証明（後者）は根拠を各行のラベル参照にし、cos θ ≤ 1 による評価を一操作ずつの含意に分け、全実数上の cos θ ≤ 1 を前提とすることを主張に書いた（不等式の中身は不変）。Lean は不変（`lake build`・`check-no-sorry.sh` 成功）。計算の誤りは無かった。次の一歩は `gamma_2_theta_tilde_nonzero`。

2026-11-03: Lean の通しの証明のゴールラインの確認の八十五個目として、`eigenvalues_of_check_Vprime` の残りを (m1)〜(m5) に割り、(m1) Step 1 の左から掛ける形の鎖を行った。主張 `finite_sum_of_matrices_distributes_in_left_factor`（`(ΣX_j)C = Σ(X_jC)`）・`difference_of_scalar_multiples_of_one_matrix`（`aA − bA = (a − b)A`）を `002_linear_space_general.ts` に足し、Step 1 の名前だけの根拠 3 つを 1 行 1 主張の 14 行の鎖にした（主張は不変）。Lean は新しい 2 主張と `finite_sum_of_scalar_multiples_of_one_matrix` の具体版・必要十分版・`TensorPow M` の系と、人手と 1 対 1 の `Xop_mul_Qproj_step1`（`Xop_mul_Qproj` は型を変えずにこれから示す）。SageMath は新しい 2 ディレクトリと `050` の `check_eigenvalues_of_check_Vprime_step1_left_chain.sage`。次は (m2) Step 1 の右から掛ける形。

2026-11-03: 全証明の SageMath 検算として、`recover_Z_Y_from_check_Z_Y`（Ž・Y̌ から Z_j・Y_j を復元する）に検算 `sagemath/check/recover_Z_Y_from_check_Z_Y/` を付け、そのために足した主張 `finite_double_sum_of_matrices_interchange`・`finite_sum_of_matrices_with_single_nonzero_term` にも検算を付けた（未検算 60 件）。主鎖・準備・生成・新しい主張は厳密に、exp の行は本文の exp のボールで確かめた。人手証明は主張をスカラー左置き・像の記号・左辺から始まる形にし、名前だけの根拠を新しい主張への参照に付け替えた（中身は不変）。Lean は不変（`lake build`・`check-no-sorry.sh` 成功）だが、具体版の 1 対 1 と `T_V_plus_eq_T_check_Vprime` の引用のずれを状態台帳に申し送った。計算の誤りは無かった。次の一歩は `def_gamma1_gamma2_of_theta`。

2026-11-03: Lean の通しの証明のゴールラインの確認の八十四個目として、`check_joint_eigenspace_decomposition` の (l5h) を行った。人手が数ベクトルを 1 列の行列として扱うので、`ClaimCheckJointEigenspace.lean` に `Matrix (Conf M) (Fin 1) ℂ` で Step 5 の 4 本の鎖（`colVec_eq_sum_Qproj_mul_step5`・`Qproj_mul_colVec_of_ne_step5`・`Qproj_mul_colVec_self_step5`・`eq_zero_of_binWordSum_eq_zero_step5`）を人手と 1 対 1 の calc で置き、引く主張の 1 列の行列での系 `*_colVec` を必要十分版の特殊化として足した。(5) の `sum_Qproj_mulVec`・`eq_zero_of_sum_eq_zero` は型を変えずに `Matrix.replicateCol (Fin 1)` を通してこの鎖から示す（`M = 0` は mathlib）。人手証明と SageMath は不変。これで (l5) は済み、次は `eigenvalues_of_check_Vprime` に残る件。

2026-11-03: Lean の通しの証明のゴールラインの確認の八十三個目として、`check_joint_eigenspace_decomposition` の (l5g) を行った。`ClaimTraceCheckNumberOperatorProduct.lean` に因子の混在を許す人手 `trace_of_check_number_operator_product` の具体版 `trace_projFactorProd`（必要十分版 `NecSuf.two_pow_smul_tau_projOn` の特殊化）を足し、`ClaimCheckJointEigenspace.lean` の `trace_Qproj_step4` に Step 4 の 3 行 `tr(Q̌_ε) = 2^{M−M} = 2^0 = 1` と 1 対 1 の calc を置いて、(4) 前半の `trace_Qproj` をこの鎖から示すようにした。人手証明と SageMath は不変。次は (l5h) Step 5。

2026-11-03: Lean の通しの証明のゴールラインの確認の八十二個目として、`check_joint_eigenspace_decomposition` の (l5f) を行った。`ClaimCheckJointEigenspace.lean` に Step 3 の最初の三つの場合（`nOp_mul_projFactor_comm_step3`）・直前の二つの場合（`nOp_mul_projFactor_step3`）・`ň_νQ̌_ε = ε_νQ̌_ε` の 9 行の鎖（`nOp_mul_Qproj_step3`）・`Q̌_εň_ν = ε_νQ̌_ε` の 4 行の鎖（`Qproj_mul_nOp_step3`）を人手と 1 対 1 の calc で置き、(3) の `nOp_mul_Qproj`・`commute_nOp_Qproj` を型を変えずに `M = r + 2` でこの鎖から示すようにした（`M = 0, 1` は必要十分版の特殊化）。人手証明と SageMath は不変。次は (l5g) Step 4 の `tr(Q̌_ε) = 2^{M−M} = 2^0 = 1`。

2026-11-03: 全証明の SageMath 検算として、`anticommutator_of_check_Z_Y`（Ž・Y̌ の反交換関係）に検算 `sagemath/check/anticommutator_of_check_Z_Y/` を付け、そのために足した主張 `anticommutator_of_finite_sums_of_scalar_multiples`・`finite_sum_of_scalar_multiples_of_one_matrix`（`002_linear_space_general.ts`）にも検算を付けた（未検算 61 件）。三つの式の鎖は円分体の行列で、準備の鎖は有理関数体と実数の対で厳密に、exp の行は本文の exp のボールで確かめた。人手証明は、名前だけの双線型性と行列の `theorem_exp_product` を新しい主張と `scalar_exp_product` に付け替え、準備の鎖を一行一操作に分け、第 3 式を省略せずに書いた（主張の中身は不変）。Lean は触っていない（注記の 1 対 1 の見直しは Lean の連続実行の受け持ち）。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」（`recover_Z_Y_from_check_Z_Y`）。

2026-11-03: 全証明の SageMath 検算として、`def_half_integer_modes`（θ̃ の共役添字の恒等式）と `conjugate_index_of_check_Z_Y`（M̌ の内側で共役添字を取る）に検算 `sagemath/check/def_half_integer_modes/`・`sagemath/check/conjugate_index_of_check_Z_Y/` を付けた（未検算 62 件）。角度・符号・ℂ の計算・(3) の行列は厳密に、指数法則と exp・cos・sin の値の行と主張は本文の exp のボールで確かめた。人手証明は、(2) の証明が主張と違う式を述べる `euler_formula_cos_sin` と行列の `theorem_exp_product` (n=1) を引いていたのを `exp_of_negative_i_real_as_cos_minus_i_sin`・`scalar_exp_product` に付け替え、(2) の主張と二つの角度の鎖を像の記号で書き直した（主張の中身は不変）。Lean `ClaimConjugateIndex.lean` は注記の根拠名だけを合わせた（証明は不変、`lake build`・`check-no-sorry.sh` 成功）。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」（`anticommutator_of_check_Z_Y`）。

2026-11-03: Lean の通しの証明のゴールラインの確認の八十一個目として、`check_joint_eigenspace_decomposition` の (l5e) を行った。`ClaimCheckJointEigenspace.lean` に Step 2 の 4 行の鎖 `Σ_ε Q̌_ε = Σ_ε ∏R_μ^{(ε_μ)} = ∏(R_μ^{(1)} + R_μ^{(0)}) = ∏I = I` と 1 対 1 の `sum_Qproj_step2`（`rFactor`・`finsetOfBinWord`・`rFactor_one_add_rFactor_zero`）を置き、Lean の `Finset.sum` と人手の和 `def_sum_over_binary_words` をつなぐ `sum_Qproj_eq_binWordSum`（必要十分版 `NecSuf/BinaryWordSumAsFinsetSum.lean` の `binWordSum_eq_sum`）を足した。(2) の `sum_Qproj` は型を変えずに `M ≥ 1` でこの鎖から示す（`M = 0` は必要十分版の特殊化）。人手証明と SageMath は不変。次は (l5f) Step 3 の `ň_νQ̌_ε`・`Q̌_εň_ν` の鎖。

2026-11-03: 全証明の SageMath 検算として、`arccosh_properties`（逆双曲線余弦は非負側の双曲線余弦の逆）に検算 `sagemath/check/arccosh_properties/` を付けた（未検算 64 件）。等号の行を不定元のイデアルと形式冪級数で厳密に、log・exp の値を含む行と主張を本文の exp のボールと log の囲みで確かめた。人手証明は、定義に無い「証明で示した log 1 = 0」の参照を `scalar_exp_zero` と `log(exp x) = x` の鎖に替え、一行二操作の行を分け、(1) と `sinh t ≥ 0` を場合分けの鎖に、ℝ 脱出を明示した（主張は不変）。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」（`def_half_integer_modes`）。

2026-11-02: 全証明の SageMath 検算として、`factorization_of_A_theta_general`（A(θ) = B_1(θ)B_2B_1(θ)）に検算 `sagemath/check/factorization_of_A_theta_general/` を付けた（未検算 65 件）。各行の等号がその行の (∵) が引く関係式だけで成り立つことを多項式のイデアルで、全行と主張を具体値の代数的数で厳密に確かめた。人手証明は a, b, C, S, e_± を ℂ の元として置き直し、本文に無かった倍角公式の参照を `cosh_addition_formula`・`sinh_double_angle_formula` と包含の積・和の保存に、`theorem_exp_product`（n=1）を `scalar_exp_product`・`scalar_exp_zero` に付け替えた（主張の中身は不変）。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」（`arccosh_properties`）。

2026-11-03: Lean の通しの証明のゴールラインの確認の八十個目として、`check_joint_eigenspace_decomposition` の (l5d) を行った。`ClaimCheckJointEigenspace.lean` に Step 1 の `ε = ε'` の 8 行の鎖を `Qproj_sq_eq_mul_self_step1`（1〜4 行）・`Qproj_mul_self_step1`（5〜8 行、`M_col = r + 1`）・`Qproj_sq_step1` と各因子の冪等性 `projFactor_mul_self_step0` で人手と 1 対 1 に置き、(1) 後半 `Qproj_mul_self` を型を変えずに `M ≥ 1` でこの鎖から示すようにした（`M = 0` は必要十分版の特殊化 `Qproj_mul_self_of_necSuf`）。人手証明と SageMath は不変。次は (l5e) Step 2。

2026-11-02: Lean の通しの証明のゴールラインの確認の七十九個目として、`check_joint_eigenspace_decomposition` の (l5c) を行った。`ClaimCheckJointEigenspace.lean` に Step 1 の `ε ≠ ε'` の鎖と 1 対 1 の `projFactor_mul_projFactor_eq_zero_step1`・`projFactor_comm_factor_step1`・`Qproj_mul_Qproj_of_ne_step1`（`M_col = r + 2`）を置き、(1) 前半 `Qproj_mul_Qproj_of_ne` を型を変えずに人手の範囲でこの鎖から示すようにした（`M = 0, 1` は必要十分版の特殊化 `Qproj_mul_Qproj_of_ne_of_necSuf`）。人手証明と SageMath は不変。次は (l5d) Step 1 の `ε = ε'` の鎖。

2026-11-02: Lean の通しの証明のゴールラインの確認の七十八個目として、`check_joint_eigenspace_decomposition` の (l5b) を行った。`ClaimCheckJointEigenspace.lean` に人手の添字 `μ = j + 1` を与える `checkIdxOfFin` と、`Qproj`（`Finset.noncommProd`）が人手の `Q̌_ε = ∏_{μ=1}^{M_col} R_μ^{(ε_μ)}`（`def_finite_product_of_matrices` の左から掛ける積）に等しいこと `Qproj_eq_finProdLeft`（`M_col = r + 1` の形）を置いた。必要十分版は `NecSuf/FiniteProductLeftAsNoncommProd.lean` の `finProdLeft_eq_noncommProd_image`（モノイド・因子の可換性・単射な添字の写像が効く）。人手証明と SageMath は不変。次は (l5c) Step 1 の `ε ≠ ε'` の鎖。

2026-11-02: Lean の通しの証明のゴールラインの確認の七十七個目として、`check_joint_eigenspace_decomposition` の (l5) を (l5a)〜(l5h) に割り、(l5a) Step 0 の異なる添字の因子の可換性の鎖を行った。`ClaimCheckJointEigenspace.lean` に `YI = IY` と 4 通りの上付き添字の組の鎖（人手の行と 1 対 1 の calc）と、まとめ `projFactor_mul_comm_step0` を置いた。引く `commuting_with_difference` の具体版 `ClaimCommutingWithDifference.lean`・必要十分版 `NecSuf/CommuteWithMatrixDifference.lean`・導出と `TensorPow M` の系を足した。人手証明と SageMath は不変。次は (l5b)（`Qproj` と `finProdLeft` をつなぐ等式）。

2026-11-02: Lean の通しの証明のゴールラインの確認の七十六個目として、`check_joint_eigenspace_decomposition` の (l4b) を行った。主張 `sum_over_binary_words_with_one_nonzero_term`（`{0,1}^r` の上の和で一つの項以外が零行列なら和はその項）を足し、Step 5 の直和の鎖の 1 行目「Step 1 の直交性と冪等性」をその参照と前提の二つの 4 行の鎖（`mat_mult_associative`（`q → 1`）・Step 1・`zero_matrix_is_left_zero_of_mat_mult`（`p → 1`））に、散文「各項は像に属するから和は全体を張る」を `trace_of_idempotent` の `im` の定義の文にした（主張の中身は不変）。Lean は具体版 `binaryWordMatrixSum_eq_of_eq_zero`、必要十分版 `NecSuf.binWordSum_eq_of_eq_zero`（`AddZeroClass`）、導出と `TensorPow M` の系。SageMath は `sum_over_binary_words_with_one_nonzero_term/` と `050` の `check_joint_eigenspace_step5_direct_sum_first_line.sage`。次は (l5)（(1)〜(4) の Step 1〜Step 5 の鎖と 1 対 1 の Lean の具体版）。

2026-11-02: 全証明の SageMath 検算として、`calc_of_TxT_check_Z_Y`（T_{(V_1^{(+)})^{1/2}}・T_{V_2} の (Ž, Y̌) への直積作用）に検算 `sagemath/check/calc_of_TxT_check_Z_Y/` を付けた（未検算 66 件）。始点を共役で作り、二本の鎖の全行と主張を数体の中で厳密に確かめた。人手証明は、主張の中で定めていた行列の組と 2×2 行列の積を新しい定義 `def_pair_of_matrices_times_two_by_two_matrix` に切り出し、`def_B1_theta_B2` の成分を `T_actions_on_check_Z_Y` と同じ包含の像の表記にし、主張と証明をその表記にそろえた（中身は不変）。積を引く下流 3 か所の参照を新しい定義へ付け替えた。共通の準備を `sagemath/_shared/transfer_factor_actions_on_check_Z_Y.sage` へ切り出した。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」（`factorization_of_A_theta_general`）。

2026-11-02: 全証明の SageMath 検算として、`linearity_of_T_on_check_Z_Y`・`linearity_of_T_V2`（(V_1^{(+)})^{1/2}・V_2 による共役写像の ℂ 線型性）に検算 `sagemath/check/<ラベル>/` を付けた（未検算 67 件）。g を K_1 = 2 log y・K_2 = log x で QQ に作り、a, b を不定元にして証明の一行と当てはめた linearity_of_T の鎖を厳密に確かめた。人手証明は主張を T_actions_on_check_Z_Y と同じ書き方にそろえ、各記号の所属と根拠を書いた（主張の中身は不変）。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」（`calc_of_TxT_check_Z_Y`）。

2026-11-02: Lean の通しの証明のゴールラインの確認の七十五個目として、`check_joint_eigenspace_decomposition` の (l4) を行った。定義 `def_power_of_complex_number` と主張 `sum_over_binary_words_distributes_in_right_factor` を足し、Step 4 の「冪の零乗」と Step 5 の「単位行列の作用」「行列の作用の分配法則」2 か所「零ベクトルへの行列の作用」をラベル参照に替えた（主張の中身は不変）。Lean は具体版 `mul_binaryWordMatrixSum`、必要十分版からの導出と `TensorPow M` の系。SageMath は新しいディレクトリと `050` の `check_36`。次は状態台帳の (l4b)（Step 5 の「Step 1 の直交性と冪等性」の行）。

2026-11-02: Lean の通しの証明のゴールラインの確認の七十四個目として、`check_joint_eigenspace_decomposition` の (l3c2) を行った。定義 `def_finite_product_of_matrices_omitting_one_index`・主張 `moving_one_factor_of_finite_product_to_the_end` を足し、`∏_{μ≠ν}` を使う Step 1 の `ε ≠ ε'` の鎖と Step 3 の `ň_νQ̌_ε` の鎖をその参照で書き直した（主張の中身は不変）。Lean は具体版 `DefinitionFiniteProductOfMatricesOmittingOneIndex.lean`、必要十分版 `NecSuf/FiniteProductOmittingOneIndex.lean`、`TensorPow M` の系。SageMath は新しいディレクトリと `050` の `check_35`。次は状態台帳の (l4)（Step 4・Step 5 の名前だけの根拠）。

2026-11-02: 全証明の SageMath 検算として、`T_actions_on_check_Z_Y`（T_{(V_1^{(+)})^{1/2}}・T_{V_2} の Ž・Y̌ への作用）に検算 `sagemath/check/T_actions_on_check_Z_Y/` を付けた（未検算 69 件）。K_1 = 2 log y・K_2 = log x で全ての量を一つの数体に置いて四本の鎖と主張を厳密に、級数の行だけを部分和のボールで確かめた。人手証明は、主張を新しい表記にそろえ、主張の中の積の定義を `def_pair_of_matrices_times_column_of_numbers` に切り出し、Y̌ の場合の散文を鎖に、前因子の相殺を係数の鎖にした。`V2_invertible` の主張に逆元の形を足した。Lean（`ClaimTActionsOnCheck.lean`・`V2_invertible`）は旧い形のままで、新しい鎖との対応は Lean の連続実行が見直す。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」（`linearity_of_T_on_check_Z_Y`）。

2026-11-02: 全証明の SageMath 検算として、`extract_taylor_coefficient_of_check_Z_Y`（Ž・Y̌ についてのテイラー係数の抽出）に検算 `sagemath/check/extract_taylor_coefficient_of_check_Z_Y/` を付けた（未検算 70 件）。級数を偶奇の二つの級数に分けて証明の無い `sinh_cosh_taylor_series` を代入していた証明を、部分和の等式と極限で示す新しい主張 `exponential_series_of_even_odd_power_terms`（検算 `sagemath/check/exponential_series_of_even_odd_power_terms/`）を引く形に書き換え、主張を係数変換の新しい表記にそろえた（主張の中身は不変）。Lean（`ClaimExtractTaylor.lean`）は旧い 4 行の手順のまま写しており、新しい証明との 1 対 1 の対応は Lean の連続実行が見直す。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」（`T_actions_on_check_Z_Y`）。

2026-11-02: Lean の通しの証明のゴールラインの確認の七十三個目として、`check_joint_eigenspace_decomposition` の (l3c) を二つに割り、(l3c1) を行った。主張 `matrix_commuting_with_each_factor_commutes_with_finite_product`・`product_of_two_finite_products_of_matrices` を足し、Step 0 の異なる添字の因子の可換性を鎖にし（`commuting_with_difference`）、Step 1 の `Q̌_ε^2` の鎖と Step 3 の左右の鎖をその参照にした（主張の中身は不変）。Lean は具体版 `ClaimFiniteProductsOfCommutingMatrices.lean`、必要十分版 `NecSuf/FiniteProductCommute.lean`、`TensorPow M` の系。SageMath は新しい 2 ディレクトリと `050` の `check_34`。次は状態台帳の (l3c2)（`∏_{μ≠ν}` を使う 3 行）。

2026-11-02: Lean の通しの証明のゴールラインの確認の七十二個目として、`check_joint_eigenspace_decomposition` の (l3b) を行った。`{0,1}^r` の上の行列の和の定義 `def_sum_over_binary_words`（最後の成分で `1` を `0` より先に足す帰納法）と、主張 `sum_over_binary_words_distributes_in_left_factor`・`expansion_of_finite_product_of_two_term_sums`（左から掛ける積なので因子の可換性は使わない）を足し、Step 2 の「可換な有限個の因子の積の分配法則による展開」と主張 (2) の和をその参照にした（主張の中身は不変）。Lean は具体版 `binaryWordMatrixSum`・`binaryWordMatrixSum_mul`・`expansion_of_finite_product_of_two_term_sums`、必要十分版 `NecSuf/BinaryWordSum.lean`、`TensorPow M` の系。SageMath は新しい 2 ディレクトリと `050` の `check_33`。次は状態台帳の (l3c)（Step 1・Step 3 の因子の並べ替え）。

2026-11-02: Lean の通しの証明のゴールラインの確認の七十一個目として、`check_joint_eigenspace_decomposition` の (l3) を三つに割り、先頭の (l3a) を行った。行列の有限積の定義 `def_finite_product_of_matrices`（左から掛け、空の積を持たない）と、主張 `zero_matrix_is_right_zero_of_mat_mult`（`AO = O`）・`finite_product_of_identity_matrices`（`∏I = I`）を足し、`Q̌_ε` の積と Step 1・Step 2 の最後の行をその参照にした（主張の中身は不変）。Lean は具体版 `finiteMatrixProduct`・`matrix_mul_zero_matrix`・`finite_product_of_identity_matrices`、必要十分版 `NecSuf/FiniteProductLeft.lean`・`NecSuf/MatrixMulZero.lean`、`TensorPow M` の系。SageMath は新しい 2 ディレクトリと `050` の `check_32`。次は状態台帳の (l3b)（Step 2 の分配による展開）。

2026-11-02: Lean の通しの証明のゴールラインの確認の七十個目として、`check_joint_eigenspace_decomposition` Step 3 の名前だけの根拠「`ε_ν=1` と単位元の積」「`ε_ν=0` と零元の積」「`Q̌_ε` の定義とスカラーの分配」を、`scalar_multiple_by_one`・`zero_scalar_multiple_is_zero_matrix` を右辺から左辺へ引く行と場合の仮定の行、`scalar_multiple_factors_out_of_right_factor` を含む 5 行の鎖にした（主張の中身は不変）。Lean は `scalar_multiple_by_one` の具体版・必要十分版・`TensorPow M` の系と、Step 3 の二つの場合の `nOp_mul_projFactor_of_mem`・`nOp_mul_projFactor_of_not_mem`。SageMath は `050` の `check_31`。次は状態台帳の (l3)（Step 1〜Step 3 の因子の可換性・零元・分配の展開・単位行列の有限積）。

2026-11-02: 全証明の SageMath 検算として、`cosh_sinh_coefficient_conversion_for_check`（Ž・Y̌ についての cosh・sinh の展開係数への変換）に検算 `sagemath/check/cosh_sinh_coefficient_conversion_for_check/` を付けた（未検算 71 件）。交換子の線型性を新しい主張 `commutator_of_scalar_multiples` に切り出して検算を付け、nesting の証明もそれを引く形にした。補題 2 と根拠なしの冪の法則を、冪の約束からの二つの帰納法に置き換えた（主張の中身は不変）。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」（`extract_taylor_coefficient_of_check_Z_Y`）。

2026-11-02: Lean の通しの証明のゴールラインの確認の六十九個目として、`check_joint_eigenspace_decomposition` の残りを 5 つの単位に割り、先頭の Step 0・Step 3 の「行列の加法逆元」3 か所を `matrix_difference_zero_iff_equal` の `⟸` に、和 `ň + (I − ň) = I` を新しい主張 `matrix_plus_difference_cancels` に、冪等性の行 5 か所を Step 0 冒頭の `ň_μň_μ = ň_μ`（(3) の冪の形を `def_exp` (1) で積へ運ぶ 5 行）の参照にした（主張の中身は不変）。Lean は具体版・必要十分版・`TensorPow M` の系と `nOp_mul_nOp_of_sq`・`nOp_add_one_sub_nOp`、SageMath は `matrix_plus_difference_cancels/` と `050` の `check_30`。次は Step 3 の行末の名前だけの根拠（状態台帳の (l2)）。

2026-11-02: 全証明の SageMath 検算として、`nesting_of_commutator_of_H_and_check_Z`（Ž・Y̌ についての n 重交換子 (h1.z)〜(h2.y)）に検算 `sagemath/check/nesting_of_commutator_of_H_and_check_Z/` を付けた（未検算 72 件）。位相を円分体、(K_1)_C・(K_2^*)_C を不定元に置き、前提 (A)〜(D)・準備の二つの鎖・四つの帰納法の全行と主張を厳密に確かめた。人手証明は、主張の中の n 重交換子を `def_ad_X_matrix` の ad^n への参照に、K_1・K_2^*・θ̃ を包含の像で書き、名前だけの根拠をラベル参照に、鎖の後の散文の照合を鎖の行にした（主張の中身は不変）。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」（`cosh_sinh_coefficient_conversion_for_check`）。

2026-11-02: 全証明の SageMath 検算として、`T_V_plus_is_conjugation`（三つの共役の合成は V^{(+)} による共役に等しい）に検算 `sagemath/check/T_V_plus_is_conjugation/` を付けた（未検算 73 件）。因子と逆元を数体で厳密に作り、不定元の X で全行を確かめた。人手証明は、合成則が `mat_conj` の共役についての主張であることを `T'_g` で区別して準備に置き、散文を値の 8 行の鎖にした。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」（`nesting_of_commutator_of_H_and_check_Z`）。

2026-11-02: Lean の通しの証明のゴールラインの確認の六十八個目として、`check_number_operators_commute` Step 1 の「すなわち `XW = -(WX)`」を、`XW + WX = [X, W]_+ = O` の鎖と `matrix_equals_negation_if_sum_is_zero` の参照にした。4 式の右辺を零行列 `O` と書き、第 2 式・第 3 式の `δI = O` を新しい主張 `zero_scalar_multiple_is_zero_matrix`（`0_ℂA = O`）の行に、第 3 式の引数の入れ替えを新しい主張 `matrix_sum_is_commutative` の行を含む 7 行に開いた（主張の中身は不変）。Lean は `matrix_equals_negation_if_sum_is_zero` と新しい 2 主張の具体版・必要十分版・`TensorPow M` の系と、Step 1 の人手と 1 対 1 の calc（`anticomm_*_eq_zero`・`mul_eq_neg_of_anticomm_eq_zero`）。SageMath は新しい 2 ディレクトリと `050` の `check_29`。次は `check_joint_eigenspace_decomposition` の残りの名前だけの根拠。

2026-11-02: 全証明の SageMath 検算として、`V1_plus_half_invertible`・`V2_invertible`・`V_plus_factors_invertible`（(V_1^{(+)})^{1/2}・V_2・V^{(+)} の可逆性）に検算を付けた（未検算 74 件）。K_1 = 2 log y・K_2 = log x と選んで exp を固有値の射影の和で厳密に作り、全行を確かめた。人手証明は、逆元から始めて可逆性を前提にしていた鎖を h を両側から掛けて I に着く鎖に、スカラー倍を単位行列との積に読み替えていた行を係数を出す鎖にし、K・a を包含の像で書いた。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」（`T_V_plus_is_conjugation`）。

2026-11-02: 全証明の SageMath 検算として、`half_integer_phase_antiperiodicity`・`half_integer_checkZ_periodicity`・`half_integer_checkY_periodicity` に検算を付けた。係数の一致を新しい主張 `half_integer_phase_periodicity` に、負角の Euler 表示を新しい主張 `exp_of_negative_i_real_as_cos_minus_i_sin` に切り出し、5 個に同名の検算を付けた（未検算 77 件）。人手証明は一行一操作の鎖と像の記号に直し、全実数上の cos・sin（未整備）に依ることを主張に書いた。計算の誤りは無かった。次の一歩は状態台帳の「次の一歩」。

2026-11-02: 行列から線型写像への対応の証明で、Kronecker のデルタの積の等号に行末根拠を付けた。数学的内容は変えていない。
2026-11-02: Lean の通しの証明のゴールラインの確認の六十七個目として、`check_number_operator_idempotent` の名前だけの根拠（反交換子の定義・同じ項の和・行列に当てた ℂ の四則・零元との積）を、新しい定義 `def_matrix_anticommutator` と主張 `zero_matrix_is_left_zero_of_mat_mult`・`matrix_sum_with_itself_zero_implies_zero`・`matrix_summand_from_sum_equation`（`002_linear_space_general.ts`）の参照にした。(3) の鎖の先頭に冪を積へ運ぶ 4 行を足した。Lean は `cre_sq`・`ann_sq`・`ann_mul_cre`・`nOp_sq`・`nOp_mul_self` を人手と 1 対 1 の calc にし、新しい主張の具体版・必要十分版・`TensorPow M` の系を置いた。SageMath は新しい 3 ディレクトリと `050` の `check_23`・`check_28`。次は状態台帳の「次の一歩」の `check_number_operators_commute` Step 1 の「すなわち `XW = -(WX)`」。

2026-11-02: Lean の通しの証明のゴールラインの確認の六十六個目として、`V_plus_is_invertible` Step 2 の `a := (2s_2)^{M_col/2}` を `ℝ_{>0}` の元として宣言し、スカラー倍の係数を包含 `a_ℂ`・`(a^{-1})_ℂ` で書いた（`aa^{-1} = 1_ℂ` は `real_inclusion_preserves_product`・`ℝ` の `aa^{-1} = 1`・略記 `1_ℂ = (1)_ℂ` の 3 行）。`V_plus_is_positive_definite` の係数も `((2s_2)^{M_col/2})_ℂ` にした。Lean の `VPlus_mul_VPlusInv`・`VPlusInv_mul_VPlus` は `a : ℝ` の同じ行の calc、SageMath は `050` の `check_27`。次は状態台帳の「次の一歩」の「(k) の後に扱う」残り（`check_number_operator_idempotent`・`check_number_operators_commute` から）。

2026-11-02: Lean の通しの証明のゴールラインの確認の六十五個目として、`max_eigenvalue_of_V_plus_simple` (3) の固有方程式に左から `Q̌_{ε'}` を掛ける鎖の名前だけの根拠「行列の積の結合法則」を、`scalar_multiple_factors_out_of_left_factor`・`eigenvalues_of_V_plus` (1)・`mat_mult_associative`（`q → 1`）・固有方程式・`scalar_multiple_factors_out_of_right_factor` の 1 行 1 主張の 5 行にした（主張は不変）。Lean は人手と 1 対 1 の `checkBigLambda_smul_Qproj_mulVec_of_eigen` と人手の順の `eq_Qproj_univ_mulVec_of_eigen`（必要十分版の特殊化は `_of_necSuf`、必要十分版も同じ 5 段）、SageMath は `050` の `check_26`（143 段）。次の一歩は状態台帳の (k)。
2026-11-02: Lean の通しの証明のゴールラインの確認の六十四個目として、`eigenvalues_of_check_Vprime` の Step 2・Step 3' の帰納法と Step 4 の名前だけの根拠「行列の冪の定義と積の結合法則」「スカラー倍と行列の積の交換」「スカラー倍の結合法則」「行列積の結合法則」7 か所（と `k = 0` の「自明」）を、`def_exp` (1)・`mat_mult_associative`・`scalar_multiple_factors_out_of_*_factor`・`scalar_multiple_is_associative`・`scalar_multiple_by_one`・単位行列の主張・ℂ の交換律の 1 行 1 主張の鎖にした（主張は不変。冪の定義 `A^{m+1} := A^mA` に合わせて Step 2 の順序を組み直した）。Lean は人手と 1 対 1 の `Xop_pow_mul_Qproj`・`Qproj_mul_Xop_pow`・`Qproj_mulVec_Qproj_mulVec`、SageMath は `050` の `check_25`（1129 段）。次の一歩は状態台帳の (j)。
2026-11-02: 可算二次元イジングの書式統一として、閉形式への接続の証明に分配則と非負平方根の一意性を式の行末で明示した。主張は変えていない。

2026-11-02: 可算二次元イジングの書式統一として、臨界条件と双対結合の同値の証明に実双曲線正弦の代入と二倍の除去の根拠を付けた。主張は変えていない。

2026-11-02: 全証明の SageMath 検算の連続実行として、`antiperiodic_exp_sum`（半整数運動量の指数和）に検算 `sagemath/check/antiperiodic_exp_sum/` を付けた（未検算 80 件）。指数の値を 1 の冪根として厳密に持ち、全ての鎖を一行ずつ確かめた。レビューの指摘で、散文の段（主張の左辺と S、非整除の場合）を鎖に、複数の操作を束ねた行を一行一操作に分け、δ の値に def_delta_M を引いた。exp_sum と def_delta_M の記号の省略は状態台帳に記録した。計算の誤りは無かった。次は `half_integer_phase_antiperiodicity`。

2026-11-02: Lean の通しの証明のゴールラインの確認の六十三個目として、`check_joint_eigenspace_decomposition` の Step 0・Step 3 の名前だけの根拠「分配法則と、単位行列との積」4 か所を、差の書き換え・分配・単位行列・符号の外出しの主張の 1 行 1 主張の参照に割った（主張は不変）。`R^{(0)}R^{(0)} = R^{(0)}` は、本文に行列の加法の結合則が無いので `R^{(1)}R^{(0)} = 0` と `matrix_minus_zero_matrix` を引く鎖にし、Step 0 の中の順序を入れ替えた。Lean は人手と 1 対 1 の `nOp_mul_one_sub_nOp`・`one_sub_nOp_mul_nOp`・`one_sub_nOp_mul_self` と `matrix_sub_zero_matrix_tensorPow`、SageMath は `050` の check_24。次は状態台帳の (i)（`eigenvalues_of_check_Vprime` の結合法則とスカラー倍）。

2026-11-02: 全証明の SageMath 検算の連続実行として、`symmetrized_transfer_matrix_on_sectors`（`W P^{(+)} = V^{(+)} P^{(+)}`）に検算 `sagemath/check/symmetrized_transfer_matrix_on_sectors/` を付けた（未検算 81 件）。散文の「K_1/2 を代入して Bf = Cf」と「作用が等しいので BP = CP」を、ラベル参照付きの鎖と end の単射性から示す形にした。W と V^{(+)} の定義に積の括弧を明示し、WP の鎖を 16 等号にした。044 の古い行単位検査は削除した。計算の誤りは無かった。次は `antiperiodic_exp_sum`。

2026-11-02: 全証明の SageMath 検算の連続実行として、`epsilon_projectors_commute_with_transfer_matrices`（P^{(+)} と転送行列の可換性。四つの主張を束ねていた）を 1 ブロック 1 主張に分け、一般の主張 `epsilon_projector_commutes_with_epsilon_commuting_matrix`（ε と可換なら P^{(+)} とも可換）と V_1・V_2・V_1^{(+)}・(V_1^{(+)})^{1/2} への適用の 5 個の主張にし、同名の検算を付けた（未検算 82 件）。一般の主張の鎖の根拠の無い行を行列の演算の主張の参照にした。計算の誤りは無かった。次は `symmetrized_transfer_matrix_on_sectors`。

2026-11-02: Lean の通しの証明のゴールラインの確認の六十二個目として、`check_number_operator_idempotent` (3) と `check_number_operators_commute` Step 2・Step 3 の名前だけの根拠「結合法則」6 か所を `mat_mult_associative` の 1 行 1 回の参照にし、同じ鎖の分配と符号の行も既存の主張の参照に割った（主張は不変）。Lean の具体版（`nOp_mul_self`・`mul_nOp_of_anticommute`・`nOp_mul_nOp_of_ne`）を人手と 1 対 1 の calc にし、必要十分版の特殊化は `*_of_necSuf` に残した。SageMath は `050` の check_23。次は状態台帳の (h)（`check_joint_eigenspace_decomposition` の「分配法則と、単位行列との積」）。

2026-11-02: Lean の通しの証明のゴールラインの確認の六十一個目として、`iH_is_real_symmetric` Step 1・Step 2 の「スカラー倍の和の分配」「スカラー倍の交換」「スカラー倍の和の分配と交換」「i·(−i) = 1 と分配則」を 1 行 1 主張のラベル参照にした。主張 `scalar_multiple_distributes_over_matrix_sum`（`c(A+B) = cA+cB`）・`finite_sum_of_scalar_multiples`（`Σ(cX_j) = cΣX_j`）を `002_linear_space_general.ts` に足し、SageMath の検算、Lean の具体版・必要十分版 `NecSuf/SmulMatrixSum.lean`・`TensorPow M` の系、鎖と 1 対 1 の `ClaimIHPauliForm.lean` を置いた。S_1^{(+)} の鎖の境界項と和の項の代入は 2 行に分けた。次は状態台帳の (g)（`check_number_operator_*` の「結合法則」）。

2026-11-02: Lean の通しの証明のゴールラインの確認の六十個目として、`sign_flip_conjugation` Step 3 の項の鎖の根拠「Step 2 の `UY_jU^{-1} = +Y_j`」（本文に単項の `+` の定義が無い）を「Step 2 の `UY_mU^{-1} = Y_m` を `m = j` で」に直し、`j, k ∈ {1, …, M_col}` を宣言した。Step 3 の鎖が引く主張の変数の置き方を行末の `(変数 → 値)` の形に揃えた（主張の `B` と `B = U`、主張の行数 `m` と和の添字 `m` の衝突を解いた）。Lean は証明を変えず、Step 3 のコメントを同じ形にした。通しの判定スクリプトは通る。次は同じファイルのほかのブロックに残る名前だけの根拠（状態台帳の「次の一歩」）。
2026-11-02: 冪根の有限和の証明で、オイラーの公式と剰余指示値の根拠ラベルを等号の行末へ移した。数学的な内容は変えていない。

2026-11-02: Lean の通しの証明のゴールラインの確認の五十九個目として、`sign_flip_conjugation` Step 3 の「共役の ℂ 線型性より `UH_1^{(+)}U^{-1} = -H_1^{(+)}`」を 9 行の鎖（`def_H1_plus`・`T_B` の定義・`matrix_conjugation_preserves_difference`・`matrix_conjugation_preserves_finite_sum`・項の鎖・`finite_sum_of_negated_matrices`・`difference_of_negated_matrices` ほか）にした。Lean は `H1plus_eq_sub`（`lastSign` 付きの和を人手の差の形へ）・`Uflip_conj_YZ`・`Uflip_conj_H1plus`（`M = r + 2` の `calc` 9 段）、SageMath は `check_21_sign_flip_step3_H1plus_chain.sage`（306 段）。次は単項の `+` と、鎖が引く主張の変数の置き方の揃え（状態台帳の「次の一歩」）。
2026-11-02: 全証明の SageMath 検算の連続実行として、`epsilon_commutes_with_transfer_matrices`（ε と転送行列の可換性。四つの主張と下流が番号で引く Step を束ねていた）を 1 ブロック 1 主張に分け、一般の可換性の主張（スカラー倍・有限和・差・反可換の積・exp）とクロネッカー積表示・ε とサイトの Pauli 行列・Z_m・Y_m の関係を含む 20 個の主張にし、それぞれに同名の検算を付けた（未検算 83 件）。散文で済ませていた冪と極限との交換・有限和への分配・反可換性の二回の適用を、ラベル参照付きの鎖にした。下流と Lean の文書の参照を付け替えた。計算の誤りは無かった。次は `epsilon_projectors_commute_with_transfer_matrices`。

2026-11-02: 全証明の SageMath 検算の連続実行として、`epsilon_projector_properties`（P^{(+)} の冪等性と像が F^{(+)} に等しいこと）に同名の検算を付けた（未検算 84 件）。四つの鎖の全行を QQ 上の不定元のベクトルで厳密に確かめ、ε^2 = I と仮定 εf = f を使う行を不定元の行列・任意のベクトルとの差で特定した。人手証明の束ねた行・根拠の無い行を、行列の演算の主張を引く一行一操作に分けた。計算の誤りは無かった。次は `epsilon_commutes_with_transfer_matrices`。

2026-11-02: 全証明の SageMath 検算の連続実行として、`first_dual_coupling_relation`（第一の結合定数と双対結合定数の双対関係）に同名の検算を付けた（未検算 85 件）。等号の行は根拠の関係だけを代入する有理関数体と形式冪級数で厳密に確かめた。レビューの指摘で、`exp(-log tanh K_1)tanh K_1 = 1` の行が直前の鎖 `exp(-L)exp(L) = 1` を引いていなかった根拠の欠けを、一本の鎖にまとめて直した。計算の誤りは無かった。第二の双対関係の証明にも同じ欠けがあることと、その検算が浮動小数点であることは状態台帳に記録した。次は `epsilon_projector_properties`。

2026-11-02: 全証明の SageMath 検算の連続実行として、`two_by_two_transfer_identity`（2×2 の転送行列の恒等式）に同名の検算を付けた（未検算 86 件）。証明の根拠の誤り（倍角公式とテイラー展開を `cosh_sinh_basic_properties` から引いていた）を直し、証明の無い `sinh_cosh_taylor_series` に頼らず、部分和の成分を 1 行 1 列の exp の部分和の半和で書いて極限を取る形にした。本文に無い冪の指数法則・平方根の積の法則を、冪の定義による帰納法と二乗の比較に置き換えた。計算の誤りは無かった。下流 `second_transfer_matrix_pauli_form` の `((2s_2)^{1/2})_C` の冪を実数の冪の像にする段の根拠の欠けと、Lean の具体版が書き直した人手証明と 1 対 1 でないことは状態台帳に記録した。次は `first_dual_coupling_relation`。
2026-11-02: Lean の通しの証明のゴールラインの確認の五十八個目を行った。`sign_flip_conjugation` Step 3 の (d1) として、「共役の ℂ 線型性より `UH_2U^{-1} = -H_2`」を `def_H2`・`T_B` の定義・`matrix_conjugation_preserves_finite_sum`・項の鎖・`finite_sum_of_negated_matrices` を引く 7 行の鎖にし、Lean の `Uflip_conj_H2` を同じ 7 段の `calc` に書き直した（項の鎖は新しい `Uflip_conj_ZY`）。SageMath `050_claim_even_sector_eigenvalues/check_20_sign_flip_step3_H2_chain.sage` を足した。次は (d2) `H_1^{(+)}` の鎖。
2026-11-02: Lean の通しの証明のゴールラインの確認の五十七個目を行った。`sign_flip_conjugation` Step 3 の (d) を三つ（(d0) 共役写像の揃え、(d1) `H_2` の鎖、(d2) `H_1^{(+)}` の鎖）に割り、(d0) として `conjugation_is_ring_homomorphism` を `mat_conj` の `T_B`（`(BA)B^{-1}`）について述べ直し、乗法性・単位性・合成則の鎖を括弧付きの一ステップ一定理（`mat_mult_associative`・単位行列の 2 主張へのラベル参照、逆元が一つに定まる 5 行の鎖）にした（主張は弱めていない、合成則の文字は `G, H`）。Lean の具体版 `conj_mul_matrix`・`conj_one_matrix`・`mulUnitOfChains`・`units_mul_inv_rev_matrix`・`conj_comp_matrix` ほか、必要十分版の `calc` 化、`TensorPow M` の系 `conj_mul_tensorPow`・`conj_one_tensorPow`（`Uflip_conj_mul` をこれへ付け替えた）、SageMath `117_.../check_02_chains.sage` を置いた。次は (d1)（状態台帳の次の一歩）。
2026-11-02: 全証明の SageMath 検算の連続実行として、正の結合定数の tanh・正の実数上の実対数・二つの双対結合定数の 4 定義を扱った。実対数の定義が束ねていた「log の狭義単調増加（証明なし）」と「0<y<1 なら log y<0」を主張 `real_log_strictly_increasing`（背理法の証明を付けた）・`real_log_negative_below_one` に分け、下流の参照 5 か所を付け替え、5 個に同名の検算を付けた（未検算 87 件）。実対数の値は有理数の端点で挟み、本文の exp のボールで端点を確かめる形にした。計算の誤りは無かった。exp の全射性の外部参照と、ラベルなしの log の単調性 7 か所は状態台帳に記録した。次は `two_by_two_transfer_identity`。
2026-11-02: Lean の通しの証明のゴールラインの確認の五十六個目を行った。`sign_flip_conjugation` Step 3 の補題の単位の (c2) として、主張 `matrix_difference_is_sum_with_negation`（`A - B = A + (-B)`）・`difference_of_negated_matrices`（`(-A)-(-B) = -(A-B)`）を `002_linear_space_general.ts` に、`matrix_conjugation_preserves_negation`（`T_B(-W) = -T_B(W)`）・`matrix_conjugation_preserves_difference`（`T_B(X-W) = T_B(X)-T_B(W)`）を `000_calculation_formulae_00_09.ts` に足した。Lean の具体版 2 本・必要十分版 `NecSuf/MatrixSubNeg.lean`・`NecSuf/MatrixConjugationNegSub.lean`・`TensorPow M` の系、SageMath 4 件を置いた。次は (d)（Step 3 の鎖と Lean の `Uflip_conj_H1plus`・`Uflip_conj_H2` の書き直し。状態台帳の次の一歩）。
2026-11-02: Lean の通しの証明のゴールラインの確認の五十五個目を行った。`sign_flip_conjugation` Step 3 の補題の単位の (c) を (c1)（符号反転は和と有限和に分配する）と (c2)（差の扱いと共役が差を保つこと）に割り、(c1) として主張 `negation_distributes_over_matrix_sum`（`-(A+B) = (-A)+(-B)`）・`finite_sum_of_negated_matrices`（`Σ(-X_j) = -ΣX_j`、`r` の帰納法）を `002_linear_space_general.ts` に足した。Lean の具体版 `ClaimNegationDistributesOverMatrixSum.lean`・必要十分版 `NecSuf/NegMatrixSum.lean`（左分配則と `-x = (-1)x` だけが効く）・`TensorPow M` の系、SageMath 2 件を置いた。次は (c2)（状態台帳の次の一歩）。
2026-11-02: Lean の通しの証明のゴールラインの確認の五十四個目を行った。`sign_flip_conjugation` Step 3 の補題の単位の (b)（共役は和と有限和を保つ）として、既存の主張 `mat_conj` の名前だけの根拠 4 か所を分配・スカラー倍の 4 主張へのラベル参照にし（主張の中身は不変）、主張 `matrix_conjugation_preserves_finite_sum`（`r` の帰納法）を足した。Lean の具体版 `ClaimMatrixConjugationPreservesSums.lean`・必要十分版 `NecSuf/MatrixConjugationSum.lean`（`B` の可逆性と積の結合則は効かない）・`TensorPow M` の系と、SageMath の `122_mat_conj/check_02_chains.sage`・`matrix_conjugation_preserves_finite_sum/` を置いた。次は (c) 符号反転と和・差（状態台帳の次の一歩）。
2026-11-02: Lean の通しの証明のゴールラインの確認の五十三個目を行った。`sign_flip_conjugation` Step 3 の「共役の ℂ 線型性」を補題の単位（分配・共役が和と有限和を保つ・符号反転と和と差・Step 3 の鎖と Lean）に割り、先頭の分配を行った。`002_linear_space_general.ts` に主張 `finite_sum_of_complex_sums`・`mat_mult_distributes_over_sum_in_right_factor`・`mat_mult_distributes_over_sum_in_left_factor` を足し、`linearity_of_T` の名前だけの根拠 4 種をラベル参照にした（主張は不変）。Lean の具体版 `ClaimMatMultDistributesOverSum.lean`・必要十分版 `NecSuf/MatMulDistribSum.lean`・`TensorPow M` の系と、人手の 6 行どおりの `linearity_of_T_on_check`、SageMath の 3 件と 200 番の書き直しを置いた。次は共役が和と有限和を保つ主張（状態台帳の次の一歩）。
2026-11-02: Lean の通しの証明のゴールラインの確認の五十二個目を行った。`sign_flip_conjugation` Step 2 の「符号は因子ごとの符号の積」「`m` の偶奇ごとに符号を計算」を、`P_0 := I`・`P_{r+1} := P_rσ_{r+1}^x` の `UP_rU^{-1}`（`r` 偶数で `P_r`、奇数で `-P_r`）の帰納法と、`Z_m = P_{m-1}σ_m^z`・`Y_m = P_{m-1}σ_m^y` から `m` の偶奇で符号を 1 行ずつ外へ出す鎖にした（`ℂ` の冪は使わない。Lean の `Uflip_conj_xString_zero/_succ/_parity/_of_even/_of_odd`・`Uflip_conj_Z`・`Uflip_conj_Y`、スカラー倍の形の `Uflip_conj_sigmaX/Y/Z` は削除、SageMath check_19）。次は Step 3 の「共役の ℂ 線型性」（状態台帳の次の一歩）。
2026-11-02: Lean の通しの証明のゴールラインの確認の五十一個目を行った。`sign_flip_conjugation` Step 1 の合成の段を、`U` の定義・Step 0 の `U^{-1} = FE`・`mat_mult_associative` 3 回・`F^{-1} = F`・`E^{-1} = E` の合成の鎖と、`a` ごとに `F` の式・符号の外出し 2 本・`E` の式（`k` の偶奇）を引く鎖にし、`k` 奇数の `σ^y` のために主張 `matrix_double_negation`（`-(-A) = A`）を足した（Lean の `Uflip_conj_eq_Eflip_conj_Fflip_conj`・`Uflip_conj_sigma*_eq_neg/_of_even/_of_odd`・`neg_neg_matrix`・`NecSuf/NegNegMatrix.lean`、SageMath check_18・`matrix_double_negation/`）。Lean の `U` のサイトごとの因子の成分計算（`flipFam` 系）は削除した。次は Step 2 の `Z_m`・`Y_m` への作用（状態台帳の次の一歩）。
2026-11-02: Lean の通しの証明のゴールラインの確認の五十個目を行った。`sign_flip_conjugation` の `E`・`F` をクロネッカー積 `E_1⊠⋯⊠E_{M_col}`・`σ^z⊠⋯⊠σ^z` に定義し直し（同じ行列）、Step 0 の「可逆行列の有限積も可逆」を `FF = I`・`EE = I` と `def_invertible_elements_of_R` (ii) による `U^{-1} = FE` の鎖に、Step 1 の `F`・`E` の鎖の 1 行目を `W ∈ {E, F}` の共役の 7 行の鎖・`(σ_k^pσ_k^a)σ_k^p` へ戻す 5 行の鎖・`k` 偶数の 4 行の鎖を引く段にした（Lean の `Uflip := Eflip * Fflip`・`siteProd_conj_siteOp` ほか、SageMath check_16・check_17）。次は Step 1 の合成の段と、Lean の `Uflip_conj_sigmaX/Y/Z` を新しい `F`・`E` の定理から組み直すこと（状態台帳の次の一歩）。
2026-11-02: Lean の通しの証明のゴールラインの確認の四十九個目を行った。`sign_flip_conjugation` Step 1 の `E` による共役の鎖（`k` 奇数）の名前だけの根拠「パウリ行列の積」5 行を、`(σ_k^xσ_k^a)σ_k^x` から Step 0 の `σ_m^xσ_m^x = I`・`mat_mult_associative`・`σ_k^pσ_k^q` の鎖（組 `(y, x)` を足した）・`negation_factors_out_of_right_factor` の鎖にした（Lean の `sigmaY_mul_sigmaX_site`・`sigmaX_sigmaX_sigmaX_site`・`sigmaX_sigmaY_sigmaX_site`・`sigmaX_sigmaZ_sigmaX_site`、SageMath check_15）。次は `F`・`E` の鎖の 1 行目「`k` 以外のサイトの因子は可換」（状態台帳の次の一歩）。
2026-11-02: Lean の通しの証明のゴールラインの確認の四十八個目を行った。`sign_flip_conjugation` Step 1 の `Fσ_k^yF^{-1}` の名前だけの根拠「パウリ行列の積」を、結合律で `σ_k^z(σ_k^yσ_k^z)` に組み替えて `pauli_matrix_products` の向きのまま使う 6 行の鎖にし、`σ_k^zσ_k^x` の鎖を `(p, q) ∈ {(z, x), (y, z)}` に一般化した（Lean の `siteOp_mul_of_anticomm`・`sigmaY_mul_sigmaZ_site`・`sigmaZ_sigmaY_sigmaZ_site`、SageMath check_14）。二重の符号反転の主張は要らなかった。次は `E` による共役の鎖（状態台帳の次の一歩）。
2026-11-02: 全証明の SageMath 検算の連続実行として、`sigma_z_diagonal_action`（σ_m^z の基底への作用。4 つの主張を束ねていた）を 1 ブロック 1 主張の 4 ブロック（固有ベクトルの等式・積の等式・σ_m^z の対角性・σ_m^zσ_{m'}^z の対角性）に分け、定義 `def_diagonal_matrix`・`def_finite_product_of_complex_numbers` と主張 6 個（0 の因子を持つ有限積は 0・1 の有限積は 1・一項以外が 0 の有限和・実数の積の包含・`(f_I)_{ν(I)} = 1`・σσ の対角成分）を足し、10 個の主張に同名の検算を付けた（未検算 91 件）。
下流 `first_transfer_matrix_pauli_form` の「D は対角行列で対角成分は d(μ)」を成分の鎖に書き直し、検算を足した。計算の誤りは無かった。既存の検算の多くが `run-all-checks.sh` から走らないこと、Lean の `ClaimSigmaZDiagonalAction.lean` ほかのコメントと 1 対 1 の対応の欠けは、それぞれの状態台帳に記録した。次は `def_positive_coupling_tanh`。

2026-11-02: 全証明の SageMath 検算の連続実行として、`sine_integral_two_sided`（正弦を含む積分の両側評価）の B の定義と B ≤ 0.88 を独立のブロックに分け、平方根どうしの大小の根拠として主張 `nonnegative_real_order_from_squares` を足し、3 個の主張に同名の検算を付けた（未検算 92 件）。本文に無い平方根の単調性に頼る段を新しい主張から引く形にし、各点評価を 1 行 1 操作の鎖にした。計算の誤りは無かった。Lean の具体版が直した人手証明と 1 対 1 でないことは状態台帳に記録した。次は `sigma_z_diagonal_action`。

2026-11-02: Lean の通しの証明のゴールラインの確認の四十七個目を行った。`sign_flip_conjugation` Step 1 の `Fσ_k^xF^{-1}`・`Fσ_k^zF^{-1}` の名前だけの根拠「パウリ行列の積」を、`σ_k^zσ_k^x = -(σ_k^xσ_k^z)` の 10 行の準備の鎖と 5 行・2 行の鎖に替え、主張 `negation_is_scalar_multiple_by_minus_one`（`-A = (-1)A`）を足した（SageMath の検算、Lean の具体版・必要十分版・系、`ClaimSignFlipConjugation.lean` の 1 対 1 の `calc` 3 本、SageMath check_13）。次は `Fσ_k^yF^{-1}` と `E` による共役の鎖（状態台帳の次の一歩）。

2026-11-02: 全証明の SageMath 検算の連続実行として、`closed_form_log_integral`（三つの主張を束ねていた積分の評価）を 1 ブロック 1 主張の 8 ブロック（log の積の法則・log(1+x) ≤ x・arcsinh の引数の両側評価・arcsinh の log 評価・閉じた形の積分・積分の log 評価・3/2 乗の定義・3/2 乗の積分の評価）に分け、7 個の主張に同名の検算を付けた（未検算 93 件）。本文に無い平方根の商・単調性の規則に頼る段を、一意性・(y+s)(s-y) = 1・背理法の鎖に置き換えた。計算の誤りは無かった。`second_derivative_log_divergence` が使う 3/2 乗の積の法則・単調性（(S(1+S))^{3/2} = S^{3/2}(1+S)^{3/2} など）は本文で示されていないので、その主張の番で扱う。次は `sine_integral_two_sided`。

2026-11-02: Lean の通しの証明のゴールラインの確認の四十六個目を行った。`sign_flip_conjugation` の Step 0 の `σ_m^xσ_m^x = I`・`σ_m^zσ_m^z = I`（名前だけの根拠「パウリ行列の積」）を、`def_site_pauli_matrices`・`kronecker_product_rule` (1)・`pauli_matrix_products`・`identity_matrix_is_left_unit_of_mat_mult`・`kronecker_product_rule` (2) の 5 行の鎖にし、Lean の具体版 `siteOp_mul_self_of_mul_self_eq_one`（`sigmaX_mul_sigmaX_site`・`sigmaZ_mul_sigmaZ_site`）と SageMath の check_12（90 段）を置いた。次は同じ証明の Step 1 の「パウリ行列の積」の各行（状態台帳の「次の一歩」）。

2026-11-02: 全証明の SageMath 検算の連続実行として、`elementary_sine_bounds`（正弦の初等評価）を 1 ブロック 1 主張の 11 ブロック（sin 0 = 0・cos 0 = 1・cos ≤ 1・t - sin t ≥ 0・cos t - 1 + t²/2 ≥ 0・sin t - t + t³/6 ≥ 0・π² の評価・c_0 の定義と評価・θ³/48 の評価・c_0 θ/2 ≤ sin(θ/2) ≤ θ/2）に分け、10 個の主張に同名の検算を付けた（未検算 94 件）。sin・cos の定義域が [-π/2, π/2] なのに t ≥ 0 全体で使っていた誤りを直し、sin・cos の導関数と π の数値を外部の主張として注記に宣言した。数値の誤りは無かった。Lean のコメントの対応づけの古さは状態台帳に記録した。次は `closed_form_log_integral`。

2026-11-02: 全証明の SageMath 検算の連続実行の回が、前の回が main へ入れ終えた `cosh_addition_and_half_angle` をもう一度扱った。作業ツリーが前の回の成果を含まない古い main から作られ、着手前に origin を取り込んでいなかったためである。こちらの版は main の版（21 ブロックに分けたもの）に含まれるので取り下げ、runbook の「毎回の手順」の最初に `git fetch origin && git rebase origin/main` を足した。次は状態台帳どおり `elementary_sine_bounds`。

2026-11-02: 全証明の SageMath 検算の連続実行として、5 つの主張と arcsinh の定義を束ねていた `cosh_addition_and_half_angle` を 1 ブロック 1 主張の 21 ブロック（cosh・sinh の偶奇性・加法定理・半角と倍角・sinh 0 = 0・単調性・単射性・sinh' = cosh・√(y²+1) > 0・arcsinh の定義と性質と微分・cosh ≥ 1・cosh の単調性・t ≤ sinh t・sinh t ≤ t cosh t）に分け、20 個の主張に同名の検算を付けた（未検算 95 件）。省いていた鎖を書き、未定義の実数の絶対値に頼る段を除き、微分の公式を `remark_real_analysis_facts_R3_R4` に宣言し、下流の参照を付け替えた。計算の誤りは無かった。実対数の定義の前方参照と、Lean のコメントが旧ラベルを指したままであることは状態台帳に記録した。

2026-11-02: Lean の通しの証明のゴールラインの確認の四十五個目を行った。`sign_flip_conjugation` の Step 3 の「共役は積を保つ」2 か所を `conjugation_is_ring_homomorphism` の `T_B` の定義・乗法性の 3 行に、Step 4 の「共役はスカラー倍を保つ」2 か所を 6 行の鎖に替え、主張 `scalar_multiple_of_negated_matrix`（`a(−A)=−(aA)`）を `002_linear_space_general.ts` に足した（SageMath の検算、Lean の具体版 `smul_neg_matrix`、必要十分版 `NecSuf/SmulNegMatrix.lean`（`Monoid`・`HasDistribNeg` だけで通る）、系 `smul_neg_matrix_tensorPow`）。Lean の `Uflip_conj_mul` を `Conjugation.T_mul` の特殊化に、`Uflip_conj_smul`・`Uflip_conj_S1plus`・`Uflip_conj_S2` を人手の行と 1 対 1 の `calc` にし、SageMath に check_11 を足した（全 PASS）。次は同じファイルに残る名前だけの根拠（状態台帳の次の一歩）。

2026-11-02: Lean の通しの証明のゴールラインの確認の四十四個目を行った。`eigenvalue_problem_eigenvalues_of_V_plus.ts` の `sign_flip_conjugation` Step 3 の符号の外出し 2 か所を `negation_factors_out_of_*_factor` に、`V_plus_is_invertible` Step 2・Step 3 の鎖を括弧を全て書いた 1 行 1 主張の鎖（スカラー倍・結合律・単位行列の左右の積のラベル参照）に替え、Lean の具体版を同じ行の `calc` に、SageMath に check_09・check_10 を足した（全 PASS）。`check-no-sorry.sh` の `'` を含む名前の引用符の欠けを直した。次は同じファイルに残る名前だけの根拠（状態台帳の次の一歩）。

2026-11-02: Lean の通しの証明のゴールラインの確認の四十三個目を行った。`002_linear_space_general.ts` に主張 `negation_factors_out_of_left_factor`（`(−A)B=−(AB)`）・`negation_factors_out_of_right_factor`（`A(−B)=−(AB)`）・`scalar_multiple_distributes_over_matrix_difference`（`c(A−B)=cA−cB`）を足し、`005_exp_conjugation_proof.ts` の `matrix_exp_conjugation` Step 1 の「スカラー倍の分配律」と Step 7 の「スカラー倍と積の両立を c=−1 に取ること」2 か所をラベル参照に替えた。SageMath の検算 3 件（PASS）と `142_matrix_exp_conjugation/check_02` の 3 段目、Lean の具体版・必要十分版（係数は `Semiring`＋`HasDistribNeg`。可換則・加法の逆元は効かない）・導出を置いた。次は `eigenvalue_problem_eigenvalues_of_V_plus.ts` の 6 か所（状態台帳の次の一歩）。

2026-11-02: Lean の通しの証明のゴールラインの確認の四十二個目を行った。`005_exp_conjugation_proof.ts` の `def_ad_X_matrix` の逆行列の一意性の鎖（単位行列の左右の積・結合律）と `matrix_exp_conjugation` Step 1 の `ad_X(cZ)` の鎖（両立の 1 行を左右の因子の 2 行に割る）をラベル参照に替え、SageMath に Step 1 の鎖の検算 `check_02_ad_linearity_chain.sage` を足した（PASS）。Lean の `matrix_exp_conjugation` が人手証明と 1 対 1 でないこと（既存）を状態台帳の次の一歩に件として足した。次は同じファイルの残り 3 か所（`c(A−B)=cA−cB`、`A(−B)=−(AB)`・`(−A)B=−(AB)` を主張として足してから替える）。

2026-11-02: Lean の通しの証明のゴールラインの確認の四十一個目を行った。`004_transfer_matrix.ts` の `exp_of_diagonal_matrix` の冪の帰納法の基底で、名前だけの根拠「単位行列の非対角成分」「単位行列の対角成分」を `def_identity_matrix`・`def_kronecker_delta` へのラベル参照の 2 段に割り、SageMath の基底の鎖に行を足した（全 PASS）。Lean の具体版の鎖は無い。次は `005_exp_conjugation_proof.ts` の「単位行列との積」3 か所ほか（状態台帳の次の一歩）。

2026-11-02: 全証明の SageMath 検算の連続実行として、`riemann_sum_to_integral`（等間隔点の平均は積分に収束する）の検算 `sagemath/check/riemann_sum_to_integral/` を足した（未検算 96 件）。π を `AA[p]` の不定元で持ち、大小はボールで符号を決めて厳密に確かめた。人手証明で、連続度 `ω(h)` が実数として定まること（有界性）が示されていなかったので、一様連続性から示す段を足し、区間加法性の前提・距離・主張の評価・収束の段を根拠付きの鎖にした。計算の誤りは無かった。Lean の具体版が `δ ∈ [0,1)` で人手と 1 対 1 でないことは状態台帳に記録した。次は `cosh_addition_and_half_angle`。

2026-11-02: 連続実行「複素行列版イジング: 章立ての組み直し」（2026-10-31 のゴール達成で一時停止していた）を scheduled-tasks でアーカイブした。状態台帳の「次の一歩」が空で、この連続実行の指示が進める単位は残っていない。確認コマンド `bash scripts/verify-complex-matrix-ising-paper-artifacts.sh` は 2026-11-02 に PASS。状態台帳の「未確定」の作業の順序の外の項目を扱うなら、別の指示で定期実行を立てるか、アーカイブを戻して指示を書き換える。

2026-11-02: Lean の通しの証明のゴールラインの確認の四十個目を行った。本文 `002_linear_space_general.ts` に `scalar_multiple_of_zero_matrix`（`aO = O`）を足し、`003_exp_linear_map.ts` の `theorem_exp_zero` の「零行列のスカラー倍は零行列」「零行列は加法の単位元」をラベル参照に替えた（スカラーを右に書いていた `O · Σ 1/n!` を `(Σ 1/n!)_ℂ O` に直した）。SageMath `sagemath/check/scalar_multiple_of_zero_matrix/` と、Lean の具体版 `ClaimScalarMultipleOfZeroMatrix.lean`・必要十分版 `NecSuf/SmulZeroMatrix.lean`（`SMulZeroClass`）・系を置いた。`003` の残りは係数が `K` の箇所だけになった。次の一歩は状態台帳の「次の一歩」（`004_transfer_matrix.ts`）。

2026-11-02: Lean の通しの証明のゴールラインの確認の三十九個目を行った。本文 `002_linear_space_general.ts` に `matrix_plus_zero_matrix`・`zero_matrix_plus_matrix`・`matrix_minus_zero_matrix`・`finite_sum_of_zero_matrices` を足し、`commutator_of_H_and_check_Z_Y` Step 1 の「零行列の和は零行列」を 2 行に分けて O を足して消す 6 行と添字 1..M_col−1 の 2 行をラベル参照に、「零行列を引いても変わらない」2 か所を `matrix_minus_zero_matrix` にした。一つの添字を除いた集合の上の和の 4 か所は「有限和の添字の付け方」の件に残した。SageMath 4 件を足し 051 の check_01 を 294 段に、Lean の具体版・必要十分版（`NecSuf/MatrixAddSubZero.lean`）・系を置いた。次の一歩は状態台帳の「次の一歩」。

2026-11-01: Lean の通しの証明のゴールラインの確認の三十八個目を行った。`eigenvalue_problem_reduction_to_A_theta.ts` の `anticommutator_of_Z_and_Y`・`commutator_of_H_and_check_Z_Y` の名前だけの根拠 23 か所（単位行列どうしの積・単位行列の性質・同じ行列の差は零行列）を `identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult`・`matrix_difference_zero_iff_equal` へのラベル参照に替え、行列の零を `O` に揃えた。Lean は `ClaimAnticommutatorZY.lean` の 2×2 の段を具体版の補題に、`ClaimCommutatorHCheckZY.lean` の段を必要十分版の `Conf M` への系（新しく足した `identity_matrix_mul_tensorPow`・`mul_identity_matrix_tensorPow`・`matrix_sub_eq_zero_iff_tensorPow`）にした。次は同じファイルの「零行列の和は零行列」「零行列を引いても変わらない」（引く主張を足す）。

2026-11-01: Lean の通しの証明のゴールラインの確認の三十七個目を行った。`008_TV1_hatZ_hatY_part1.ts`・`009_eigenvalues_of_V.ts` には名前だけの根拠の 4 種が無いことを確かめ、`partition_function_projection_and_jordan_wigner.ts` の `V1_in_Z_Y_epsilon`・`V2_in_Z_Y` の Step 0 の 4 本の鎖を、1 段に 1 つの事実を使いすべての根拠をラベルで引く鎖にした。Lean の `pauliY_mul_pauliX_eq`・`pauliX_mul_pauliY_eq`・`pauliZ_mul_pauliY` を人手と 1 対 1 の `calc` にし、SageMath に 2 本の検算を足した（全 PASS）。次は台帳の「次の一歩」（`eigenvalue_problem_reduction_to_A_theta.ts`）。

2026-11-01: 全証明の SageMath 検算の連続実行として、`psd_cauchy_schwarz`（対称・半正定値な実数の行列の Cauchy–Schwarz）の検算 `sagemath/check/psd_cauchy_schwarz/` を足した（未検算 97 件）。未定義だった `x^⊤Py` を `def_real_bilinear_value`、対称性を `def_real_symmetric_matrix` として `011_max_eigenvalue.ts` に足し、証明を成分の鎖と根拠付きの場合分けに直した。計算の誤りは無かった。下流の熱力学極限の章との型・読み方の食い違いと、Lean の具体版が 1 対 1 でないことは状態台帳に記録した。次は `riemann_sum_to_integral`。

2026-11-01: 全証明の SageMath 検算の連続実行として、`exp_hermitian_is_positive_definite`（エルミート行列の exp は正定値）を扱った。四つの主張を束ねていたブロックを 1 ブロック 1 主張の 9 ブロック（合同変換・単位行列・正の実数倍・トレース・`exp(-A)exp(A) = I`・exp のエルミート性ほか）に分け、補助の 4 主張と定義 `def_conjugate_bilinear_value`（`x^*Ay` を成分の和で定め、`def_hermitian_positive_definite` の同一視を置き換えた）を足して、13 主張に同名の検算を付けた（共通の準備 `sagemath/_shared/hermitian_forms_by_definition.sage`、exp はボールで囲む）。下流の「(1)〜(4)」の参照を付け替え、合同変換の仮定を左逆行列 `B'B = I` にした（未検算 99 → 98 件、証明を持つブロック 239 → 251 件）。計算の誤りは無かった。Lean の具体版が人手と一対一でないことを状態台帳に記録した。次は `psd_cauchy_schwarz`。

2026-11-01: Lean の通しの証明のゴールラインの確認の三十六個目を行った。`004_transfer_matrix.ts` の名前だけの根拠「行列（数ベクトル）の和とスカラー倍は成分ごと」5 か所（`exp_of_diagonal_matrix`・`end_agrees_with_matrix_vector_product`）を、新しく足した定義 `def_finite_sum_of_matrices`・主張 `finite_sum_of_matrices_entrywise`（`002_linear_space_general.ts`）の段と `def_matrix_scalar_multiple` の段の 2 段に割った。SageMath に `sagemath/check/finite_sum_of_matrices_entrywise/` と 2 つの検算の新しい行を足した（全 PASS）。有限和の添字の付け方（`Σ_{p=0}^{N}`・`𝓘` の上の和）が本文で定まっていないことを状態台帳に残した。次は台帳の「次の一歩」（`008_TV1_hatZ_hatY_part1.ts`）。

2026-11-01: Lean の通しの証明のゴールラインの確認の三十五個目を行った。`005_exp_conjugation_proof.ts` の `frobenius_inner_product_axioms` (2) の 4 本の鎖の 1 段目「(0) と行列の和の定義」「(0) とスカラー倍の定義」を、(0) の段と `def_matrix_sum`・`def_matrix_scalar_multiple` へのラベル参照の段の 2 段に割った（係数は `ℂ`）。SageMath `140_frobenius_inner_product_axioms/check_02_linearity_chains.sage`（`QQ[i]` の厳密計算、252 段）を足した。Lean の具体版はこのブロックに無い。次は `004_transfer_matrix.ts`。この VM では `140` の check_01 が `_shared/operators.sage` の読み込みパスを解決できずに落ちる（変更前から。ログは更新していない）。

2026-11-01: Lean の通しの証明のゴールラインの確認の三十四個目を行った。`003_exp_linear_map.ts` の名前だけの根拠「行列の差は成分ごと」5 か所のうち、係数が `ℂ` の 1 か所（`complex_exp_of_real_argument` の 1 行 1 列の複素行列の差の鎖）を `def_matrix_difference` へのラベル参照に替え、SageMath の検算に定義の成分の式の確認を足した。残る 4 か所は係数が `K` か `ℝ` で、`def_matrix_difference` が `ℂ` しか覆わないので替えていない（状態台帳の「次の一歩」に記録）。Lean の具体版はこのブロックに無い。次は `005_exp_conjugation_proof.ts`。

2026-11-01: 全証明の SageMath 検算の連続実行として、`star_preserves_norm_and_limits`（共役転置の積・線型性・ノルム・極限）の検算 `sagemath/check/star_preserves_norm_and_limits/` を足した。証明が根拠にしていた「複素共役は和・積・差・絶対値を保つ」を主張 `complex_conjugate_of_sum`・`complex_conjugate_of_product`・`complex_conjugate_of_difference`・`abs_of_complex_conjugate` として足し（それぞれに同名の検算）、ℂ の差と有限和の定義 `def_complex_difference`・`def_finite_sum_of_complex_numbers` を足した。「同様」としていた線型性を成分の鎖に、(3) の線型性の引用を差の成分の鎖に直した（未検算 100 → 99 件、証明を持つブロック 235 → 239 件）。計算の誤りは無かった。次は `exp_hermitian_is_positive_definite`。

2026-11-01: Lean の通しの証明のゴールラインの確認の三十三個目を行った。`pauli_matrix_products`（Pauli 行列の積の 6 式）の証明の名前だけの根拠を `def_kronecker_delta`・`def_identity_matrix` と新しく足した行列の符号反転の定義 `def_matrix_negation` へのラベル参照にし、反可換性の 3 式を主張の左辺から始まる鎖にした。Lean の 6 定理を人手と 1 対 1 の `calc` に書き直し、SageMath の各行の検算（check_02）を足した。`check-no-sorry.sh` の `'` を含む名前の引用の崩れを直した。次は台帳の「次の一歩」（`003_exp_linear_map.ts` の「行列の差は成分ごと」をラベル参照へ）。

2026-11-01: 全証明の SageMath 検算の連続実行として、`trace_of_idempotent`（冪等行列のトレースは像の次元）の検算 `sagemath/check/trace_of_idempotent/` を足した。証明の分配則・結合則・零の行の根拠が欠け、Step 2・3 が未定義の「表現行列」「基底変換行列」を使っていたので、`Q^2 = QQ` の準備、基底を列に並べた `P` と対角の `D` による `QP = PD` の成分の鎖、`trace_basic_properties` (4) を引く鎖に直し、主張 `mat_mult_vector_difference`（`A(u−w) = Au − Aw`）を足して検算を付けた（未検算 101 → 100 件）。計算の誤りは無かった。次元・基底の定義が本文に無いことと、Lean の具体版が mathlib に委ねていることを状態台帳に記録した。次は `star_preserves_norm_and_limits`。

2026-11-01: Lean の通しの証明のゴールラインの確認の三十二個目を行った。`scalar_identity_commutes` の証明を、スカラー倍の左右・単位行列の左右・差が零の主張へのラベル参照の 6 段にし、Lean の具体版を `ℂ`・`Fin n` で人手と 1 対 1 の鎖に書き直した。行列同士の積の 4 主張の具体版・必要十分版を置き、人手に `complex_times_zero_is_zero` を足して右の単位元の証明から要らない交換律の段を外した。次は台帳の「次の一歩」（`003_exp_linear_map.ts` の「行列の差は成分ごと」をラベル参照へ）。

2026-11-01: Lean の通しの証明のゴールラインの確認の三十一個目を行った。人手 `eigenvector_of_A_theta_tilde` Step 2 の第 2 成分を `b` のまま括り出す 6 行の鎖にし（`b = -ā` を使わない）、Lean の具体版・必要十分版の `calc` と SageMath の段（check_02、72 段 PASS）を揃えた。次は台帳の「次の一歩」（本文の他の証明の「単位行列の性質」などをラベル参照に替える）。

2026-11-01: Lean の通しの証明のゴールラインの確認の三十個目を行った。本文に行列の差・零行列の定義と、`A − B = O ⟺ A = B`・`Av − Bv = (A − B)v` の主張を数学的道具立てへ足し、`eigenvector_of_A_theta_tilde` Step 1 の同値の鎖と `det(A(θ) − λI)` の先頭の行を、それらと SageMath 検算の連続実行が先に足した単位行列・スカラー倍のブロックへのラベル参照にした。Lean の具体版・必要十分版・導出と SageMath の検算を付け、`eigenvalue_AMat_iff` と `skew2_eigenvalue_iff` の鎖から mathlib の `one_mulVec` などを外した。次は台帳の「次の一歩」（Step 2 の第 2 成分の往復の簡潔化）。

2026-11-01: 全証明の SageMath 検算の連続実行として、`trace_basic_properties`（トレースの基本性質）の検算 `sagemath/check/trace_basic_properties/` を足した（未検算 102 → 101 件。並行して入った行列の差の単位を含めた数え）。人手証明の散文を根拠付きの鎖に直し、行列の和の定義 `def_matrix_sum` を足し、(3) の右辺を `Σ_{k=1}^{n} 1_C` に、(4) の仮定を `P'P = I` に改めた。計算の誤りは無かった。次は `trace_of_idempotent`。

2026-11-01: 全証明の SageMath 検算の連続実行として、`def_invertible_elements_of_R`（`Mat(2^M,ℂ)` の可逆元）の検算 `sagemath/check/def_invertible_elements_of_R/` を足した。証明が根拠にしていた単位行列・行列のスカラー倍・積の結合律・単位行列との積・スカラー倍の性質・`0_C z = 0_C` を述べるブロックが本文に無かったので、定義 3 つと主張 8 つ（`002_linear_space_general.ts` の冒頭と `complex_numbers_form_a_field` の直後）を足し、主張ごとに同名の検算を付けた（未検算 104 → 103 件、証明を持つブロック 223 → 231 件）。(iv) の根拠の取り違え（交換子が 0 であることを引いていた）を直した。計算の誤りは無かった。次は `trace_basic_properties`。

2026-11-01: Lean の通しの証明のゴールラインの確認の二十九個目を行った。人手 `eigenvector_of_A_theta_tilde` の Step 3（固有ベクトルは `v_{±,μ}` の定数倍に限ること）は本文のどこからも使われず、階数・固有空間・次元を未定義のまま使っていたので、参照用ノート `claims_unused_by_chapter_goals_not_adopted` へ退避した。statement を「`c v_{±,μ}` は固有ベクトル」にし、Step 2 に `cv ≠ 0` の段を足した。Lean の主張は変えていない。次は台帳の「次の一歩」（単位行列などを定義するブロックの要否）。

2026-11-01: Lean の通しの証明のゴールラインの確認の二十八個目を行った。人手 `two_by_two_transfer_identity` の中間目標「`exp(tσ^x)` の閉じた形」の Lean（`exp_smul_pauliX`）を、`σ^x` の対角化から人手どおりの指数級数の偶奇分解へ書き換え、必要十分版 `NecSuf/ExpOfInvolution.lean` の系を `ClaimTwoByTwoTransferIdentityFromNecSuf.lean` に置いた。次は状態台帳の「次の一歩」の先頭（`eigenvector_of_A_theta_tilde` Step 3 の固有空間が 1 次元であることの扱い）。

2026-11-01: 全証明の SageMath 検算の連続実行の別の回が、同じ単位 `end_preserves_matrix_exponential` を並行して扱っていた。先に main へ入った版を残し、こちらの版は取り下げた。こちらのレビューで見つかった記号の衝突（数ベクトル `f` の成分 `f_l` が `def_end_iso` の基底の数ベクトル `f_K` と同じ形）だけを、main の版の `end_preserves_matrix_exponential` で `(f)_l` に直した。次は状態台帳どおり `def_invertible_elements_of_R`。

2026-11-01: Lean の通しの証明のゴールラインの確認の二十七個目を行った。`lean/scripts/check-docs-references.sh` に、`lean/README.md` と `lean/docs/` の表の人手証明の列のラベルが本文の `labels`・`id` にあるか、参照用ノートへ退避した記録があってそのノートが表の行か表の前の文で名指されていることの検査を足した。不合格の 93 か所は改名ではなくすべて退避か Lean の名前で、16 の表の前に退避先のノートを名指す一文を置き、Lean の名前に `Ising2D.` を付けて直した。次は状態台帳の「次の一歩」の先頭（`exp_smul_pauliX` を人手どおりの偶奇分解で直せるか）。

2026-11-01: Lean の通しの証明のゴールラインの確認の二十六個目を行った。章末の主張 `max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus` の Lean に (1)（`tr(εV^{(+)})` の閉じた形と正値性、`trace_of_epsilon_V_plus` そのもの）を立てて仮定 `htr` を外し、(2) を人手どおり `im Q̌_{(1,…,1)}` の元について冪等性の行から示す形に直した。次は状態台帳の「次の一歩」の先頭（対応表の人手ラベルの列のうち、いまの `labels` に無い 87 件の整理）。

2026-11-01: Lean の通しの証明のゴールラインの確認の二十五個目を行った。`lean/README.md` と `lean/docs/` の表の行か見出しにファイル名で出ない Lean のファイル 86 個を表へ載せ（67 個は既存の行にファイル名を書き足し、19 個は行を足した）、`lean/scripts/check-docs-references.sh` に「`Ising2D/` の全ファイルが表か見出しに出る」検査を足した。章末の主張 `max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus` の Lean が (1) を立てず (2) を仮定付きで示していることを状態台帳の「次の一歩」の先頭に足した。

2026-11-01: 全証明の SageMath 検算の連続実行として、`end_preserves_matrix_exponential`（行列表示と線型写像表示は指数関数を保つ）の検算 `sagemath/check/end_preserves_matrix_exponential/` を足した。証明が exp 級数の各点収束（行列と数ベクトルの積の収束）を `end` の作用の収束として断りなく使っていたので、二つの積の一致を主張 `end_agrees_with_matrix_vector_product` として足し、検算 `sagemath/check/end_agrees_with_matrix_vector_product/` を付けた（未検算 105 → 104 件、証明を持つブロック 222 → 223 件）。`end` を定義どおりに作る共通の準備 `sagemath/_shared/end_by_definition.sage` を置いた。計算の誤りは無かった。`def_end_iso` の記法 `Af` が `mat_mult` の積の記号を定義し直していることを状態台帳に記録した。次は `def_invertible_elements_of_R`。

2026-11-01: 全証明の SageMath 検算の連続実行として、`exp_of_diagonal_matrix`（対角行列の指数関数）の検算 `sagemath/check/exp_of_diagonal_matrix/` を足した。証明の最後の「成分の列の極限を二通りに求めて一致させる」段にラベル付きの根拠が無かったので、主張 `scalar_limit_is_unique`（数の列の極限は一意）を `003_exp_linear_map.ts` に足し、検算 `sagemath/check/scalar_limit_is_unique/` を付けた（未検算 106 → 105 件、証明を持つブロック 221 → 222 件）。冪の帰納法と極限の段を鎖に直し、部分和を `S_N` に改名した。計算の誤りは無かった。Lean の具体版が mathlib に委ねていて人手証明と対応しないことを状態台帳に記録した。次は `end_preserves_matrix_exponential`。

2026-11-01: 全証明の SageMath 検算の連続実行の十一回目として、`003_exp_linear_map.ts` の cosh・sinh の掛け算（ラベルが無かったので `cosh_sinh_product` を付けた）の検算 `sagemath/check/cosh_sinh_product/` を足した（未検算 107 → 106 件）。exp の性質を使わない行は独立な不定元で、積の法則の行は形式冪級数で厳密に、主張はボールで確かめた。レビューの指摘で、複数の操作を束ねた行を一ステップ一定理の 9 行の鎖に分けた。計算の誤りは無かった。次は `exp_of_diagonal_matrix`。

2026-11-01: 全証明の SageMath 検算の連続実行として、`complex_exp_of_real_argument`（実数の exp と複素数の exp は実数上で一致する）の検算 `sagemath/check/complex_exp_of_real_argument/` を足した（未検算 108 → 107 件）。ℂ は本文どおり実数の対で持ち（`sagemath/_shared/complex_as_real_pairs.sage`）、等号の行は全て厳密、極限の値だけをボールで確かめた。人手証明の散文の推論を冪・部分和の帰納法と収束の鎖に直し、ラベル無しの「ℂ の列の極限の一意性」を 1 行 1 列の行列の極限の一意性経由にした。ℂ の減法と行列の差が本文で未定義であることを状態台帳に記録した。計算の誤りは無かった。次は `calc_formulae_000_cosh_sinh_product`。

2026-11-01: Lean の通しの証明のゴールラインの確認の二十四個目を行った。`lean/README.md` と `lean/docs/` が書く `.lean` のパスと `Ising2D.` の名前の実在を確かめる `lean/scripts/check-docs-references.sh` を置いた。実在しないパスは 0 件、名前は README の `Ising2D.NecSufTensorPow`（正しくは `AbstractTensorPow`）の 1 件で、同じ表の実在しない人手ラベル `gamma_2_periodicity` とあわせて直した。表に出ない Lean のファイル 21 個と、いまの `labels` に無い人手ラベル 87 件を状態台帳の「次の一歩」に足した。次はその先頭（表に出ないファイルを章の記録へ足す）。

2026-11-01: 全証明の SageMath 検算の連続実行の九回目として、`real_exp_positive`（実数の exp は正）と `real_exp_strictly_increasing`（狭義単調増加）の検算 `sagemath/check/real_exp_positive/`・`real_exp_strictly_increasing/` を足した（未検算 110 → 108 件）。等号の行は `QQ[x]` の形式冪級数で厳密に、ノルムは `AA` で、不等号と主張は本文の exp を囲むボールで確かめた。レビューで人手証明の地の文の推論を鎖に直し、`E(a) = exp(a)` を 1 行 1 列の行列の極限の一意性経由にした。計算の誤りは無かった。次は `complex_exp_of_real_argument`。

2026-11-01: Lean の通しの証明のゴールラインの確認の二十三個目を行った。`ClaimEigenATildeDiag.lean` の `P̌_μ`・`c` を `DefinitionCheckFermi.lean` の `sqrtM` で書き直し、重複していた `sqrtM_cast_ne_zero` を消した（`sqrtM_ne_zero` と同じ主張）。次は状態台帳の「次の一歩」の先頭（`lean/README.md` と `lean/docs/` の対応表のパスの機械的な確認）。

2026-11-01: Lean の通しの証明のゴールラインの確認の二十二個目を行った。人手 `commutator_of_H_and_check_Z_Y` の必要十分版 `NecSuf/CommutatorSiteSum.lean` を具体版と同じ手順で置き、具体版 4 式を特殊化として導く `ClaimCommutatorHCheckZYFromNecSuf.lean` を置いた。境界の符号 `-1` という値は効かず、(A) には `η = p(M)`、(B) には `p(M)η = 1` だけが効く。(C)(D) は `M = 0` でも成り立つので、`H_2` 側の定理の連鎖から使われない `M ≠ 0` を外した。次は状態台帳の「次の一歩」の先頭（`sqrtM_cast_ne_zero` の整理）。

2026-11-01: 全証明の SageMath 検算の連続実行の八回目として、数の exp の三つの主張（部分和の極限・指数法則・`exp(0)=1`）の検算 `sagemath/check/scalar_exp_is_limit_of_partial_sums/`・`scalar_exp_product/`・`scalar_exp_zero/` を足した（未検算 113 → 110 件）。冪・部分和・指数法則の鎖は `QQ`・`QQ(i)` 上の多項式環と形式冪級数で厳密に、極限の値だけをボールで確かめた。三回のレビューで人手証明を直した（散文中の式変形を (∵) 付きの鎖に、数の冪 `x^{m+1}` を主張の約束に、`exp(0)=1` を行列の部分和が定数列 `[1]` であることと行列の極限の一意性から示す形に、`def_matrix_norm` に `K` の列の収束を追加）。`mat_mult` が `Mat(m,n,ℂ)` にしか定義されていないこと、`K` の列の極限の一意性にラベルが無いことを状態台帳に記録した。計算の誤りは無かった。次は `real_exp_positive`。

2026-11-01: 全証明の SageMath 検算の連続実行として、`kronecker_transpose`（クロネッカー積の転置）の検算 `sagemath/check/kronecker_transpose/` を足した（未検算 114 → 113 件）。因子の成分を `QQ` 上の多項式環の不定元に置き、`M = 1,…,4` で厳密に確かめた。主張の中で定めていた転置と未定義だった 2 次の行列の転置を、新しい定義 `def_matrix_transpose` へ切り出した。計算の誤りは無かった。あわせて、main の `nonzero_kernel_iff_det_zero_two_by_two` が入れた `⇒ ⇐` で `build:pdf` が落ちていたので、`tools/build-latex.ts` の和文で組む文字に U+21D0・U+21D2 を足した。次は `scalar_exp_is_limit_of_partial_sums`。

2026-11-01: 全証明の SageMath 検算の連続実行の六回目として、`sqrt_squared_is_original`（複素数の平方根の2乗は元に戻る）の検算 `sagemath/check/sqrt_squared_is_original/` を足した（未検算 115 → 114 件）。π の有理数倍の角度で cos・sin を 1 の冪根から作り、全て厳密。レビューで、最終行の「φ_cartesian ∘ φ_polar = id」を `isomorphism_of_phi_cartesian` の主張が述べていないと分かり、新しい主張 `phi_cartesian_after_phi_polar_is_identity` に切り出して検算を付けた。`isomorphism_of_phi_cartesian` の単射性が未証明であることを状態台帳に記録した。計算の誤りは無かった。次は `kronecker_transpose`。

2026-11-01: Lean の通しの証明のゴールラインの確認の二十一個目を行った。必要十分版 `NecSuf/TwoByTwoSkew.lean`（`A(θ̃_μ)` の固有値・固有ベクトル・対角化）を具体版の段と 1 つずつ対応する形に書き直し、具体版を特殊化として導く 12 本を `ClaimEigenATildeDiagFromNecSuf.lean` に置いた。`λ_+ ≠ λ_-` と `det P̌ ≠ 0` に効くのは `2s ≠ 0` だけ（標数 2 で崩れる）、人手 Step 2 の第 2 成分は `b = -ā` なしで閉じると分かった（本文を簡潔にするかは状態台帳の次の一歩）。次は `commutator_of_H_and_check_Z_Y` の必要十分版。

2026-11-01: 全証明の SageMath 検算の連続実行の五回目として、「（極座標表現）の乗法群」を扱った（未検算 116 → 115 件）。五回のレビューで、1 ブロック 1 主張に従い well-defined 性（積の定義の前へ移した）・モノイド・半径零の類の判定・逆元の存在・右逆元の一意性・群の七ブロックに分け、各ブロックに `sagemath/check/<ラベル>/` を付けた（共通の準備は `sagemath/_shared/polar_representation.sage`）。下流の φ_polar(z^{-1}) の二箇所は右からの積しか示していないので、一意性を片側の形で述べてそちらを引くようにした。計算の誤りは無かった。次は `sqrt_squared_is_original`。

2026-11-01: Lean の通しの証明のゴールラインの確認の二十個目を行った。人手 `eigenvector_of_A_theta_tilde` Step 1 が未定義の「固有値」と無証明の「固有値 ⟺ det(A(θ) - λI) = 0」を使っていたので、数学的道具立てに固有ベクトル・固有値・2×2 行列の行列式の定義と主張 `nonzero_kernel_iff_det_zero_two_by_two`（2×2 の成分計算）を足し、Step 1 を同値の鎖にした。Lean は `MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNonzeroKernelIffDetZeroTwoByTwo.lean` に人手の行ごとに置き、`eigenvalue_AMat_iff` を同じ鎖の `calc` にした。SageMath の検算を `sagemath/check/nonzero_kernel_iff_det_zero_two_by_two/` に置いた。rebase 先の「（極座標表現）の乗法群」の分割で足された内容名の id が棚卸しの分類規則に無く棚卸しの生成が落ちていたので、まとまり「角度・極座標・複素数の積と商」の規則に `^calculation_formulae_claim_.*polar` を足した。次は `NecSuf/TwoByTwoSkew.lean` から具体版を導く定理の欠け。
2026-11-01: 全証明の SageMath 検算の連続実行の四回目として、`arctan_argument_in_unit_interval`（arctan の引数は arcsin の定義域に入る）の検算 `sagemath/check/arctan_argument_in_unit_interval/` を足した（未検算 117 → 116 件）。`QQ[x]` と `AA` で全て厳密。レビューで人手証明を直した（平方根を取る前に中身の非負を示す順、背理法の鎖、一行一操作）。実数の絶対値が本文で未定義であることを状態台帳に記録した。次は `multiplicative_group_of_polar_representation`。
2026-11-01: 全証明の SageMath 検算の連続実行の三回目として、`arcsin_is_bijection` の検算 `sagemath/check/arcsin_is_bijection/` を足した（未検算 118 → 117 件）。弧の長さは内接・外接の折れ線で区間に挟んだ。レビューの指摘で `def_arcsin`（第二の式を `y'<0` に、終域を ℝ に）・`arcsin_is_bijection`（四項に書き下し、負の側・全射・連続を本文で証明）・`def_sin` を直した。次は `arctan_argument_in_unit_interval`。

2026-11-01: 全証明の SageMath 検算の連続実行の二回目として、`radial_normalization_exists_unique`（非零実数対の単位円への正規化）の検算 `sagemath/check/radial_normalization_exists_unique/` を足した（未検算 119 → 118 件）。一般の点は有理関数体上の環、正負・大小は `AA` で厳密に確かめた。レビューで人手証明の根拠の書き方（地の文の推論・ラベル参照の欠け・`\mathbf R`）を直した。計算の誤りは無かった。次は `arcsin_is_bijection`。
2026-11-01: 全証明の SageMath 検算の連続実行の一回目として、`mat_columnwise`（行列の積は列ごとに作用する）の検算 `sagemath/check/mat_columnwise/` を足した（未検算 120 → 119 件）。主張に `m,n,p` の帰属を足した。レビューで、`mat_mult` などの「数ベクトルを n 行 1 列の行列とみなす」同一視に約 60 箇所が依存していると分かり、状態台帳に記録した（この回では直していない）。次は `radial_normalization_exists_unique`。
2026-11-01: 代表の指示「全証明に SageMath をつけてほしい」を受け、ゴール台帳に「複素行列版イジング論文の全ての証明に、SageMath の検算が付いている」を立てた。判定は `sagemath/tools/verify-every-proof-has-check.ts`（証明を持つ 214 件のうち未検算 120 件）、手順は `docs/tasks/sagemath-every-proof-runbook.md`、進み具合は同 `sagemath-every-proof-state.md`。連続実行「複素行列版イジング: 全証明の SageMath 検算」が進める。ゴールの文の末尾は代表の答えどおり「安心して重要な部分だけを飛ばし読みしていただきたい」にした。
2026-11-01: 代表の指示で、冒頭の章の題を「章立て」から「この論文について」に改め、「この論文のゴール」の本文を代表の文（オンサーガーの方法を飛躍なく示すこと、物理的直感に頼る既存文献との違い、高校生でも読めること、SageMath と Lean による検証）に差し替えた（年は 1944 を補った）。各章のゴールの概要の冒頭に、そのゴールの式が何を示すかの一文を足した。代表の文のうち「全ての計算過程は SageMath による検証」は、代表の答えにより、全ての証明に検算を付けて事実にする（ゴール台帳）。
2026-11-01: 代表の依頼で、章番号を第 0 章から振るようにした。冒頭の「章立て」が第 0 章、「計算公式」が第 1 章になり、定理番号も「0.1」から始まる。振り出しは `structured-latex/tools/chapter-numbering.ts` の宣言 1 つで、HTML と PDF（`\setcounter{section}{-1}`）の両方がそれを読む。あわせて、章立ての章の論文のゴール・部と章の並び・各章のゴールの式の 11 ブロックを、注意（`remark`）からシステムに足した概要（`overview`）へ替え、id の種別部分も `_overview_` に直した（ラベルは不変）。

2026-11-01: 代表の指示で、冒頭の章立ての章の依存関係の図を「部と章の並び」の注意の冒頭へ移した（導入の一文 → 図 → 流れの説明 → 部と章の箇条）。図は注意の本文の図式ノードになり、末尾の見出し「章の依存関係」・その注意・図表ブロック（ラベル `chapter_organization_dependencies`・`figure_chapter_dependencies`）は無くなった。PDF でも注意の見出しより上に図が出ないよう、図の前に一文を置いている。

2026-11-01: Lean の通しの証明のゴールラインの確認の十九個目を行った。人手 `T_V_plus_eq_T_check_Vprime_on_check_Z_Y` の Lean を、`ψ̌^† ∓ ψ̌` の直接計算の代用から、人手 Step 1 の `P̌_μ^{-1}` を経る 3 行の鎖（`checkZY_row_eq_rowMul_checkPmat_inv`）と Step 2・Step 3 の鎖どおりに直した（主張の型は不変、代用の旧補題 6 本は消した）。必要十分版 `NecSuf/RowVectorRightInverse.lean` と導出を置いた。次は人手 `eigenvector_of_A_theta_tilde` に固有値の定義と行列式との同値の証明を足す。
2026-11-01: Lean の通しの証明のゴールラインの確認の十八個目を行った。人手 `eigenvector_of_A_theta_tilde` の statement「固有値は `λ_{±,μ}` の 2 つ」を `eigenvalue_AMat_iff` として立て、Step 1 の「固有値 ⟺ `det(A(θ) - λI) = 0`」を 2×2 の複素行列の成分計算 `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two` で示した（mathlib の分数体経由の一般論は使わない）。必要十分版 `NecSuf/TwoByTwoKernelAndDeterminant.lean` と導出を置いた。人手側で固有値が未定義・同値が無証明であることを状態台帳に積んだ。次は `T_V_plus_eq_T_check_Vprime_on_check_Z_Y` Step 1 を人手どおりに直す。
2026-11-01: Lean の通しの証明のゴールラインの確認の十七個目を行った。人手 `commutation_V_plus_check_psi` の Lean を、`P̌` の列を `ActsBy.eigen` へ直接渡す形から、行ベクトルと 2×2 行列の積（`rowMul`・`rowApply`）の上の結合律・Step 1・対角化 `A = P̌ĎP̌^{-1}` と `P̌^{-1}P̌ = I` を経る Step 2 の鎖どおりに直した。対角化が `P : IsingParam` を取るので、下流の `TVPlus_eq_TCheckVprime_on_checkZY` ほか 2 本も `P` を取り、仮定 `hlamPlus`/`hlamMinus` を `λ_{±,μ} = e^{±g}` の形にした。仮定を埋めた `TVPlus_checkPsiDag_checkPsi` を足した。次は `eigenvector_of_A_theta_tilde` Step 1 の固有値と行列式の同値が要るかを判断する。
2026-11-01: Lean の通しの証明のゴールラインの確認の十六個目を行った。人手 `constant_c_value_even_sector` Step 2 の `U exp(S) U^{-1} = exp(USU^{-1})`（`Uflip_conj_matExp`）を、`Matrix.exp_units_conj` に委ねる形から人手どおりの証明（`US^kU^{-1} = (USU^{-1})^k` → 部分和の共役 → ノルム評価による極限との交換 → 極限の一意性）に直した（主張の型は不変）。`matExp_hasSum`（`def_exp`）を `Representation.lean` へ移し、`matExp_units_conj` を消した。必要十分版 `NecSuf/ConjugationOfExpSeries.lean` と導出を置いた。人手 Step 2 に「和を保つ」を足した。次は `commutation_V_plus_check_psi` を人手の対角化の鎖どおりに直す。
2026-11-01: Lean の通しの証明のゴールラインの確認の十五個目を行った。人手 `nesting_of_commutator_of_H_and_check_Z`（入れ子交換子）と `cosh_sinh_coefficient_conversion_for_check`（展開係数への変換）の Lean を、必要十分版 `adCLM_pow_*` へ直接渡す形から、人手の帰納法（基底段階・帰納段階 1・2）と補題 1・補題 2・代入の鎖どおりの `calc` に直した（16 本の主張の型は不変）。同じ手順の必要十分版 `NecSuf/NestedCommutatorTwoDim.lean`・`NecSuf/IteratedCommutatorSmul.lean` を置き、導出を `*FromNecSuf.lean` に置いた。次は `Uflip_conj_matExp` を `Matrix.exp_units_conj` に委ねず人手どおりに示す。
2026-11-01: Lean の通しの証明のゴールラインの確認の十四個目を行った。章の結論 `TVPlus_checkZ_checkY`（人手 `T_V_plus_check_Z_Y`）を、必要十分版 `NecSuf.actsBy_TV_sandwich` の直接呼び出しから、人手の (z)・(y) の 6 行の鎖と最後の 2 行どおりの `calc` に直した（主張の型は不変）。旧証明は `TVPlus_checkZ_checkY_of_necSuf`（`ClaimTVPlusActionFromNecSuf.lean`）へ移した。linearity の 3 本から未使用の仮定を外した。次は `cosh_sinh_coefficient_conversion_for_check` の具体版を人手どおりか確かめる。
2026-11-01: 可算二次元イジングの連続実行の書式統一として、「H₂ と反周期 Fourier 成分の交換関係」の準備の三行へ行末根拠を付けた。主張・計算の内容は変えていない。

2026-11-01: Lean の通しの証明のゴールラインの確認の十三個目を行った。人手 `extract_taylor_coefficient_of_check_Z_Y` の 4 式の Lean を、指数共役へ戻して必要十分版に委ねる形から、人手の 4 行（係数変換・偶奇分割・定数の括り出し・cosh/sinh のテイラー級数）どおりの `HasSum` 版に直した（`∑'` 版の型は不変）。必要十分版は級数の和の部分を `NecSuf.hasSum_two_dim_series`（位相 ℂ 加群）として切り出し、導出を `ClaimExtractTaylorFromNecSuf.lean` に置いた。次は `TVPlus_checkZ_checkY` の手順の確認。

2026-11-01: Lean の通しの証明のゴールラインの確認の十二個目を行った。人手 `conjugate_index_of_check_Z_Y` (2) `e^{-ijθ~_{M+1-μ}} = e^{ijθ~_μ}` の Lean を、`2M` 乗根の周期で示す形から、人手の 4 行（(1)・指数法則・Euler の公式・`cos(2πj)=1, sin(2πj)=0`）と 1 行ずつ対応する `calc`（`checkPhase_conj'`）に直し、`checkPhase_conj` をその系にした（主張の型は不変）。次は `extract_taylor_coefficient_of_check_Z_Y` を人手どおりに直す。

2026-11-01: Lean の通しの証明のゴールラインの確認の十一個目を行った。必要十分版 `NecSuf/PermSector.lean` が退避先 `MinusSector/ClaimRayleighSupSectorDecomposition` から使う名前（符号つきの `c_±(M)`、その有界性、分解 `c(M) = max(c_+, c_-)`）は退避した主張そのものなので import は外せず、必要十分版は `NecSuf/` から動かさない規約により残した。理由を冒頭に書いた。本文の Lean は推移的にも退避先を読み込まない。次は `checkPhase_conj` を人手どおりに直す。

2026-10-31: Lean の通しの証明のゴールラインの確認の十個目を行った。本文 `DefinitionH1H2V1V2.lean`（H_1, H_2, V_1, V_2 の定義）から整数運動量の経路の記録 `DefinitionHatZHatY` の import を外し、`Z`・`Y` の定義のファイルを直接 import した。整数運動量の `hat(Z), hat(Y)` を主張に持つ仮定つき版 `TV_hatZ_hatY_of_action`（と `'`）を数学的道具立て `DefinitionTgAndTV.lean` から退避先 `ClaimTVActionsOnHatZHatY.lean` へ、主張・証明を変えずに移した。間接 import に頼っていた 2 本に直接 import を足した。退避先を推移的に読み込む本文・必要十分版のファイルは `NecSuf/PermSector` の 1 本。次はその import。

2026-10-31: Lean の通しの証明のゴールラインの確認の九つ目を行った。本文 `ReductionToATheta/DefinitionHalfIntegerModes.lean` から整数運動量の経路の記録 `ClaimH1H2ViaHatZHatY` の import を外した。そこから借りていた `expPhase_congr` は、人手に対応項目の無い合同形の補題 `checkZ_congr` などだけが使っていたので、それを使う人手 `conjugate_index_of_check_Z_Y` (3) を人手どおり「添字を `(1-μ)+M` と書き直して周期性を当てる」`calc` に直し、合同形の 3 補題を消した。間接 import に頼っていた 4 本に直接 import を足した。退避先を直接 import する本文・必要十分版のファイルは 2 本。次は `DefinitionH1H2V1V2.lean` の `DefinitionHatZHatY`。

2026-10-31: Lean の通しの証明のゴールラインの確認の八つ目を行った。整数運動量の経路の記録 `DefinitionNumberOperator` の `tensorPow_two_torsion_free`（`Mat(2^M, ℂ)` で `x + x = 0 → x = 0`）を本文 `EigenvaluesOfVPlus/DefinitionCheckNumberOperator.lean`（人手 `check_number_operator_idempotent` (1) の「`2 ≠ 0` なので 2 で割る」）へ移し、証明を人手の鎖 `x = ½·2x = ½·0 = 0` に書き直した。そのファイルと `CheckFermiInput.lean` から `RoutesNotAdopted/` の import を外した。通しの定理が使う退避先の定数は 0 個。退避先を直接 import する本文・必要十分版のファイルは 3 本。次は `DefinitionHalfIntegerModes.lean` の import。

2026-10-31: Lean の通しの証明のゴールラインの確認の七つ目を行った。整数運動量の経路の記録 `DefinitionFermiPsi` の `sqrtM`・`sqrtM_ne_zero`・`sqrtM_sq`（`√M` を ℂ に置く補助）を、主張・証明を変えずに本文 `DiagonalizationAndExponentialForm/DefinitionCheckFermi.lean`（人手 `def_check_fermi` の係数の分母）へ移し、そのファイルから `RoutesNotAdopted/` の import を外した。通しの定理が使う退避先の公開の定数は `tensorPow_two_torsion_free` の 1 個。本文が退避先を直接 import するのは 4 本。次は `tensorPow_two_torsion_free`。

2026-10-31: Lean の通しの証明のゴールラインの確認の六つ目を行った。本文の `ReductionToATheta/ClaimTActionsOnCheck.lean` が整数運動量の経路の記録 `ClaimTVActionsOnHatZHatY` の補題で `calc_of_TxT_check_Z_Y` を必要十分版から直接出し、そこから `T_actions_on_check_Z_Y` の 4 式を読み取っていた（人手と逆向き）ので、4 式を人手の式変形どおりの `calc` で示し、2 列に並べて `B_1`・`B_2` を出すようにした（主張の型は不変。人手の `V_2` 版 `actsBy_TConj_V2_check` を追加）。経路に依らない 4 補題と必要十分版からの導出は `ReductionToATheta/ClaimTActionsOnCheckFromNecSuf.lean` へ置いた。通しの定理が使う退避先の公開の定数は 4 個。次は `DefinitionFermiPsi` の `sqrtM` の 3 定数。`extract_taylor` が必要十分版に委ねている件などは状態台帳の「この後に残る確認」に載せた。

2026-10-31: Lean の通しの証明のゴールラインの確認の五つ目を行った。本文の `DiagonalizationAndExponentialForm/ClaimEigenATildeDiag.lean`・`ClaimDetATilde.lean`・`ClaimCommutationVPlusCheckPsi.lean` が整数運動量の経路の記録 `ClaimEigenvectorsAndDiagonalizationOfATheta` の固有ベクトル・行列式の補題（`AMat_mulVec_eigen`・`det_AMat`・`det_AMat_eq_one`・`gamma2_mul_gamma2_neg`、対角化は `Pmat`・`AMat_mul_Pmat`）を借りていたので、人手 `eigenvector_of_A_theta_tilde`・`diagonalization_check_P_D`・`det_A_theta_tilde` を人手の式変形どおりに書き直した（主張の型は `charPoly_factor_thetaTilde` を `det(A(θ)-λI)` の形にした以外は不変）。通しの定理が使う退避先の公開の定数は 8 個。次は `ClaimTVActionsOnHatZHatY` の 4 定数。`commutation_V_plus_check_psi` が対角化を経由していない件などは状態台帳の「この後に残る確認」に載せた。

2026-10-31: Lean の通しの証明のゴールラインの確認の四つ目を行った。本文の `EigenvaluesOfVPlus/ClaimVPlusPositiveDefinite.lean`・`ClaimConstantCEvenSector.lean` が整数運動量の経路の記録 `ClaimConstantCAndEigenvaluesOfV` の一般形（`VmatInv`・`tauTrace` など 8 定数）と `Vmat_posDef` を `η = -1` で借りていたので、人手 `V_plus_is_positive_definite`・`V_plus_is_invertible`・`constant_c_value_even_sector` Step 1〜2 を `S_1^{(+)}` について人手の式変形どおりに書き直した（`VPlusInv` の係数は人手どおり `(2s_2)^{-M/2}`。主張の型は `trace_VPlusInv` を人手の形にした以外は不変）。通しの定理が使う退避先の公開の定数は 12 個。次は `ClaimEigenvectorsAndDiagonalizationOfATheta` の 4 定数。`Uflip_conj_matExp` が `Matrix.exp_units_conj` に委ねている件は状態台帳の「この後に残る確認」に載せた。

2026-10-31: Lean の通しの証明のゴールラインの確認の三つ目を行った。人手のサイト添字 `1`・`M_col` を表す補助定義 `firstSite`・`lastSite` は整数運動量の経路に依らないので、退避先 `RoutesNotAdopted/IntegerMomentum/ClaimCommutatorHAndHatZHatY.lean` から巡回添字 `nextSite` と同じ `PartitionFunction/ProjectionAndJordanWigner/DefinitionH1H2V1V2.lean` へ移し、本文の 2 ファイルから退避先の import を外した。通しの定理が使う退避先の公開の定数は 20 個。次は `ClaimConstantCAndEigenvaluesOfV` の 8 定数（状態台帳の「次の一歩」）。

2026-10-31: Lean の通しの証明のゴールラインの確認の二つ目を行った。本文の `ClaimAnticommutatorCheckZY.lean`（人手 `anticommutator_of_check_Z_Y`）が整数運動量の経路の記録 `ClaimAnticommutatorHatZHatY` の汎用補題で人手の 3 行を束ねていたので、第 1〜3 式を人手の式変形と 1 行ずつ対応する `calc` に書き直し、Clifford 形 `acomm_Z_Z_clifford`・`acomm_Y_Y_clifford` は `ReductionToATheta/ClaimAnticommutatorZY.lean` へ移した（主張の型は不変）。通しの定理の `RoutesNotAdopted/IntegerMomentum/` への依存は 23 定数に減った。次は `ClaimCommutatorHAndHatZHatY` の `firstSite`・`lastSite`（状態台帳の「次の一歩」）。依存の洗い出しは `import Ising2D` した一時ファイルで `getUsedConstantsAsSet` を辿り、宣言モジュールが `Ising2D.RoutesNotAdopted` で始まるものを数える（`lake env lean` で実行。コミットしない）。

2026-10-31: Lean の通しの証明のゴールラインの確認の一つ目を行った。通しの定理が推移的に使う定数のうち `RoutesNotAdopted/` で宣言されたものを Lean のメタプログラムで洗い出し、`EigenvalueProblem/ReductionToATheta/ClaimCommutatorHCheckZY.lean`（`commutator_of_H_and_check_Z_Y`）が退避した `H1_H2_via_check_Z_Y` を使っていたので、人手の Step 1〜4（サイトごとの交換関係 → 和へまとめる → 境界の二項の等式）どおりに書き直した（(A)〜(D) の主張の型は不変）。これで (A)〜(D) は `CliffordTriple.lie_sum_*` の特殊化ではなくなった（必要十分版は未作成）。残る依存は `RoutesNotAdopted/IntegerMomentum/` の共有補題 31 定数（一覧は状態台帳）。次はそれらの判定と移動。

2026-10-31: 章立ての組み直し（runbook `docs/tasks/paper-organization-runbook.md`）を完了した。完了の確認をやり直し、ゴールラインの全項目が成り立つことを別のエージェントの独立の照合を含めて確かめ、ゴール台帳の「複素行列版イジング論文の構成再編が、公開物を読むだけで進捗まで分かる」を達成にした。作業の順序の外の残り（冒頭の「この論文のゴール」が本文で示していない異方な臨界条件と未定義の「自由エネルギー」を書いていること、数学的道具立ての中の前方参照、臨界点の章末の $\gamma$ の書き方など）は状態台帳の「未確定」に在る。

2026-10-31: Lean の通しの証明の項目 7 で、参照用ノート `claims_unused_by_chapter_goals_not_adopted.ts` へ退避した主張だけのファイル 3 本（旧 `Part004/ClaimEpsilonActionEigenvalues`（と `FromNecSuf`）、旧 `Part013/Claim007_H1H2ViaCheck`）を `lean/Ising2D/RoutesNotAdopted/ClaimsUnusedByChapterGoals/` へ番号を外した名前で移し、runbook に置き場を足した（名前空間・主張・証明は不変）。旧番号のフォルダ（`Part000`〜`Part020`）は無くなった。本文の `ClaimCommutatorHCheckZY` が退避した `H1_H2_via_check_Z_Y` の形式化を使っており人手証明と 1 対 1 でない。次はゴールラインの確認（状態台帳の「次の一歩」）。

2026-10-31: Lean の通しの証明の項目 7 で、本文から退避した (−) セクターの形式化 8 ファイル（旧 `Part010/` の 2 本、`Part011/Claim010_SectorDecomposition`、`Part004/OddEigenvectors`、`Part019/` の 4 本）を `lean/Ising2D/RoutesNotAdopted/MinusSector/` へ番号を外した名前で移した（名前空間・主張・証明は不変）。`Part010/`・`Part011/`・`Part019/` は無くなった。次は参照用ノート `claims_unused_by_chapter_goals_not_adopted.ts` へ退避した主張だけのファイル（`Part004/` の 2 本、`Part013/` の 1 本）の置き場を runbook に足して移す。

2026-10-31: Lean の通しの証明の項目 7 で、本文から退避した整数運動量の経路の形式化 19 ファイル（旧 `Part004/` の `hat(Z), hat(Y)`、`Part007/`、`Part008/`、`Part009/`、`Part013/Claim001_WhyMinusOnly`）を `lean/Ising2D/RoutesNotAdopted/IntegerMomentum/` へ番号を外した名前で移した（名前空間・主張・証明は不変）。`check-no-sorry.sh` の該当定理は新しい区切りへ集めた。次は (−) セクターの形式化を `RoutesNotAdopted/MinusSector/` へ移す。

2026-10-31: Lean の通しの証明の項目 7 で、部「数学的道具立て」の最後のまとまり「三角関数の評価・有限和・積分」を移した。旧 `Part012/Theorem004_RiemannSumToIntegral` と `Part020/` の 3 本（正弦の初等評価・対数積分の閉形式・正弦を含む積分の両側評価）を `lean/Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/` へ番号を外した名前で移した（名前空間・中身は不変）。`Part012/`・`Part020/` は無くなり、数学的道具立てのファイルはすべて `MathematicalTools/` にある。次は整数運動量の経路の形式化を `RoutesNotAdopted/IntegerMomentum/` へ移す（状態台帳の「次の一歩」）。

2026-10-31: Lean の通しの証明の項目 7 で、部「数学的道具立て」のまとまり「トレース・共役転置・正定値性」を移した。旧 `Part009/Definition001_Trace`・`Part009/Claim013_PositiveDefinite`・`Part011/Claim005_PsdCauchySchwarz` と補助の `Part011/Basic` を `lean/Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/` へ番号を外した名前（補助は `RealMatrixBilinearFormAndNorm`）で移した（名前空間・中身は不変）。判定の根拠は状態台帳。次は最後のまとまり「三角関数の評価・有限和・積分」（`Part012/Theorem004_RiemannSumToIntegral` と `Part020/` の 3 本）。worktree では `lake` が PATH に無いことがあるので `~/.elan/bin` を足す。

2026-10-31: Lean の通しの証明の項目 7 で、部「数学的道具立て」のまとまり「可逆行列・線型写像との対応・共役変換」を移した。旧 `Part000/Claim045_ConjugationIsRingHom`（と `FromNecSuf`）と旧 `Part008/Definition016_TV`（`T_g`・その線型性と、整数運動量の経路の `T_{(V)}`）を `lean/Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/` へ番号を外した名前で移した（名前空間・中身は不変）。`Part000/` は無くなった。`Definition016_TV` は数学的道具立て 2 項と整数運動量の経路 2 項の同数なので、規則どおり数学的道具立てへ置いた。次は「トレース・共役転置・正定値性」（状態台帳の「次の一歩」）。

2026-10-31: Lean の通しの証明の項目 7 で、部「数学的道具立て」のまとまり「行列指数関数と交換子計算」を移した。旧 `Part004/ClaimExpOfDiagonalMatrix`（`exp_of_diagonal_matrix`）を `lean/Ising2D/MathematicalTools/MatrixExponentialAndCommutators/ClaimExpOfDiagonalMatrix.lean` へ移した（名前空間・中身は不変）。「数ベクトル・行列の長さと収束」には形式化したファイルが無い。次は「可逆行列・線型写像との対応・共役変換」の `Part000/Claim045_ConjugationIsRingHom`（と `Part008/Definition016_TV` の置き場の判断）。

2026-10-31: Lean の通しの証明の項目 7 で、部「数学的道具立て」のまとまり「有限行列・Pauli行列・交換子」を移した。旧 `Part000/Claim046_CommutatorViaAnticommutators`・`Part002/Lemma001_ScalarIdentityCommutes`・`Part002/Lemma003_CentralizerIsScalar` を `lean/Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/` へ番号を外した名前で移した（名前空間・中身は不変）。`Part002/` は無くなった。次は「数ベクトル・行列の長さと収束」以降のまとまりに形式化したファイルがあるかを調べ、無ければ「可逆行列・線型写像との対応・共役変換」の `Part000/Claim045_ConjugationIsRingHom`。

2026-10-31: Lean の通しの証明の項目 7 で、部「数学的道具立て」のまとまり「クロネッカー積と多因子基底」を移した。旧 `Part002/Theorem000_TensorBasis`（と `FromNecSuf`。`tensor_basis`）を `lean/Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/TheoremTensorBasis.lean`（と `TheoremTensorBasisFromNecSuf.lean`）へ移した（名前空間不変）。本文 `content/002_linear_space_general.ts` とノートの中の Lean のパスも直した。「角度・極座標・複素数の積と商」「絶対値・偏角・複素平方根」には形式化したファイルが無い。次は「有限行列・Pauli行列・交換子」。

2026-10-31: Lean の通しの証明の項目 7 で、部「数学的道具立て」の、形式化したファイルがある最初のまとまり「実数の平方根・指数関数・双曲線関数」を移した。旧 `Part020/Claim001_CoshAddHalfAngle`（`cosh, sinh` の加法定理と半角公式）を `lean/Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimCoshAdditionAndHalfAngle.lean` へ移した（名前空間不変）。棚卸しの先頭のまとまり「集合記号と複素数の直交座標計算」には形式化したファイルが無い。次は形式化したファイルのある次のまとまり。

2026-10-31: Lean の通しの証明の項目 7 の九番目（最後）の章「臨界点 K_c と d²f/dK² の対数発散」を移した。6 ファイル（旧 `Part020/` の `κ`・`A` と臨界条件、`κ(K)` の基本性質、`γ` の `κ` 微分、`G''` と `f''` の対数発散、章末のゴールの主張）を `lean/Ising2D/CriticalPoint/CriticalPointAndLogDivergence/` へ移した（名前空間不変。番号を外した名前にした）。人手の定義と別表示だった `KStar`（`arsinh(1/sinh 2K)/2`）を消して `Kstar`（`-(1/2)log(tanh K)`）に一本化し、`κ'` は人手どおり `dK^*/dK = -1/sinh 2K`（`hasDerivAt_Kstar`）から、`κ(K)=0 ⟺ K=K_c` は `critical_point_iff_kappa_zero` から出すようにした。`Part020/` に残る 4 本は数学的道具立ての項。次は数学的道具立てのまとまりを一つずつ移す。

2026-10-31: 完了の確認で見つかった差の三つ目（最後）を直した。`T_V_plus_is_conjugation`・`V_plus_factors_invertible` を対角化の章から離散 Fourier 変換の章へ移し、章末の主張 `T_V_plus_check_Z_Y_via_B1_B2_B1` を V^{(+)} による共役から始まる一続きの式変形にした（SageMath・Lean・説明ページを揃えた）。次は作業の順序の七番目（完了の確認）のやり直し。

2026-10-31: 章立ての組み直しの完了の確認で見つかった差の二つ目を直した。対角化の章の章末に章立て案のゴールの式を主張する `A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form`（A(θ̃_μ) の対角化、λ_{±,μ}=exp(±γ(θ̃_μ))、γ(θ) の明示形、ψ̌_μ・ň_μ の定義の再掲、V^{(+)} の指数表示）を置き、SageMath・Lean・`goalLabels`・説明ページを揃えた。旧章末の `V_plus_eq_c_exp_sum_gamma_check_number_operator` は次の章が引くので残した。次は離散 Fourier 変換の章の T_{(V^{(+)})} を共役の約束と合わせること（状態台帳の「次の一歩」）。公開は `publish.ts --repo math`（`masaori/math` ではない。`masaori/math` に出すと別の成果物ができ、`/math/<path>/` は更新されない）で、`--path` は `complex-matrix-ising-paper` と `complex-matrix-ising-paper-organization`。

2026-10-31: 章立ての組み直しの完了の確認で見つかった差の一つ目を直した。射影の章の章末に章立て案のゴールの式を主張する `W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form`（WP^{(+)}=V^{(+)}P^{(+)}、F^{(+)}=im P^{(+)}、V^{(+)} の指数表示）を置き、V^{(+)} の指数表示を新しい主張 `V_plus_exponential_form` にした。旧章末の `symmetrized_transfer_matrix_on_sector_exponential_form` は使われなくなったので `structured-latex/notes/symmetrized_transfer_matrix_on_sector_exponential_form_not_adopted.ts` へ退避（SageMath は `sagemath/_old/` へ、Lean は記録として残す）。次は対角化の章の章末の主張（状態台帳の「次の一歩」）。worktree の Lean は `.lake/packages` を `cp -al` で持ち込めば論文側だけのビルドで済む（約 3 分で該当章まで）。

2026-10-31: Lean の通しの証明の項目 7 の八番目の章「M→∞ の極限と閉形式」を移した。19 ファイル（旧 `Part011/` の `c_+(M)` の定義・`c_+ ≤ c`・`ε^⊤ = ε`・`εW = Wε`・`W` の成分の正値性と必要十分版の導出、旧 `Part012/` の `γ` の連続性、旧 `Part004/` の `Z_m, Y_m` の線型独立性と必要十分版の導出、旧 `Part018/` の 10 本全部）を `lean/Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/` へ移し（名前空間不変。番号を外した名前にした）、`Part018/` は無くなった。import・コメントのパス・`lean/README.md`・`lean/docs/` の対応表を直した。判定の根拠は状態台帳。次は部「臨界点」の章。

2026-10-31: 章立ての組み直しの七番目の項目（完了の確認）を行った。並び・見出し・章をまたぐ前方参照 0・題の物理用語 0・説明ページの依存の図・全検証は成り立ったが、3 章（射影の章、対角化の章、離散 Fourier 変換の章）の章末の主張が章立て案のゴールの式と違うので、ゴールは未達のまま。差を状態台帳の「次の一歩」に三つの単位として書いた（最初は射影の章の章末に章立て案のゴールの式を主張するブロックを置くこと）。

2026-10-31: Lean の通しの証明の項目 7 の七番目の章「N→∞ の極限と最大固有値 c(M)」を移した。8 ファイル（旧 `Part011/` の `c(M)` の定義・`‖Wx‖ ≤ c(M)‖x‖`・`trace_power_sandwich` と補題・分配関数の挟み撃ち 2 本、旧 `Part012/` の `N_row → ∞` の極限 2 本）を `lean/Ising2D/ThermodynamicLimit/RowLimitAndMaxEigenvalue/` へ移し（名前空間不変。番号を外した名前にした）、import・コメントのパス・`lean/README.md`・`lean/docs/` の対応表を直した。判定の根拠は状態台帳。次は「M→∞ の極限と閉形式」の章。

2026-10-31: 章立ての組み直しの六番目の項目（冒頭の章立ての説明ページと本文の照合）を済ませた。ゴールの式と題は一致。依存図の矢印「射影の章 → N→∞ の極限の章」を、推移簡約の結果どおり「V^{(+)} の固有値の章 → N→∞ の極限の章」に替え（`W_is_real_symmetric_positive_definite` が `iH_is_real_symmetric` を引くため）、説明文を直した。番号付きファイルの先頭に部見出し「数学的道具立て」を置き、旧部見出し「対角化の計算 (ホロノミック量子場 付録B)」を消し、道具の章見出し 3 つ（004・006・008）を中身に合わせて改題した。次は七番目（完了の確認）。

2026-10-31: Lean の通しの証明の項目 7 の六番目の章「V^{(+)} の最大固有値に属する固有ベクトル」を移した。15 ファイル（旧 `Part018/` の `Claim001`〜`Claim003`・`Theorem007`・開鎖とトレースの 10 本・`Setup`）を `lean/Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/` へ移し（名前空間不変。番号を外した名前にし、`Setup` は `CheckFermiInput` とした）、import・コメントのパス・`lean/README.md`・`lean/docs/ch018-formalization.md` を直した。判定の根拠は状態台帳。次は部「熱力学極限」の「N→∞ の極限と最大固有値 c(M)」の章。

2026-10-31: Lean の通しの証明の項目 7 の五番目の章「V^{(+)} の固有値」を移した。12 ファイル（旧 `Part017/` の 9 本全部、`Part009/Claim016_SignFlip`、`Part012/Theorem005_OnsagerFreeEnergy`、`Part018/Claim012_VPlusDataFromPart017`）を `lean/Ising2D/EigenvalueProblem/EigenvaluesOfVPlus/` へ移し（名前空間不変。番号を外した名前にした）、`Part017/` は無くなった。import・コメントのパス・`lean/README.md`（前の章の行の抜けも補った）・`lean/docs/` の対応表を直した。判定の根拠は状態台帳。次は「V^{(+)} の最大固有値に属する固有ベクトル」の章。

2026-10-31: 章立ての組み直しの五番目の項目（どの章のゴールからも辿れない 7 項）を済ませた。本文で使われていない 5 項を `structured-latex/notes/claims_unused_by_chapter_goals_not_adopted.ts` へ退避し（013・017 のファイルは空になり削除）、根拠なしに使われていた `V1_plus_square_root_property`（tr(εV^{(+)}) の証明）と `even_eigenspace_is_complex_subspace`（Λ^{(1/2)} ≤ c ≤ 2Λ^{(1/2)} の証明）を引く形に直して使う章へ移した。どの章にも割り当てていない項と後ろの章を指す案内の参照はどちらも 0。次は六番目の項目（冒頭の章立ての説明ページを本文と照合）。

2026-10-31: Lean の通しの証明の項目 7 の四番目の章「A(θ̃_μ) の対角化と V^{(+)} の指数表示」を移した。26 ファイルを `lean/Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/` へ移し（名前空間不変。番号を外した名前にした）、`Part015/`・`Part016/` は無くなった。import・コメントのパス・`lean/README.md`・`lean/docs/` の対応表を直した。`Part017/Definition001_CheckNumberOperator` は次の章の項目が多いので残した。次は部「固有値問題」の「V^{(+)} の固有値」の章。

2026-10-31: 章立ての組み直しの「γ(θ) の定義を主張から分ける」一単位を行った。γ(θ) := arccosh(γ_1(θ))（θ∈ℝ）を新しい定義 `def_gamma_theta`（対角化の章のファイル、`def_gamma1_gamma2_of_theta` の直後）に分け、γ(θ~_μ) はその値として定義を一本化した。旧 `def_gamma_theta_tilde_mu` は γ(θ~_μ) > 0 の主張だけになったので、ラベルを `gamma_theta_tilde_mu_positive` に改めた。`gamma1_lower_bound_all_theta` は γ_1 の出典を `def_gamma1_gamma2_of_theta` に直すためその直後へ移した。Lean の `NecSuf.arcosh_pos_of_one_lt` は人手と同じ背理法の鎖で証明し直した。次は作業の順序の五番目（どの章にも割り当てていない 7 項の確認）。

2026-10-31: Lean の通しの証明の項目 7 の三番目の章「離散 Fourier 変換による 2×2 行列 A(θ̃_μ) への帰着」を移した。22 ファイルを `lean/Ising2D/EigenvalueProblem/ReductionToATheta/` へ移し（名前空間不変。番号を外した名前にした）、`Part006/`・`Part014/` は無くなった。import・コメントのパス・`lean/README.md`・`lean/docs/ch013`・`ch014`・`ch016` の対応表を直した。整数運動量の経路の記録は数えず残した。次は部「固有値問題」の「A(θ̃_μ) の対角化と V^{(+)} の指数表示」の章。

2026-10-31: Lean の通しの証明の項目 7 の二番目の章「ε の固有値 +1 の固有空間への射影と Jordan–Wigner 表示」を移した。16 ファイルを `lean/Ising2D/PartitionFunction/ProjectionAndJordanWigner/` へ移し（名前空間不変。番号付きの 5 本は番号を外した名前にした）、import・コメントのパス・`lean/README.md`・`lean/docs/ch010-formalization.md`・`ch011-formalization.md` を直した。`DefinitionSymmetrizedTransferMatrix` は項目数が同数なので並びで先のこの章へ置いた（レビューの指摘）。`lake build`・`check-no-sorry.sh`・`check-end-to-end.sh` は通る。新しい worktree で最初の `lake build` が olean の「no such file or directory」で落ちたが、再実行で通った。次は部「固有値問題」の「A(θ̃_μ) への帰着」の章。

2026-10-31: 章立ての組み直しの四番目の項目の九番目（最後）の章「臨界点 K_c と d²f/dK² の対数発散」を組み直し、章ごとの組み直しを全章終えた。10 項を `structured-latex/content/critical_point_and_log_divergence.ts`（部「臨界点」）へ依存順で移し（id・ラベル不変。008 の後半のファイルは空になったので消した）、章末にゴールの主張 `critical_point_sinh_K_c_and_second_derivative_log_divergence`（SageMath と Lean つき）を足した。(R3)(R4) の宣言を 020 に残った道具の前の注記 `remark_real_analysis_facts_R3_R4` へ分け、物理的な比熱の注記は参照用ノートへ退避した。次は γ(θ) の定義を主張から分ける一単位（状態台帳の「次の一歩」）。

2026-10-31: Lean の通しの証明の項目 7（フォルダを章立てに合わせる）の最初の章「転送行列による表示」を移した。14 ファイルを `lean/Ising2D/PartitionFunction/TransferMatrixRepresentation/` へ移し（名前空間不変）、import・コメントのパス・`lean/README.md`・`lean/docs/ch010-formalization.md` を直した。置き場の規則（章は `Ising2D/<部>/<章>/`、項目の章は棚卸しの `chapterKey`、混在ファイルは形式化している項目の多数決、数学的道具立ては `MathematicalTools/`、退避した経路は `RoutesNotAdopted/`）を runbook の項目 7 に書いた。`lake build`・`check-no-sorry.sh`・`check-end-to-end.sh` は通る。次は「ε の固有値 +1 の固有空間への射影と Jordan–Wigner 表示」の章。

2026-10-31: Lean の通しの証明の項目 6 を終えた。通しの定理 `onsager_exact_solution_end_to_end`（`lean/Ising2D/Part018/TheoremOnsagerExactSolutionEndToEnd.lean`）を立て、`lean/scripts/check-end-to-end.sh` が通る（`sorryAx` 非依存）。Step 1 の `c(M) > 0` は人手どおり `def_rayleigh_sup` から（`onsager_limit_in_N_row_physical`）。ゴール台帳の「Lean で通しに証明」は、フォルダの組み直し（項目 7）が残るので未達のまま。次は項目 7 の最初の章「転送行列による表示」（状態台帳の「次の一歩」）。

2026-10-31: 章立ての組み直しの四番目の項目の八番目の章「M→∞ の極限と閉形式」を組み直した。9 項と案内文・注記 4 つを `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts` へ依存順で移し（id・ラベル不変。018 は空になったので消した）、`onsager_exact_solution` の Step 2・3 を独立した主張 `c_between_Lambda_half_and_twice_Lambda_half` にし、章末にゴールの主張 `c_plus_value_c_sandwich_and_double_limit_of_log_Z`（SageMath と Lean 付き）を置いた。`c_plus_equals_Lambda_half_integer` の根拠欄を `\blkref` に直したので、未割り当てだった `check_number_operator_is_hermitian`・`Z_Y_linearly_independent` もこの章に入った（未割り当ては 7 項）。SageMath の 053 の .sage は `sage file.sage` では prelude を見つけないので、`__file__` をそのディレクトリに置いた小さな .sage から load する。次は臨界点の章（020 の 9 項と 008 の 1 項）。

2026-10-31: Lean の通しの証明の項目 5（`hWcomm`・`hWpos` の除去）を終えた。人手 `W_has_positive_entries` の Step 1〜3 を具体的な `V_1^{1/2} = exp(½K_1D)`・`V_2` について `lean/Ising2D/Part011/ClaimPhysicalWHasPositiveEntries.lean` で形式化し（`W_has_positive_entries_physical`、全成分版 `physicalSymTransferR_pos`）、Step 3 の必要十分版 `NecSuf/SandwichByDiagonal.lean`（係数は結合律・可換律を仮定しない半環、正値性は前順序と `PosMulStrictMono` だけ）と導出 `ClaimPhysicalWHasPositiveEntriesFromNecSuf.lean` を置いた。`hWcomm` は既存の `epsilon_commutes_with_W` で埋めた。入力の構造 `EvenSectorClosureInput` を消し、最終定理 `onsager_exact_solution_unconditional` の入力は結合定数の組 `P : IsingParam` だけになった。次は項目 6（通しの定理 `onsager_exact_solution_end_to_end`。状態台帳の「次の一歩」）。

2026-10-31: Lean の通しの証明の項目 4（`tr(εV^{(+)}) > 0`）を終えた。人手 `trace_of_epsilon_V_plus` の Step 4（トレースを二つのスピン和で書き閉じた式にする）・Step 5（正値性）と主張を `lean/Ising2D/Part018/ClaimTraceEpsilonVPlusClosedForm.lean` で形式化し（`trace_of_epsilon_V_plus`）、最終定理の入力 `EvenSectorClosureInput` から `htr` と `hM` を外した。人手側の未解決: Step 4 の最後の式鎖の 3 行目は根拠に `2·2^{M_col-1} = 2^{M_col}` だけを挙げるが `cosh(K_1)(cosh K_1)^{M_col-1} = (cosh K_1)^{M_col}` も使っており、4 行目は根拠（指数法則 `exp(-M_colK_2) = (exp(-K_2))^{M_col}` と積の冪の分配）を書いていない。ほかに、Step 4 冒頭の `tr(X) = ∑_s X_{ι(s),ι(s)}` は根拠に `def_trace` だけを挙げるが `ι` の全単射性による和の付け替え（`def_config_basis_iso`）も使う。式鎖の 1 行目は定数を和の外へ出す分配も使う。Step 5 の「また exp(±K_2) > 0」は、実際に使う因子 `exp(±M_colK_2) > 0` の誤記で、「Step 4 の最初の等号」は最後の式鎖の 1 行目を指すと明記すべき。次は項目 5（`hWcomm`・`hWpos` の除去。状態台帳の「次の一歩」）。

2026-10-31: 章立ての組み直しの四番目の項目の七番目の章、部「熱力学極限」の最初の章「N→∞ の極限と最大固有値 c(M)」を組み直した。9 項を `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts` へ依存順で移し（id・ラベル不変）、011 の案内文を二つに分け、章末にゴールの主張 `partition_function_sandwich_and_limit_in_N_row`（SageMath と Lean 付き）を置いた。章の依存関係の図に V^{(+)} の固有値の章からの矢印が無い件は状態台帳の「未確定」に引き継いだ。次は「M→∞ の極限と閉形式」の章（011 の 5 項・012 の 2 項・018 の 2 項）。

2026-10-31: Lean の通しの証明の項目 4d のうち人手 `trace_of_epsilon_V_plus` の Step 3（配置の基底での成分の読み取り (a)(b)(c)）を `lean/Ising2D/Part018/ClaimTraceEpsilonVPlusMatrixEntries.lean` で形式化した（`exp(K_1D_0)`・`G` の対角性、`εf_{ι(s)} = f_{ι(-s)}`、`V_2` の二つの特別な成分）。必要十分版は置かない。人手側の未解決: Step 4 の「(b)、ε は行番号 ι(s) を ι(-s) に移す置換行列」は、(b) の列の形 `εf_{ι(s)} = f_{ι(-s)}` から行の形 `ε_{ι(s),J} = δ_{J,ι(-s)}` へ移るのに `-(-s) = s` を断らずに使っている（Lean は行の形を `epsilon_apply` から導いた）。次は Step 4・Step 5 と `htr` の除去（状態台帳の「次の一歩」）。

2026-10-31: 章立ての組み直しの四番目の項目の六番目の章「V^{(+)} の最大固有値に属する固有ベクトル」を組み直した。15 項を `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts` へ依存順で移し（id・ラベル不変）、018 の案内文を二つに分け、章末にゴールの主張 `max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus`（SageMath と Lean 付き。Lean は tr(εV^{(+)}) > 0 を仮定に取る）を置いた。次は部「熱力学極限」の最初の章「N→∞ の極限と最大固有値 c(M)」。新しい worktree では `lake exe cache get` の後に `lake build` が要る。公開は publish-artifact の `--repo math`（`masaori/math` にすると別の名前空間に新しく作られ、検証スクリプトが見る `math/<パス>` は更新されない）。

2026-10-31: Lean の通しの証明の項目 4d を人手 `trace_of_epsilon_V_plus` の Step の単位で三つに割り、最初の「Step 1・Step 2 の形式化」を終えた。`lean/Ising2D/Part018/ClaimTraceEpsilonVPlusReduction.lean` で `tr(εV^{(+)}) = tr(εV_1^{(+)}V_2)`（`trace_epsilon_VPlusOfTransfer`）と `εV_1^{(+)} = exp(K_1D_0)(cosh(K_1)ε + sinh(K_1)G)`（`epsilon_mul_V1plus`）を形式化した。`exp(K_1εG)` の偶奇分解は `A^2 = 1` と極限の扱いだけで通るので、必要十分版 `NecSuf/ExpOfInvolution.lean`（仮定は部分和の極限）と系の導出を置いた。人手側の未解決: Step 1 の `BB = V_1^{(+)}` の行は根拠に `theorem_exp_product` を引いているが、平方根性 `V1_plus_square_root_property` を引くほうが正確である。また Step 1 冒頭の「ε は V_2 とも可換」は式変形で使っていない。次は「成分の読み取りの形式化」（Step 3。状態台帳の「次の一歩」）。

2026-10-31: 章立ての組み直しの四番目の項目の五番目の章「V^{(+)} の固有値」を組み直した。16 項を `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts` へ依存順で移し（id・ラベル不変。017 には未割り当ての 2 項だけが残る）、章末にゴールの主張 `V_plus_eigenvalues_with_c_value_and_strict_maximum`（SageMath と Lean 付き）を置いた。worktree の Lean は、メインの作業ツリーの `lean/.lake/packages` を `cp -al`（ハードリンク）で持ち込めば mathlib を作り直さずに論文側だけビルドできる。次は「V^{(+)} の最大固有値に属する固有ベクトル」の章（018 の 15 項）。

2026-10-31: 章立ての組み直しの四番目の項目の四番目の章「A(θ̃_μ) の対角化と V^{(+)} の指数表示」を組み直した。29 項を `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` へ依存順で移し（id・ラベル不変、014・015・016 は削除）、章末にゴールの主張 `V_plus_eq_c_exp_sum_gamma_check_number_operator`（SageMath と Lean 付き）を置いた。レビューで、γ(θ) の定義が主張の中にある問題と arccosh の分類の問題を状態台帳の「未確定」に足した。次は「V^{(+)} の固有値」の章。

2026-10-31: 章立ての組み直しの四番目の項目の三番目の章「離散 Fourier 変換による 2×2 行列 A(θ̃_μ) への帰着」を組み直した。27 項を `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`（部「固有値問題」の最初の章）へ依存順で移し（本文不変）、章末にゴールの主張 `T_V_plus_check_Z_Y_via_B1_B2_B1`（SageMath・Lean つき）を足した。013・014 の章の案内文を新しい章の中へ移し、添字集合の定義から後ろの章を指す案内の文を外した。次は「A(θ̃_μ) の対角化と V^{(+)} の指数表示」の章。この VM の SageMath は `~/micromamba/envs/sage/bin/sage`、Lean は `~/.elan/bin`（非対話シェルの PATH に無い）。

2026-10-31: Lean の通しの証明の項目 4c として、人手 `def_open_chain_spin_energy`・`open_chain_partition_sum`・`open_chain_endpoint_product_sum`・`open_chain_spin_sums_positive`（1 次元開鎖の二つのスピン和と正値性）を `lean/Ising2D/Part018/ClaimOpenChainSpinSums.lean` で形式化した（全単射 `Φ(s) = (s(1); t)` による変数変換と積の展開）。値は可換半環で足りるので必要十分版 `NecSuf/OpenChainSpinSum.lean` と系の導出 `Part018/ClaimOpenChainSpinSumsFromNecSuf.lean` も置いた。次は項目 4d（`tr(εV^{(+)}) > 0` の本体。状態台帳の「次の一歩」）。

2026-10-31: Lean の通しの証明の項目 4b として、人手 `epsilon_D0_G_pairwise_commute`・`epsilon_G_is_involution`・`D0_G_diagonal_action`（`ε, D_0, G` の可換性、`(εG)^2 = I`、配置基底の上での `D_0, G` の対角作用）を `lean/Ising2D/Part018/ClaimEpsilonD0GCommuteAndDiagonalAction.lean` で形式化した。次は項目 4c（1 次元開鎖のスピン和。状態台帳の「次の一歩」）。

2026-10-31: Lean の通しの証明の項目 4（`tr(εV^{(+)}) > 0`）を四つに割り、最初の一つとして人手 `def_D0_open_chain_operator`・`def_G_boundary_operator`・`H1_plus_in_sigma_z_form`（`iH_1^{(+)} = D_0 + εG`）を `lean/Ising2D/Part018/DefinitionOpenChainAndBoundaryOperators.lean`・`ClaimH1PlusInSigmaZForm.lean` で形式化した。次は `ε, D_0, G` の可換性・`(εG)^2 = I`・対角作用（状態台帳の「次の一歩」）。

2026-10-31: Lean の通しの証明の項目 3 を終えた。具体的な `W` と `vPlusDataOf` の `V^{(+)}` についての `EvenSectorBridge` を `lean/Ising2D/Part018/PhysicalEvenSectorBridge.lean` の `physicalEvenSectorBridge` で構成し（章 011 側に `W_is_real_symmetric_positive_definite` の具体版 `physicalSymTransferR_isSymm`・`physicalSymTransferR_posDef` を足した）、最終定理 `onsager_exact_solution_unconditional` の入力から `bridge` と `hW` を外した。残る仮定は `htr`（項目 4）と `hWpos`・`hWcomm`（項目 5）。次は項目 4（状態台帳の「次の一歩」）。

2026-10-31: 章立ての組み直しの四番目の項目の二番目の章「ε の固有値 +1 の固有空間への射影と Jordan–Wigner 表示」を組み直した。27 項を `structured-latex/content/partition_function_projection_and_jordan_wigner.ts` へ依存順で移し（本文不変、010 は削除）、平方根性の主張を定義の直後へ先行して置き、章末にゴールの主張 `symmetrized_transfer_matrix_on_sector_exponential_form`（SageMath・Lean つき）を足した。次は固有値問題の部の最初の章「離散 Fourier 変換による A(θ̃_μ) への帰着」。

2026-10-31: Lean の通しの証明の項目 3b を終えた。人手 `c_plus_equals_Lambda_half_integer` Step 0（`𝓕^{(+)}` の上で `W` と `V^{(+)}` が一致する）を `lean/Ising2D/Part018/ClaimWEqVPlusOnEvenSector.lean` で形式化し、具体的な `W` と `VPlusR` についての実ベクトル版 `hWV_physical` を立てた（`EvenSectorBridge` の欄 `hWV`）。次は項目 3c（具体的な `W` についての `EvenSectorBridge` の構成と最終定理の `bridge`・`hW` の除去）。

2026-10-31: 章立ての組み直しの四番目の項目の最初の章「転送行列による表示」を組み直した。21 項を `structured-latex/content/partition_function_transfer_matrix_representation.ts`（部「分配関数」・章「転送行列による表示」）へ依存順で移し（本文不変、001 は削除）、章末にゴールの主張 `partition_function_via_pauli_transfer_matrices`（SageMath・Lean つき）を足した。組み直した章は `tools/content-modules.ts` の `TRAILING_CONTENT_FILES` で本文の末尾に置く。棚卸しの生成器は、旧い章から組み直した章への前方参照を組み直し途中のものとして区別する。次は射影と Jordan–Wigner 表示の章。

2026-10-31: 章立ての組み直しの三番目の項目として、棚卸しの生成器 `structured-latex/tools/build-flat-inventory.ts` に章の割り当てを入れた。章立て案の機械可読版は `tools/chapter-plan.ts`（章の題・ゴールのブロックのラベル・章立て案の項目数）。章の順に各章のゴールのブロックから依存閉包を取り、未割り当てのイジング側の項をその章へ入れる。旧ゴール（二章への節境界）のレビュー済み本文ハッシュ等の固定値は外した（いまの本文で 73 件落ちていた）。依存の抽出が数式中の `\blkref{…}` を拾っていなかったのと、改名前のラベル `def_H1_pm`・`def_V1_pm` を黙って無視していたのを直した。章ごとの数は 21・27・27・29・16・15・9・9・10、どの章からも辿れない項 9（理由は状態台帳）。論文構成の公開ページは章立てを表示する。次は「転送行列による表示」の章から本文を組み直す。

2026-10-31: Lean の通しの証明の項目 3 を三つに割り、最初の一つとして人手 `c_plus_equals_Lambda_half_integer` Step 2 の「`V^{(+)}` の成分は実である」を `lean/Ising2D/Part018/ClaimVPlusRealEntries.lean` で形式化した（`EvenSectorBridge` の欄 `Vr`・`hVr` を `VPlusR`・`vPlusDataOf_V_eq_map` として与える）。次は人手 Step 0 を具体的な `W` と `VPlusR` について実ベクトル上で立てる（状態台帳の「次の一歩」）。

2026-10-31: Lean の通しの証明の項目 2 を終えた。最終定理 `onsager_exact_solution_unconditional` の `Z` を具体的な `partitionFunction`、`c(M)` を具体的な `W` の Rayleigh 上限にし、仮定 `hZ1`・`hZ2`・`hcM` を外した（代わりに `bridge.W` が具体的な `W` に一致する仮定 `hW` が残り、項目 3 で消える）。人手に合わせて挟み撃ちの仮定を `N_row ≥ 1` だけで受け取るようにした。次は項目 3（`EvenSectorBridge` を具体的な `W` について構成する）。

2026-10-31: 章立ての組み直しの二番目の項目として、本文の章題・ブロック題 16 件から未定義の物理用語（偶セクター・半整数運動量・フェルミオン）を除き、対象を式で表す題にした。中身・ラベルは不変。次は章の割り当てを棚卸しの生成器に入れる。

2026-10-31: Lean の通しの証明の項目 2 のうち、具体的な分配関数についての挟み撃ちを `lean/Ising2D/Part011/PhysicalPartitionFunctionSandwich.lean` の `partition_function_sandwich_physical` で立てた（`V_1^{1/2}`・`V_2` の実対称性・可逆性・正定値性を人手 `W_is_real_symmetric_positive_definite` の経路で証明）。人手 `partition_function_via_transfer_matrix` は既に `Part001` で形式化済みだった。次は最終定理の `Z` を具体的な `partitionFunction` に置き換える（状態台帳の「次の一歩」）。

2026-10-31: Lean の通しの証明の項目 1 を終えた。`IsingParam.K2star := Kstar K2` とし、人手 `duality_c2_star_eq_s2_star_c2` を `lean/Ising2D/Part008/ClaimDualityC2StarEqS2StarC2.lean` で形式化して、最終定理の入力 `EvenSectorClosureInput` から双対関係の仮定 `hdual` を外した。次は人手 `partition_function_via_transfer_matrix` の形式化（状態台帳 [docs/tasks/lean-end-to-end-state.md](docs/tasks/lean-end-to-end-state.md)）。

2026-10-31: 代表の指示で、冒頭の章立ての章の最初に「この論文のゴール」を置いた。ゴールは自由エネルギーの閉形式を解析して臨界点を厳密に得ることで、分配関数による自由エネルギーの表示・熱力学極限での閉形式・閉形式からの臨界点の計算はそのための手順（代表の指示）。

2026-10-31: 章立ての組み直しの最初の項目として、$\Theta^{(\delta)}_M$ と $\Lambda^{(\delta)}_M$ を閉形式の定理 `onsager_free_energy_expression` から独立した定義 `def_Theta_delta_M`・`def_Lambda_delta_M` へ分け、定義だけを使う参照を付け替えた。`inventory:organization` は無関係な項目の固定値の照合で落ちたままで、棚卸しは再生成していない（次の次の項目「章の割り当てを棚卸しの生成器に入れる」で作り直す）。次は本文の題から未定義の物理用語を除く。

2026-10-31: 代表の依頼で、論文の冒頭に「章立て」の章（`structured-latex/content/chapter_organization.ts`）を足した。部と章の並び、各章のゴールの式、章の依存関係の図（図式ノード `diagram`）を持つ。文書順の先頭に置くのは `tools/content-modules.ts` の `LEADING_CONTENT_FILES` で宣言した（新しいファイル名に番号を振らないため）。冒頭に章が増えたので、既存の章番号・定理番号は 1 ずつずれた。本文の章の並びはまだ章立てどおりに組み直していないので、この章は組み直し後の構成を示している。`npm run inventory:organization` は HEAD の時点で「行列指数関数による共役の節候補のレビュー済み本文が変わりました: exp_conjugation_proof_008_theorem_exp_ad_series」で落ちる（今回の変更とは無関係。冒頭章の注意・図表は棚卸しの対象外）。

2026-10-31: 代表の依頼で章立て案を [docs/tasks/six-chapter-organization-proposal.md](docs/tasks/six-chapter-organization-proposal.md) に書いた。五段階で切る最初の案は項目数の偏りで退けられ、トレース・固有値問題（5章）・極限（2章）・臨界点の案に書き直した。章の依存関係の図（推移的に辿れる矢印は省いたもの）も追記した。各章のゴールの式は本文の記号どおりの数式で書いた。GitHub で崩れないよう、数式は ```math ブロックと $`…`$ で書く。章題は数学の言葉で書き、本文で未定義の物理用語（運動量・フェルミオン・セクター）を使わない（代表の指示）。分配関数の部は「転送行列による表示」「ε の固有値 +1 の固有空間への射影と Jordan–Wigner 表示」の2章（代表の指示）。依存関係の図は部ごとに枠で囲う。部の名前は分配関数・固有値問題・熱力学極限・臨界点。同日に代表が章立てを承認し、構成再編の runbook・状態台帳・ゴール台帳をこの章立てに改めた。同日、代表の指示で Lean を分配関数から閉形式まで仮定なしの通しの証明にし、フォルダを章立てに合わせる作業を [docs/tasks/lean-end-to-end-runbook.md](docs/tasks/lean-end-to-end-runbook.md) と判定スクリプト `lean/scripts/check-end-to-end.sh` で始めた。承認待ちで、本文と構成再編の runbook はまだ変えていない。

2026-10-28: 「比熱の対数発散」の極限へ行末根拠を付けた。次は「物理的な比熱との対応」の式鎖。

2026-10-28: 「比熱の対数発散」の距離による表示を行末根拠付きの式鎖にし、対数の上界を成立する 1.5519 に直した。次は同じ証明の極限。

2026-10-28: 「比熱の対数発散」の主要項を行末根拠付きの式鎖にした。次は同じ証明の総合評価。

2026-10-28: 「比熱の対数発散」の係数置換の誤差評価を行末根拠付きの式鎖にした。次は同じ証明の主要項。

2026-10-28: 「比熱の対数発散」の第1項の二階微分の絶対値上界を行末根拠付きの式鎖にした。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の末尾で、下界と発散の根拠を行末に付けた。次は「比熱の対数発散」の証明。

2026-10-28: 「二階微分の対数発散」で、二項の合成と最終の除法を行末根拠付きの式鎖にした。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の総合評価で、数値積の上界と有理数の加法を行末根拠として明記した。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の対数を含む第二項の絶対値上界を行末根拠付きの式鎖にした。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の双曲線余弦の差と対数を含む積の上界を行末根拠付きの式鎖にした。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の対数の分解と補正項の上界を行末根拠付きの式鎖にした。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の κ/δ と対数の上下界を行末根拠付きの式鎖にした。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の T の積分上界を行末根拠付きの式鎖にし、誤った丸めを 3.615 に訂正した。後続の 6.731 を経ても結論の 6/5 は維持される。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の T の被積分関数の上界を行末根拠付きの式鎖にした。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の J の補正項 R の数値上界を行末根拠付きの式鎖にした。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の J の補正項 R の上下界を行末根拠付きの式鎖にした。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の J の差の積分評価を行末根拠付きの式鎖にした。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の J の被積分関数の差の上界を、行末根拠付きの式鎖にした。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の二つの積分への分解で、補助量を先に定め、等式の各行へ根拠を付けた。同じ証明の続きが残る。

2026-10-28: 「二階微分の対数発散」の冒頭で、γ の偶性から G の偶性までを根拠付きの式鎖にした。同じ証明の続きが残る。

2026-10-28: 「初等的な正弦の上下界」の定数の数値評価を行末根拠付きの式鎖にした。

2026-10-28: 「γ の κ 微分とその上界」の末尾評価を行末根拠付きの式鎖にした。
2026-10-27: 「γ の κ 微分とその上界」の式鎖の行末根拠を揃え、既存の半角公式をラベルで参照した。

2026-10-27: 「κ(K) の基本性質」の微分と積分評価を式鎖に整え、数値上界の丸めを成立する有理数評価へ直した。

2026-10-27: 「臨界条件の同値」の正値性と双曲線恒等式の各行に、既存定理のラベル参照を付けた。

2026-10-27: 「γ₁(θ), γ₂(θ)」の (2,1) 成分一致を、既存の定義参照を保った等式鎖にした。

2026-10-27: 「チェック Z・Y についてのテイラー係数の抽出」で、四つの式鎖の展開係数の根拠を行末のラベル参照へ直した。

2026-10-27: 「チェック Z・Y の双曲線関数の展開係数への変換」で、二つの冪法則と分配律を別々の等号へ分けた。

2026-10-27: 「偶セクターの転送行列の共役作用」の重交換子の帰納法で、既存の根拠を等式の行末へ揃えた。

2026-10-27: 「T(V⁽⁺⁾) は V⁽⁺⁾ による共役である」の等式鎖で、根拠を行末の列に揃えた。

2026-10-27: 「H₁⁽⁺⁾・H₂をチェック Z・Y で表す」の式変形で、指数積と有限和に使う既存定理を式中からラベル参照した。

2026-10-27: 「Ž・Y̌ から Z・Y を復元する」の二つの式変形で、指数の積と有限和に使う既存定理のラベル参照を式中へ補った。

2026-10-27: 「V⁽⁺⁾ と半整数運動量フェルミオンの交換関係」で、行ベクトル計算の直後に既存の定義・主張の参照を補った。

2026-10-27: 「A(半整数運動量) の対角化」の固有ベクトル等式で、既存の固有ベクトルの主張を行末からラベル参照した。

2026-10-27: 「A(半整数運動量) の固有値と固有ベクトル」で、成分ごとの等式鎖が使う既存定義と主張のラベル参照を直後に補った。

2026-10-27: 「γ₂(半整数運動量) の非零性」の式変形で既存根拠を行末のラベル参照にした。

2026-10-27: 「γ₁(θ), γ₂(θ)」の証明で指数と余弦の置換を別々の等号にした。
2026-10-27: 「V⁽⁺⁾ の Ž・Y̌ への作用」の各等式で、従来の根拠を本文のラベル参照へ直した。

2026-10-27: 「A(θ) の三行列への分解」の各成分の等式鎖に分配則と既存定理の根拠を補い、(2,2) 成分の省略されていた四段を書き下した。

2026-10-27: 「直積作用」の証明で、二列の作用と小行列の定義を各等式行から既存ラベルで参照した。

2026-10-27: 「V₂ による共役写像の複素線型性」に、一続きの等式と適用した主張の根拠ラベルを補った。

2026-10-27: 「ZとYの反交換関係」の等式鎖で、クロネッカー積・Pauli 行列・線型性の根拠ラベルを行末に補った。

2026-10-27: 「指数を交換子へ適用した級数展開」の証明で、再帰の等式行末に根拠ラベルを補った。

2026-10-27: 「行列の可逆元」の積の逆元の証明で、代入と結合律を別々の等式行にした。

2026-10-27: 「Jordan–Wigner 行列の反交換関係」の証明で、反復した接続語と閉じ括弧の欠落を直した。

2026-10-26: 「サイトのパウリ行列の基底への作用」の式変形で、各等号の根拠となる既存本文ラベルを行末に明記した。

## 人間の読解メモ（2026-09-26）

次はここから読む: 「自由エネルギーと熱力学極限」の章の主張「N_row → ∞ の極限」（ラベル `limit_of_log_Z_in_N_row`）と、
定理「Onsager の自由エネルギーの表式」（ラベル `onsager_free_energy_expression`）の関連が理解できていない。
（2026-09-26 時点の公開 HTML での番号は主張 13.4 と定理 13.6。番号は組み替えで変わる。）

## 2026-09-26: (−) セクターを本文から参照用ノートへ退避した（第 3 段階。半整数運動量だけで書く構成の完了）

最終定理は c(M_col) ≥ c_+(M_col) と、W の成分の正値性と ε による上からの評価だけを使うので、(−) セクターを外した。
- 退避（`structured-latex/notes/minus_sector_not_adopted.ts`）: 奇セクターの固有ベクトル集合とその部分空間性、
  セクター上の置き換えとその冪、分配関数の偶奇セクター分解、c(M)=max(c_+,c_−)、「最大固有値はどちらのセクターから来るか」の章全体。
- ± で述べていた定義・主張を (+) だけにし、ラベルを `def_V1_plus`・`def_H1_plus`・`V1_plus_exponential_representation`・
  `def_V1_plus_square_root`・`V1_plus_square_root_property` へ改めた。偶セクターの章にあった H_1^{(+)}・平方根・V^{(+)} の
  重複定義を削り、V^{(+)} の定義を「偶セクターへの射影と転送行列」の章の 1 箇所にした。
- 新しい主張 `epsilon_is_real_symmetric`（ε^⊤ = ε）と `c_plus_le_c`（c_+ ≤ c）を立て、厳密解の証明はこれらを引く。
- 引用の誤り（ε² = I を射影子の性質から引いていた 4 箇所、存在しない項目 (4) への参照など）を直した。

## 2026-09-26: V_1, V_2 の定義を成分定義 1 つにし、記号を M_col・N_row・K_1・K_2 に統一した（第 2 段階）

人間の指示「パウリ行列での表記は定義ではない。転送行列の章の中で書き換えとして証明する」「N と M の記号を統一」
「N_row にするなら M_col」「同一視の章は名前を付け替える」「Lean もちゃんとリファクタする」に従った。

- 本文: V_1, V_2 の定義は分配関数の章の `def_transfer_matrix` だけ（行配置の番号付け ord を明示し、成分で定義）。
  パウリ行列表示は転送行列の章の主張 `first_transfer_matrix_pauli_form`・`second_transfer_matrix_pauli_form`。
  配置と基底の対応・σ^z の対角作用・対角行列の exp・2×2 の恒等式を転送行列の章へ移した。
  「分配関数をパウリ行列表示の転送行列で書く」は分配関数の章の表式と同じになったので削除した。
  同一視の章を「偶セクターへの射影と転送行列」に改題した。
- 記号: 列数 M_col、行数 N_row、結合定数 K_1（同じ行）・K_2（隣接行）、分配関数 Z(K_1, K_2)。J, J' と読み替えの断り書きは廃止。
  道具の章（計算公式・線型空間の一般論・行列の exp・指数関数の共役）の汎用の M は変えていない。
- Lean: 成分定義を `V1`・`V2`（`Part001/`）とし、パウリ形は `V1PauliForm`・`V2PauliForm`（定理 `V1 = V1PauliForm` 等は `Part004/`）。
  旧 `V1`（V_1^{(±)}）は `V1pm` 系、旧 `V2`（H_2 の指数形）は `V2H2Form` 系へ改名。Lean の束縛変数名は M・Nrow のまま。
  **未解決: 偶セクターの章以降の `VPlus` 系は V_2 の係数を独立な引数に取る一般形のまま**（人手の V_2 とは等式で接続。
  `lean/README.md` と `lean/docs/ch014-formalization.md` に明記）。
- SageMath: 分配関数・パウリ行列表示・番号付けの検査を新しい主張へ付け替え・追加し、厳密計算（QQ・AA）で通した。

次にやること: 上の第 3 段階の項を参照。

## 2026-09-26: 整数運動量の経路を本文から参照用ノートへ退避した（半整数運動量だけで書く構成の第 1 段階）

人間の指示で、本文を半整数運動量 θ̃_μ = 2π(μ−1/2)/M の経路だけで書く構成に組み替え始めた。
第 1 段階として、整数運動量 θ_μ = 2πμ/M の経路（Ẑ^{(±)}, Ŷ、ψ、V'、V の固有値、
「008 章の議論が (−) セクター専用である理由」、群論的な補題群）の 59 ブロックを
`structured-latex/notes/integer_momentum_route_not_adopted.ts` へ内容のまま運び、本文から外した。
`content/007_hatZ_hatY_anticommutation.ts` は空になったので削除した。008・009 の章題を中身に合わせて
「共役写像 T_g と行列 A(θ)」「トレース・エルミート行列・正定値性」に改めた。

- 半整数運動量の章（013〜018）と 010・012 から、整数運動量との比較・依存を除いた。論理的な依存は 2 箇所だけで、
  [H_2, Z_j] = −2Y_j の導出を `commutator_of_H_and_check_Z_Y` の Step 1 へ全段書き下して移し、
  `gamma_2_theta_tilde_nonzero` の Step 0 を双対結合定数の定義と添字つき略記の正値性から直接示す形にした。
- `critical_condition_c1_eq_s1_c2` の後半（γ2(θ_μ) の零点との対応）をノートへ移した。
- sinh・cosh のテイラー展開のブロックにラベル `sinh_cosh_taylor_series` を付け、014 章から明示的に引いた。
  **未解決: このブロックには証明が無い（既存の欠落）。実数の exp の級数表示が本文の土台に無いと書けない。**
- SageMath: 退避ラベルを対象とする 40 の検査を `sagemath/_old/integer-momentum-route/` へ移した。
  051 の段検算を新しい Step 1（142 段）と Step 0 へ合わせた。
- 公開 HTML・PDF の「ノート混入」検査は、本文ブロック自身にも同じ文言がある標本を照合から除くようにした
  （退避ノートが本文の対応ブロックと同じ文を持つため）。
- 棚卸し: 全 288 項。要再レビュー: 数学的道具立ての 2 節（可逆行列と共役写像、Pauli 行列と共役で保たれる行列群）は
  節末の主定理・定義が退避で抜けた。003 章の実数の exp の 7 項（別セッションの追加）は未レビュー。
  詳細は `docs/tasks/paper-organization-state.md` の同日の項。
- Lean は変更していない。整数運動量の Lean ファイルは形式化の記録として残し、対応先はノートである（`lean/README.md`）。
- 取り込んだ別セッションの変更（指数関数の記法統一、6936e4936）が、非負実数の平方根の存在証明→双曲線関数の基本性質→
  数の exp→行列の exp→行列ノルム→平方根、という依存の循環を作っていた。平方根の証明が借りていたのは
  「正の実数 a, b で a² = b² ⟺ a = b」だけなので、これを独立した主張 `positive_real_square_injective` として立てて循環を断った
  （SageMath 検査 `sagemath/check/positive_real_square_injective/`）。数の exp の定義から後続主張への案内の一文を削った。

（この段階の次の作業は上の 2026-09-26 第 2 段階の項に移した。）
## 2026-09-26: 指数関数の記法を exp に統一し、双曲線関数と arccosh を定義した

- 本文とノートの数式にあった e^{…}（実数・複素数・行列・線型写像の指数）を、すべて \exp(…) に書き換えた。書き換えは `structured-latex/tools/codemod-e-power-to-exp.ts` が行い、同じツールの `--check` を `npm run check` に組み込んだので、e^{…} を新しく書くと検査で落ちる。conversion の経緯の文字列は書き換えない。
- 実数の exp を実数・複素数の両方へ広げた（`def_one_by_one_matrix`・`def_scalar_exp`・`scalar_exp_is_limit_of_partial_sums`・`scalar_exp_product`・`scalar_exp_zero`、実数だけの `real_exp_positive`・`real_exp_strictly_increasing`、両者の一致 `complex_exp_of_real_argument`）。
- cosh・sinh の定義・積の公式・基本性質を計算公式の章から行列の exp の章の末尾へ移し、前提として列挙していた指数関数の性質を上の主張への参照にした。
- 実対数の定義は、exp の正値性と単調性を上の主張から引き、全射性だけを実解析の事実として残した。
- arccosh を log と非負平方根の式で定義し（`def_arccosh`）、非負・cosh との合成・非負側での一意性・arccosh(1)=0 を `arccosh_properties` で示した。使用箇所の根拠をこれらへ付け替えた。

未解決: Euler 公式 exp(iθ) = cos θ + i sin θ の導出と、cos・sin の全実数への拡張は未整備のまま（計算公式の章の Euler 表示に明記）。PDF の生成は tectonic の無い環境で行ったため未確認で、HTML の生成までは確認した。
メインの作業ツリーには半整数運動量の移行の未コミット変更があり、多くの本文ファイルと重なる。取り込み直すときは origin/main へ載せ替えたあと `node structured-latex/tools/codemod-e-power-to-exp.ts` を再実行すれば記法は揃う。

## 2026-09-26: 実数の exp を行列の exp の 1 行 1 列の場合として定義した

「V の固有値」の章で定義なしに使っていた e^{g(ε)} を exp(g(ε)) に書き換えた。行列の exp の章の末尾に、実数を 1 行 1 列の行列へ送る写像、実数の exp の定義（exp(x) := (exp([x]))_11）、指数級数の部分和の極限であること、積公式、exp(0)=1、正値性、狭義単調増加を追加し、「V の固有値」の章の根拠をこれらへ付け替えた。

（下記 2026-09-26 の指数関数の記法統一で解消）

## 2026-09-26: 同時固有空間分解の Q_ε の定義を R_μ^{(ε_μ)} の積へ揃えた

`joint_eigenspace_decomposition` の Q_ε を、選択係数 ε_μ n_μ + (1−ε_μ)(I−n_μ) の積から、`trace_of_number_operator_product` で定義済みの R_μ^{(ε_μ)} の積へ揃え、Q_ε が I = ∏(R^{(1)}+R^{(0)}) を展開した各項であることを主張に書いた。行列としては同じなので Lean（`Qproj` は元から選択の形）・SageMath は変更不要。

## 2026-09-26: 公開 HTML に主定理とサブ定理の区別と折りたたみを入れた

人間の指示で、公開 HTML を共有の既定 UI（`structured-latex/renderers/html/theorem-standing.ts`）へ
載せ替えた。節（見出し level 2）の冒頭に「この節の主定理」を並べ、主定理は開いたまま、
サブ定理は見出しだけを見せて既定で閉じる。定義・注意は常に開く。参照で閉じたサブ定理へ飛ぶと
自動で開く。

主定理は本文ブロックの `standing: "mainTheorem"` で宣言した32件である。判定基準は
「節の題名、またはその節の目的の注意書きが到達点として名指ししている主張・定理」だけとし、
道具を集めた節（計算公式、線型空間の一般論）には主定理を置いていない。宣言の無い主張・定理は
既定どおりサブ定理である。棚卸し（`docs/organization/flat-inventory.json`）は変化しない。

## 2026-09-23: 半整数運動量 Fourier Y 行列の添字周期性を独立主張へ分離

2次元イジングモデル章の章内依存順66に残っていた二性質から、
`\check Y_{\mu+M}=\check Y_\mu` だけを独立主張へ分けた。新主張は順66、旧ラベル
`def_half_integer_modes` を保持する残余主張は順67である。残余には共役添字恒等式だけを残し、
Y 周期性を使う参照だけを新ラベルへ移した。

人手証明と Lean 具体版は、角度の定義代入、分配、分数の加法、`M\neq0` による約分、負角の
Euler 公式、三角関数の周期性、有限和の定義展開・係数置換・定義再適用を一段ずつ対応させた。
有限和は `M_{\mathbb N}` と `j_{\mathbb N},j_{\mathbb Z},j_{\mathbb R}` を明示し、複素スカラーを
行列の左から掛ける定義へ統一した。SageMath も同じ各段を個別に検査し、Lean 必要十分版は既存の
周期性定理を複素行列へ特殊化した。

独立レビューは、数学、分類、依存方向、二章制約、人手証明・Lean・SageMath の対応を照合し、
未解消指摘なしだった。親側の照合で、013章の検査が179種類へ増えた一方、章 C′ の合計が旧値401の
まま残っていたため、正しい合計407へ修正した。分類と既存節境界、数学的道具立ての分類・節境界は
変更していない。

棚卸しは全339項、数学的道具立て109項、2次元イジングモデル230項である。次の一単位は順67に
残した共役添字恒等式一項だけを照合し、旧複合ラベルを内容名ラベルへ移す範囲を確定する。
半整数運動量の添字集合、複素指数の先行定義、周期デルタと整数運動量の分類移動、別の節境界、
数学的道具立ての分類・節境界には進まない。

プログラミングによる検証は、本文376ブロック、生成ラベル339件、相互参照2350件、棚卸し339項、
SageMath対応129件、章 C′ の4検査407種類と添字集合の2検査、Lean 3011ジョブ、PDF 386ページで
成功した。未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit`
は0件だった。

## 全六研究監督: check Z周期性の独立化を確認（2026-09-22 21:02 JST）

実行識別子 `7058aadb-fd8e-41f1-adef-9056db75e90b`。LLMによる検証では、check Zの添字周期性が位相移動・Euler公式・三角関数の周期性・有限和だけへ分離され、check Y周期性と共役添字恒等式を先取りしない依存が本文で読めるようになった。次はcheck Y周期性だけを独立化する。

## 2026-09-22: 半整数運動量 Fourier Z 行列の添字周期性を独立主張へ分離

2次元イジングモデル章の章内依存順65に残っていた三性質から、
`\check Z_{\mu+M}=\check Z_\mu` だけを独立主張へ分けた。新主張は順65、旧ラベル
`def_half_integer_modes` を保持する残余主張は順66である。残余には `\check Y_\mu` の添字周期性と
共役添字恒等式だけを残し、Z 周期性を使う参照だけを新ラベルへ移した。

人手証明と Lean 具体版は、角度の定義代入、分配、分数の加法、`M\neq0` による約分、負角の
Euler 公式、三角関数の周期性、有限和の定義展開・係数置換・定義再適用を一段ずつ対応させた。
有限和は `M_{\mathbb N}` と `j_{\mathbb N},j_{\mathbb Z},j_{\mathbb R}` を明示し、複素スカラーを
行列の左から掛ける定義へ統一した。SageMath も同じ段を個別に検査し、Lean 必要十分版は既存の
特殊化を保持した。

独立レビューでは、複数操作を含む等号、添字型とスカラー倍の向き、Lean 具体版が人手経路を
たどらない点、SageMath の段の圧縮、依存グラフの件数を検出した。修正後の再レビューでは、Lean の
有限和三段、SageMath の正準定義、Y 周期性の用途、生成物末尾を追加修正し、最終レビューは
残存指摘なしだった。分類と既存節境界、数学的道具立ての分類・節境界は変更していない。

棚卸しは全338項、数学的道具立て109項、2次元イジングモデル229項である。次の一単位は順66の
残余主張から `\check Y_{\mu+M}=\check Y_\mu` だけを分離する。共役添字恒等式、半整数運動量の
添字集合、複素指数の先行定義、周期デルタと整数運動量の分類移動、別の節境界、数学的道具立ての
分類・節境界には進まない。

プログラミングによる検証は、本文375ブロック、生成ラベル338件、相互参照2349件、棚卸し338項、
SageMath対応129件、対象の交換関係3検査と章 C′ の4検査、013章の段階検査173種類、Lean 3011ジョブ、
PDF 386ページで成功した。未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、
`sorry` / `admit` は0件だった。

## 全六研究監督: check Zの添字周期性を次対象として維持（2026-09-22 15:01 JST）

実行識別子 `4407661c-15c0-4656-9b0f-904ca4b494df`。LLMによる検証では、前回読解終点以後に
remote defaultへ統合された数学本文・証明・段取りの前進はない。共有位相の反周期性を独立化した成果と
依存順を維持し、次はcheck Zの添字周期性だけを独立主張へ分離する。

## 2026-09-22: 半整数位相の反周期性を独立主張へ分離

2次元イジングモデル章の章内依存順64にあった残余主張から、
`e^{-iM\tilde\theta_\mu}=-1` の証明だけを独立主張へ分けた。新主張は順64、旧ラベル
`def_half_integer_modes` を保持する残余主張は順65である。残余には `\check Z_\mu` と
`\check Y_\mu` の添字周期性および共役添字恒等式だけを残し、旧 (1) の現行参照を新ラベルへ移した。

本文の直接依存、Lean の対応表とコメント、SageMath の対象ラベル・実行記録、棚卸しの固定期待値を
同期した。独立レビューで、必要十分版からの導出が位相の基底だけを述べていたこと、行列の exp 積公式を
スカラーへ無標識に同一視していたこと、人手証明の複数操作が一行へ畳まれていたこと、SageMath が
各等号を個別検査していなかったことを検出した。必要十分版から `\mu\in\mathbb Z` ごとの具体的主張を
直接導出し、人手証明は Euler 公式、角度代入、余弦値、正弦値、零積、単位元を一段ずつ適用する形へ直した。
これに伴い、新主張と残余主張から行列の exp 積公式への直接依存を除いた。残余主張の添字周期性は、
Euler 表示と正弦・余弦の周期性だけで示し、行列とスカラーの同一視を使わない。

再レビューでは、残余主張に残っていた行列とスカラーの同一視、章別実行ログ、検査数の記録不一致を
検出した。スカラーだけの証明へ置き換え、章 C′ の四検査と章別ログを再生成し、状態記録を同期した。

棚卸しは全337項、数学的道具立て109項、2次元イジングモデル228項である。分類と既存節境界は
変更していない。次の一単位は、順65の残余主張から `\check Z_{\mu+M}=\check Z_\mu` だけを
分離する。Y 行列の添字周期性、共役添字恒等式、半整数運動量の添字集合、複素指数の先行定義、
周期デルタと整数運動量の分類移動、別の節境界、数学的道具立ての分類・節境界には進まない。

プログラミングによる検証は、本文374ブロック、生成ラベル337件、相互参照2345件、棚卸し337項、
SageMath対応129件、対象の交換関係3検査と章 C′ の4検査、013章の段階検査161種類、Lean 3011ジョブ、
PDF 385ページで成功した。未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、
`sorry` / `admit` は0件だった。

## 全六研究監督: check Z の添字周期性へ進む（2026-09-22 11:13 JST）

実行識別子 `7005d8ee-2e7f-4384-b77c-d0e247cc692d`。LLMによる検証では、`\check Z_\mu` と `\check Y_\mu` の二定義から共有位相の反周期性を独立主張へ分離し、本文・Lean 二版・SageMath・棚卸し・参照を同期したことを、READMEが求める読解可能な導出の前進と判定した。次は残余三性質の先頭にある `\check Z_\mu` の添字周期性だけを独立化し、`\check Y_\mu` の周期性と共役添字恒等式へ進まない。段取り変更と停止条件はない。

## 2026-09-22: 半整数運動量 Fourier 行列の二定義を分離

2次元イジングモデル章の旧章内依存順62から、`\check Z_\mu` と `\check Y_\mu` の二定義だけを
独立項へ分けた。新しい二定義は章内依存順62・63、反周期性、Z と Y の添字周期性、共役添字恒等式を
保持する残余主張は順64である。各定義には個別ラベルを与え、旧複合ラベルは残余主張に保持した。

二定義は半整数運動量の指数和、集合・代数構造の記号、複素数の定義を共通入力とし、Z 定義は
Jordan--Wigner の Z 行列族、Y 定義は Y 行列族だけを個別に使う。直前の `\hat Z` と `\hat Y` は
意味的前提にしていない。本文参照、Lean の対応表とコメント、SageMath の対象ラベル、棚卸し依存を、
位相角、各定義、残る性質の実際の使用先へ振り分けた。独立レビューで見つかった形式化対応表の
曖昧な「同上」は、残余主張の旧ラベルを明記して修正した。

棚卸しは全336項、数学的道具立て109項、2次元イジングモデル227項である。分類と既存節境界は
変更していない。次の一単位は、順64の残余主張から半整数位相の反周期性だけを分離する。
二つの添字周期性、共役添字恒等式、半整数運動量の添字集合、複素指数の先行定義、周期デルタと
整数運動量の分類移動、別の節境界、数学的道具立ての分類・節境界には進まない。

プログラミングによる検証は、本文373ブロック、生成ラベル336件、相互参照2342件、棚卸し336項、
SageMath対応129件、対象の交換関係・反周期性検査と013章の段階検査151種類、Lean 3011ジョブ、
PDF 385ページで成功した。未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、
`sorry` / `admit` は0件だった。

## 全六研究監督: 半整数運動量の二定義分割へ進む（2026-09-22 03:04 JST）

実行識別子 `abe2fce3-53cb-4316-b044-419b2750581f`。LLMによる検証では、共有位相の中立モジュール化と半整数運動量モードの分割境界を既存数学の依存整理と判定し、研究上の新しい前進には数えなかった。次はcheck Zとcheck Yの二定義だけを分割し、旧複合ラベル三十七参照を意味で振り分ける。四つの性質には進まない。段取り変更と停止条件はない。

## 2026-09-22: 半整数運動量モードの分割境界を記録

2次元イジングモデル章の現行章内依存順62を照合した。状態台帳の「半整数運動量の添字集合」は
棚卸し上では順63であり、直前の二つの Fourier 変換行列との境界という指定に一致する対象は
順62の `\check Z_\mu,\check Y_\mu` の複合項だった。

LLM による検証では、この一項に二つの行列定義、半整数位相の反周期性、両行列それぞれの添字周期性、
共役添字恒等式という計六項が同居し、Lean では対応する二定義と核心四定理のほか、合同形などの
補助定理四本があることを確認した。
三項以上の本文分割と形式化対応の同期になるため、本文・Lean・SageMathは変更せず、棚卸し生成器へ
六つの境界候補、将来分割が必要であること、次回に扱う先頭の二定義だけを固定した。

分割後の二定義は、半整数運動量の指数和、集合と代数構造の記号、複素数の定義を共通入力とし、
`\check Z_\mu` は Jordan--Wigner 行列族 `Z_m`、`\check Y_\mu` は同じく `Y_m` を個別に使う。
直前の `\hat Z_\mu^{(\pm)}` は係数の例外項との比較だけに使われ、`\hat Y_\mu` は提示順上の直前項で、
いずれも意味的前提ではない。次の一単位はこの二定義だけの分離と四層同期である。各定義に別ラベルを
設け、旧複合ラベルをどちらにも割り当てず、本文37参照、Lean対応コメント、SageMath対象ラベル、
棚卸し依存を実際に使う定義または残る性質へ振り分ける。反周期性、二つの添字周期性、共役添字恒等式、
半整数運動量の添字集合、複素指数の先行定義、周期デルタと整数運動量の分類移動、数学的道具立ての
分類・節境界には進まない。

独立 Codex の初回 LLM による検証では、SageMath 実行生成物の一時差分、旧複合ラベル37参照の
移行方針、Lean の補助四定理、`\hat Z` と `\hat Y` の提示理由の区別を指摘した。生成物差分を復元し、
残る三点を境界候補と次回指示へ反映した後の継続レビューは未解消指摘なしだった。

プログラミングによる検証は、本文371ブロック、生成ラベル334件、相互参照2323件、棚卸し334項、
SageMath対応129件、対象数値検査三群と013章の段階検査151種類、Lean 3011ジョブ、PDF 385ページで
成功した。未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit`
はいずれも0件だった。

## 全六研究監督: 独立化した二行列の共通位相依存を整理（2026-09-21 21:00 JST）

実行識別子 `35cea172-3027-43d1-ac6b-5e842132f49f`。LLMによる検証では、Fourier変換した hat Z と hat Y を相互非依存の定義へ分割し、所属・非零分母・添字範囲・一段一操作・最小幅検算を同期したことを研究上の前進と判定した。共有位相 expPhase の中立な先行モジュールへの移動を次の対象に維持し、本文の複素指数先行定義が未確定である境界も保った。段取り変更と停止条件はない。

## 2026-09-21: 共通位相因子を中立な先行モジュールへ分離

2次元イジングモデル章の `\hat Z_\mu^{(\pm)}`、`\hat Y_\mu`、整数運動量の指数和が共有する
Lean の `expPhase` と六つの基本補題を、指数和の形式化ファイルから中立な先行定義モジュールへ
移した。宣言・証明は変更せず、二つの Fourier 変換行列の定義は指数和を推移的にも読み込まない。
指数和を実際に使う三つの後続形式化には直接 import を補い、形式化対応表と全体 import を同期した。
本文、SageMath、棚卸しの項目・分類・節境界は変更していない。

独立 Codex の LLM による検証では、分類境界、依存方向、二章制約、高校生可読性、対応表、
変更範囲に未解消指摘はなかった。プログラミングによる検証では、移動前後の宣言・証明が完全一致し、
二つの定義から指数和への推移依存が無いことを確認した。Lean 全体3011ジョブと主要定理の
`sorryAx` 非依存検査も成功した。構造化本文の全検査、棚卸し再生成、SageMath対応129件、
PDF 385ページも成功し、未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、
`sorry` / `admit` はいずれも0件だった。

現行本文の複素指数そのものの先行定義と所属証明は未整備のままなので、この形式化分離だけで
半整数運動量の指数和の後を節境界として確定しない。次の一単位は2次元イジングモデル章の
章内依存順62にある半整数運動量の添字集合一項だけを照合する。順63以降、周期デルタと整数運動量の
分類移動、数学的道具立ての分類・節境界には進まない。

## 2026-09-21: Fourier 変換した二行列を独立定義へ分離

2次元イジングモデル章の旧複合項から `\hat Z_\mu^{(\pm)}` と `\hat Y_\mu` を独立した二定義へ
分け、章内依存順60・61へ置いた。各定義で格子幅の自然数像と整数・実数・複素数の像、非零分母、
添字の順序保存、Jordan--Wigner 行列の適用範囲、行列次数、実位相と複素位相引数の所属を明記した。
`\hat Z` の二表示は有限和の分割、先頭係数の評価、残りの係数の評価、単位係数の除去を一段ずつ
記した。旧複合ラベルは分割後の一方だけを指せないため廃止し、後続参照は使う定義ごとの新ラベルへ移した。

独立 Codex の初回 LLM による検証で、複素指数の定義と所属を未整備と明記する Euler 表示を
所属根拠にしていたこと、包含後の添字条件と行列次数の読み替えが無かったこと、一つの等号で
有限和の分割と係数評価を行っていたことを検出した。後二件は二定義内で修正した。複素指数の
先行定義は第三の本文項を要するため、二定義をその所属を仮定した条件付きの定義と明記し、本文完成・
節境界確定を保留した。SageMath は標準的な複素指数を用いるという範囲を明記し、最小幅 `M=1` の
空和を含む126判定を通した。

継続時の LLM による検証で、後続の偶セクターモードの証明に旧複合定義ラベルを根拠とする等号が
二つ残っていることを検出した。最初の等号は `\hat Z` の定義、最後の等号は `\hat Y` の定義を
それぞれ根拠とするよう修正し、分割後の定義ごとの依存を本文にも反映した。

別の独立 Codex による LLM の検証では、新定義と後続の定義展開で複素スカラーの左右が一致しないこと、
Lean 具体版に先頭項分離との対応定理が無いこと、旧複合ラベルを `\hat Z` だけへ残すと意味的互換に
ならないこと、および整数運動量の添字集合に新旧二記号が混在することを検出した。二定義と現役の
定義展開を Lean と同じ左スカラー作用へ揃え、Lean に有限和の分割、先頭係数、残りの係数、単位係数を
一段ずつ評価する定理を追加した。旧複合ラベルを除き、添字集合は既存の `\mathcal M` へ統一した。
複素指数を定義しない現行のオイラー表示は根拠ではないため、二定義の直接依存からも除いた。

Lean は `hatZ` と `hatY` を新ラベルへ個別対応させたが、共有する `expPhase` は指数和の形式化
ファイルに残した。次の一単位は `expPhase` と基本補題だけを中立な先行定義モジュールへ分離する。
複素指数の本文上の先行定義は未確定事項として保持し、章内依存順62以降、周期デルタと整数運動量の
分類移動、数学的道具立ての分類・節境界には進まない。

プログラミングによる検証は、本文371ブロック、生成ラベル334件、相互参照2323件、棚卸し334項、
SageMath対応129件、対象定義の数値検査126件、Lean 3010ジョブ、PDF 385ページについて成功した。
未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` は0件だった。

## 全六研究監督: Fourier変換した二定義の分割へ進む（2026-09-21 09:00 JST）

実行識別子 `855f8450-f011-4aad-9d8a-210ccabf73ff`。LLMによる検証では、半整数運動量指数和の型付き四層同期とFourier変換した二行列の分割境界を研究上の前進と判定した。次は共通位相を先行定義へ移し、hat Zとhat Yを独立定義へ分ける。段取り変更と停止条件はない。

## 2026-09-21: Fourier 変換した二行列の分割境界を記録

2次元イジングモデル章の Fourier 変換した行列の複合定義一項を照合した。独立 Codex の
LLM による検証で、現行ブロックは `\hat Z_\mu^{(\pm)}` と `\hat Y_\mu` の二定義を束ねており、
一ブロック一主張の規律に従うには二ブロックへ分ける必要があると判明した。さらに Lean の
複素位相は整数運動量の指数和を実装するファイルに置かれているため、中立な先行定義へ分離しなければ
指数和の節からの非依存を形式化側で再現できない。本文二定義と形式化上の位相定義という三項以上の
同期になるため、runbook に従って本文・Lean・SageMath・棚卸しは変更せず、半整数運動量の指数和の
直後を節境界候補のまま保持した。

同じ LLM による検証で、格子幅の自然数像、整数・実数・複素数の包含像、分母の非零性、円周率・
虚数単位・位相角の所属、実数から複素数への包含と複素数の体構造への直接依存が不足していること、
`\hat Z` の二表示が有限和の分割と係数評価を一段にまとめていること、SageMath が最小幅 `M=1` を
検査していないことも確認した。符号規約は三層で一致している。

プログラミングによる検証は、生成ラベルと棚卸し各333件、本文370ブロック、相互参照2308件、
SageMath対応129件、対象定義の数値検査116件、Lean 3010ジョブ、PDF 383ページについて成功した。
未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` は0件だった。

次の一単位は、現行複合ブロックから `\hat Z_\mu^{(\pm)}` と `\hat Y_\mu` の二定義だけを分け、
型付け・直接依存・一行一操作・最小幅の数値検査を同期する。Lean の複素位相定義の分離はその後の
別単位とし、順61以降、周期デルタと整数運動量の分類移動、数学的道具立ての分類・節境界には進まない。

## 全六研究監督: 半整数運動量の指数和を維持（2026-09-21 03:17 JST）

実行識別子 `6ecff40d-b8ca-4256-a1b1-4ed48c3e89f6`。LLMによる検証では、前回監督以後に
remote defaultへ統合済みの数学本文・証明・節境界の変更はなく、次の一単位を半整数運動量の
指数和に維持した。段取り変更と停止条件はない。

## 全六研究監督: 半整数運動量の指数和を維持（2026-09-20 20:57 JST）

実行識別子 `811465fd-4507-46a0-ab2c-38cbe3e537f7`。LLMによる検証では、前回監督以後に
remote defaultへ統合済みの数学本文・証明・節境界の変更はなく、次の一単位を半整数運動量の
指数和に維持した。段取り変更と停止条件はない。

## 2026-09-20: 半整数運動量の指数和を自己完結させる

2次元イジングモデル章の半整数運動量の指数和一項だけを同期した。主張は、記号
`\tilde\theta_\mu` の定義域 `\mu\in\mathbb{Z}` と有限和で実際に使う範囲
`\mu=1,\ldots,M` をその場で区別し、後続の半整数運動量添字集合を使わずに読める形へ直した。
実数の複素像は既存の `r_{\mathbb C}` 略記で明記した。証明は、法 `2M` の整数運動量指数和を
奇数番目と偶数番目へ分け、偶数番目である法 `M` の指数和を引く形にした。既存の `exp_sum` だけから
`2M\delta^{2M}_{(k,0)}-M\delta^M_{(k,0)}` を得て、`k=lM` では `l` の奇偶により
`M(-1)^l` を導く。「とくに」の非零の場合は、`M | k` から
`|l|<1` を得て `k=0` となる背理法、零の場合は `l=0` の整除の場合として導出した。一つの有限和の
評価だけで閉じているため、本文ブロックは分割しない。

Lean 具体版には、本文と同じ `Complex.exp` で奇偶分割のデルタ差を書く定理と、`|k|<M` かつ `k\neq0` なら和が零になることを既存の非整除の場合から導く系を
追加し、本文の「とくに」の二場合をともに明示した。必要十分版には本文と同じ奇偶分割の定理を追加し、
その複素数特殊化も別定理で接続した。形式化対応表には本文と同じ `Complex.exp` 形式の
デルタ差・二場合・二つの「とくに」を登録し、定数位相を括り出す閉形式は補助定理と明記した。
SageMath は奇偶分割による証明と「とくに」の導出を各段へ分け、013章の151種類を再実行し、全段成功した。最大残差は
`2.3e-14` だった。

独立 Codex の初回 LLM による検証で、一ステップ一定理の違反、Lean 具体版の系の欠落、検査実行が
生じさせた無関係な生成 Python 差分を検出し、同じ一項の範囲で修正した。棚卸しは全333項、
数学的道具立て109項、2次元イジングモデル224項を維持し、対象の分割フラグはともに偽、説明粒度は
主題に適合となった。継続時の独立 Codex による LLM の検証では、1次正方行列と複素数の型付け、
「とくに」の人手導出と形式化対応表、SageMath の一行対応の不足を検出した。最初の修正後も残った
写像の極限保存、整数絶対値の中間段、`M` の約分と零の場合の数値対応を再指摘した。さらに一般的な
複素指数則の導出が分類境界を越えることと、整数検査が有限例であることの未明記を指摘した。一般的な導出は削除して
既存定理の1次への特殊化に戻し、一般的な整数指数則の証明も削除して必要な前因子の評価に限定した。SageMathの整数部分は
`ZZ` 上の有限例、一般命題は Lean が担うと分けた。
今回の独立 Codex による LLM の検証では、なお残っていた1次正方行列から複素スカラーへの未定義な
型橋渡し、未登録の整数倍角公式、SageMathの証明経路不一致、本文同形のLean定理の対応表不足を検出した。
証明を上記の奇偶分割へ置き換えて最初の二問題を使わない形にし、SageMathと対応表を同じ経路へ同期した。
継続レビューの LLM による検証では、自然数・整数・実数・複素数の像の混同、後続定義の整数 `M` との
所属不一致、「とくに」の順序反映とLean具体版の経路不一致、補助的な閉形式の位置付け誤りを検出した。
本文の整数 `M` に対応する一意な自然数 `M_{\mathbb N}` を有限和と周期デルタだけに用い、包含像を別記号に分け、
整数上の正数倍による狭義順序の反映へ揃えた。Leanには `Complex.exp` 版デルタ差と必要十分版からの同形の橋を追加した。
修正後の独立 Codex による LLM の再検証では、自然数の項数から整数の格子幅への像の書換え、偶奇二場合の
複素数計算の段分け、複素体と整数冪の直接依存がなお不足していた。包含像の四つの一致を先に示して定義適用と
像の書換えを分離し、デルタ代入から整数冪評価までを一行一操作へ分け、`complex_numbers_form_a_field` を直接参照した。
最終の独立 Codex による LLM の検証では、自然数と整数の型表記、法の実数像の非零根拠、二つの指数和を
代入する段の左辺、絶対値の連鎖、および必要十分版から具体版へ渡す整除・非整除・小さい非零運動量の橋の
不足を検出した。各所属と非零性を本文へ補い、SageMath を本文の各等号へ対応させ、必要十分版から六つの
具体的な系を追加した。修正後の独立 Codex による LLM の再レビューは未解消指摘なしだった。
数学的道具立ての分類・節境界と
順60以降は変更していない。

プログラミングによる検証は本文370ブロック、相互参照2308件、SageMath対応129件、章C′の四検査379段、Lean 3010ジョブ、
PDF 383ページで
成功し、未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、
`sorry` / `admit` は0件だった。

次の一単位は、2次元イジングモデル章の Fourier 変換した行列 `\hat Z,\hat Y` の定義一項だけである。
本文が使う `Z_j,Y_j` と有限和・複素位相の直接依存を同期し、半整数運動量の指数和の直後を
節境界として閉じられるか判定する。順61以降、周期デルタと整数運動量の分類移動、数学的道具立ての
分類・節境界には進まない。

## 全六研究監督: 半整数運動量の指数和へ進む（2026-09-20 15:02 JST）

実行識別子 `8b419085-2dcb-4d5f-9198-3aaef3b9d55a`。LLMによる検証では、周期デルタと整数運動量の
指数和へ正の格子幅・整数添字・非零除数の根拠を本文と形式化資料に同期したことを、可読性上の前進と
判定した。次は半整数運動量の指数和だけを同じ粒度で分離する。

## 2026-09-20: 周期デルタと整数運動量の指数和の仮定を同期

2次元イジングモデル章の周期デルタの定義と整数運動量の指数和だけを更新した。周期デルタに
`M\in\mathbb{N}_{\geq1}`、`\mu,\nu\in\mathbb{Z}`、値域を含む写像型
`\delta^M:\mathbb{Z}\times\mathbb{Z}\to\mathbb{C}` を明記した。指数和には
`M\in\mathbb{N}_{\geq1}`、`k\in\mathbb{Z}` を明記し、`M` による約分が `M\neq0` に基づくことを
補った。合同条件と指数和の数学的内容は変更していない。

Lean の既存具体版と必要十分版からの特殊化は、本文の正の自然数が `M:\mathbb{N}` と
`hM:M\neq0` に対応することをコメントで明示した。定理本体はすでにこの仮定で証明されているため
変更していない。SageMath も既存検査が `M=1,\ldots,12` と整数 `k` を走査するため変更せず、
491判定を再実行して成功した。

独立 Codex の初回 LLM による検証では、一般的な包含写像と像の略記を周期デルタへ混在させた
範囲逸脱、積保存の根拠不足、一ステップ一定理違反、未使用の Lean 直積ラッパー、状態記録の未同期を
検出した。包含写像とラッパーを削除し、変更を二項の所属・正値仮定と非零根拠だけへ縮めた。
修正後の独立 Codex による LLM 再レビューは未解消指摘なしだった。数学的道具立ての分類・節境界、
半整数運動量の指数和、Fourier 変換した行列には進んでいない。

棚卸しは全333項、数学的道具立て109項、2次元イジングモデル224項を維持した。プログラミングによる
検証は本文370ブロック、相互参照2308件、SageMath対応129件、Lean 3010ジョブ、PDF 381ページで
成功し、未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` は
0件だった。

次の一単位は、2次元イジングモデル章の半整数運動量の指数和一項だけを照合し、現行棚卸しが示す
具体的な行列計算への展開またはブロック分割の要否を判定する。順60以降、周期デルタと整数運動量の
分類移動、および数学的道具立ての分類・節境界には進まない。

## 全六研究監督: 周期デルタ二項の同期を次対象に維持（2026-09-20 09:07 JST）

実行識別子 `65e3693f-9257-40eb-aed3-30e0daef8cda`。LLMによる検証では、一般生成子二定義と二つの指数表示の分離は高校生可読な依存順へ前進した。次は周期デルタと整数指数和の所属・正の格子幅だけを本文・Lean・SageMathで同期する。段取り変更なし。

## 2026-09-20: 周期デルタから二種類の指数和へ進む三項境界候補を固定

論文構成再編の新規モードで、2次元イジングモデル章の未確定先頭にある
`\delta^M_{(\mu,\nu)}` の定義と整数運動量の指数和だけを照合した。前者は合同条件の指示量を定め、
後者はその定義を直接使って整数運動量の有限指数和を閉じる。直後の半整数運動量の指数和は、
この二項をともに直接入力として整数運動量の和へ帰着するため、三項は同じ節へ閉じる候補である。
ただし独立レビューにより、現二項の本文には `M`、`\mu`、`\nu` の所属と `M\geq1` が明示されず、
Lean と SageMath の正の `M` という仮定と同期していないことが分かった。

三項以上の本文・形式化同期に当たるため、今回は本文、Lean、SageMath、棚卸し生成規則を変更せず、
境界候補だけを状態台帳へ記録した。さらに、現二項はイジング固有語彙を持たないのに生成器の
候補指定だけで2次元イジングモデル章へ置かれている分類不整合と、次の Fourier 変換した行列の
定義が `Z_j,Y_j` を使うのに棚卸しの依存辺が空である不整合を未確定事項とした。数学的道具立ての
分類・節境界は変更していない。次の一単位は現二項だけを対象に、本文・Lean・SageMathの仮定を
同期することである。半整数運動量の指数和とその次の境界へは進まない。

プログラミングによる検証は、生成ラベルと棚卸し各333件、本文370ブロック、本文・ノートを含む
相互参照2308件、SageMath対応129件、Lean 3010ジョブ、PDF 381ページについて成功した。
未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` は
いずれも0件だった。

独立 Codex の初回 LLM による検証で、分類規則、本文と形式化の仮定、後続定義の依存辺について
三件の不整合を検出した。本文と分類生成器を変更せず、未確定事項と次の一歩へ反映した後の
再レビューは未解消指摘なしだった。

## 2026-09-20: 二つの一般生成子を一つの二項節へ確定

2次元イジングモデル章の章内依存順65・66にある `H_1^{(\pm)}` と `H_2` の二定義だけを
「二つの一般生成子」という節へ確定した。両定義は、同じ Jordan--Wigner 行列族 `Z_m,Y_m`、
行列積、複素数・集合記法を外部入力に持ち、相互に意味的依存しない。直前の Fourier 変換した行列の
反交換関係とは相互に依存せず、直後の `V_1^{(\pm)}` の指数表示では第一転送行列と転送行列記号が
入力へ加わり、行列族と行列積が直接入力から外れるため、入力集合が切り替わる順66の後で節を閉じた。

棚卸しは全333項、数学的道具立て109項、2次元イジングモデル224項のままである。
2次元イジングモデル章の構造確定済みは96項・38節、両章合計では205項・96節となった。
生成器は二項の連続性、相互非依存、本文 fingerprint、五つの全外部入力を固定する。
本文・Lean・SageMathの数式、順67以降の節境界、数学的道具立ての分類・節境界は変更していない。

独立Codexの初回LLMによる検証で、章別の構造確定数が節配列の旧件数を記録していたことと、
二定義が用いる行列積の定義への直接参照が欠けていたことを検出した。章別集計を各節の
`chapter` から算出した値へ直し、両定義から行列積の成分表示を直接参照して、本文 fingerprint、
外部入力、境界説明を同期した。最終再レビューは未解消指摘なしとなった。

プログラミングによる検証では、生成ラベルと棚卸し各333件、本文370ブロック、相互参照2308件、
SageMath対応129件、Lean 3010ジョブ、`sorry`・`admit`非使用検査が成功した。未解決参照、
失われた証明、ノート混入はいずれも0件で、型の負例検査・実行時検査・棚卸しfingerprint検査も成功した。

次の一単位は、未確定の先頭にある章内依存順57・58の `\delta^M_{(\mu,\nu)}` の定義と
整数運動量の指数和だけを照合し、直後の半整数運動量の指数和を含む三項以上の同期が必要なら、
本文を変更せず境界候補と次回の最大二項を記録する。順59以降の別境界には進まない。

## 2026-09-18: 二つの転送行列の指数表示を独立主張へ分離

2次元イジングモデル章の旧複合項に残っていた `V_1^{(\pm)}` と `V_2` の指数表示だけを、
それぞれ独立主張へ分離した。`V_1^{(\pm)}` の定義から `H_1^{(\pm)}` を代入する二段と、
`V_2` の Jordan--Wigner 表示から `H_2` を代入する二段を、各適用行のラベル付きで記した。
各主張には `M`、結合定数、双曲線関数値、虚数単位、生成子、転送行列の所属を明記した。

棚卸しは全333項、数学的道具立て109項、2次元イジングモデル224項となる。一般生成子の
二定義を章内依存順65・66、二つの指数表示を順67・68へ置いた。二表示は相互に依存せず
入力集合も異なるため、それぞれ一項節として固定した。後続の旧ラベル参照、Lean・SageMathの
対応コメント、Lean対応表、生成器の直接依存・本文fingerprint・章内順の固定条件も同期した。

独立 Codex の初回 LLM による検証で、適用行の生成子定義参照、記号の所属、状態記録、
二主張自身の固定条件、Lean対応表の不足を検出し、同じ二項内で修正した。

継続レビューでは、最小の `M` で省略記法から有限和へ移る根拠、Lean の独立定義側と
指数表示定理の対応、二つの新ラベルへ直結する SageMath 検査、第一指数表示の節境界説明と
全直接依存の一致が不足していることを検出した。本文に有限和記法と端点を明記し、Lean に
有限和を省略しない定義側と二つの指数表示定理を追加して平方根の対応を分離した。SageMath では
各主張の有限和置換を `QQ(i)` 上の厳密等号として検査し、両方とも成功した。節境界説明も
固定された全直接依存へ合わせた。

プログラミングによる検証は、生成ラベルと棚卸し各333件、本文370ブロック、本文とノートの
相互参照2306件、SageMath対応129件、Lean 3010ジョブ、PDF 381ページについて成功した。
二つの新規SageMath検査も厳密等号で成功し、未解決参照、失われた証明、ノート混入、
組めない文字、版面外へ出た行、`sorry` / `admit` は0件だった。

次の一単位は、章内依存順65・66の一般生成子二定義だけについて、二つの指数表示を分離した後の
入力集合を照合し、節境界を確定する。本文・Lean・SageMathの数式、順69以降の別境界、
数学的道具立てには進まない。

## 全六研究監督: 二つの指数表示という次対象を維持（2026-09-20 00:13 JST）

実行識別子 `9bd8381d-5644-4ffe-bd00-547947a24239`。LLMによる検証では、前回以後に remote default
へ統合された数学成果はなく、一般生成子の定義後に `V_1^{(±)}` と `V_2` の二表示だけを分離する
段取りを維持した。

## 全六研究監督: 一般生成子から指数表示へ依存順を進める（2026-09-18 09:00 JST）

実行識別子 `7d0b041e-373d-4814-8dcc-0cae6a050196`。LLMによる検証では、一般生成子
`H_1^{(±)}` と `H_2` がJordan--Wigner行列族の具体的有限和として独立し、指数表示との
責務が分離された。現行段取りは妥当で、次は残余の `V_1^{(±)}` と `V_2` の二表示だけを
独立主張へ分離する。

## 2026-09-18: 一般生成子の二定義を独立定義として分離

2次元イジングモデル章の一般生成子の複合定義から、`H_1^{(\pm)}` と `H_2` の二定義だけを
独立項へ分離した。両者を具体的な `2^M` 次複素行列として記述し、旧ラベルの残余には
`V_1^{(\pm)}` と `V_2` の二つの指数表示だけを保持した。棚卸しは全332項、数学的道具立て109項、
2次元イジングモデル223項となる。新定義を章内依存順65・66、残余を順67へ連続配置し、
数学的道具立ての分類・節境界と後続の既存節境界を維持した。Lean の既存二定義と SageMath の
具体的行列実装は数学内容を変えず、新しい本文項との対応コメントだけを同期した。

独立 Codex の初回 LLM による検証で、最小の `M` に対する省略展開の曖昧さと、`Y_m,Z_m` の
所有元への直接参照不足を検出した。二式を厳密な有限和へ直し、Jordan--Wigner 行列族へ直接接続した。
継続レビューでは、後続本文三箇所に残った旧 `V_1^{(\pm)}` 定義への参照と、実対称性の証明における
`H_2` の定義ラベル不足を検出し、各生成子の新定義へ同期した。指摘修正後の最終 LLM による検証は
未解消指摘なしだった。プログラミングによる検証は、生成ラベルと棚卸し各332件、本文369ブロック、
本文とノートの相互参照2304件、SageMath対応127件、Lean 3010ジョブ、PDF 380ページについて成功した。
未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` は0件だった。

次の一単位は、順67に残る `V_1^{(\pm)}` と `V_2` の指数表示の二つだけを独立主張へ分離する。
別の節境界には進まない。

## 全六研究監督: 一般生成子の二定義へ依存順を進める（2026-09-18 03:00 JST）

実行識別子 `34e9a830-e636-4e40-a398-ba140f7bf332`。LLMによる検証では、開始成果以後に第二の双対関係、
添字つき双曲線関数の略記と正値性が独立項として四層化された。正値性を双対関係から分離したことで、
後続の有限複素行列計算が必要とする除算・符号条件を、双曲線関数の実数順序だけから再利用できる。
段取りは妥当で、次は一般生成子の複合定義から二つの生成子定義だけを分離する。03:00:48の
プログラミングによる観測では登録情報にPID 54510が残っていたが、今回ログに成功マーカーと成果コミット
`42b1c960845f97a35933a223cd576cb503803ced` があり正常終了を確認した。

## 2026-09-17: 双曲線関数の添字つき略記の正値性を独立主張として分離

2次元イジングモデル章の残余複合定義から、各 `i\in\{1,2\}` に対する
`c_i,s_i,c_i^*,s_i^*>0` だけを独立主張として分離した。正の結合定数と双対結合定数、
双曲線関数の基本性質、直前の略記定義を入力に、二倍した引数の正値性、
`\cosh(2K_i)>\sinh(2K_i)>0` とその双対版、定義置換、四つの正値性を一段ずつ示した。
棚卸しは全330項、数学的道具立て109項、2次元イジングモデル221項となる。今回扱った既存棚卸しは
新主張と残余複合定義の二項だけであり、残余には旧ラベルの参照規約と各記号が具体的な有限複素行列
であることの確認だけが残る。数学的道具立ての分類・節境界と別のイジング章境界は変更していない。

独立 Codex の初回 LLM による検証で、生成ラベルと棚卸しの未同期、一ステップ一定理の行末根拠、
記号所属と実数への脱出、人手証明と Lean 具体版の途中段階の対応、SageMath による定義置換後の
連鎖不等式、および状態記録の不足を検出した。本文の各不等式へ根拠を置き、実数所属と実数順序を
明記し、Lean 具体版を本文と同じ段階へ展開し、SageMath 検査へ定義置換後の二連鎖を加え、
生成物・棚卸し・状態記録を同期した。継続レビューでは、SageMath の検査数が旧構成のまま
記録されていたことと、Lean 具体版が略記定義後の八成分ではなく元の双曲線関数へ直接結論して
いたことを検出した。検査記録を実行対象10件70判定へ直し、Lean 具体版を二つの添字について
定義代入、正弦側の正値性、推移律による余弦側の正値性を個別に示す形へ直した。

指摘修正後の最終 LLM による検証は未解消指摘なしで、数学的正しさ、一ステップ一定理、
記号所属と実数への脱出、本文と Lean 具体版、SageMath の行単位対応、依存方向、最大二項制約、
状態記録、および数学的道具立ての分類・節境界が不変であることを確認した。

プログラミングによる検証は、新規 SageMath 検査10件70判定を全件実行して0失敗となり、
生成ラベルと棚卸し各330件、本文367ブロック、相互参照2296件、SageMath対応127件、
Lean 3010ジョブ、PDF 380ページについて成功した。未解決参照、失われた証明、ノート混入、
組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

次の一単位は、一般生成子の複合定義から `H_1^{(\pm)}` と `H_2` の二定義だけをそれぞれ
独立項へ分離する。既存の `V_1^{(\pm)}` と `V_2` の指数表示、別の節境界、および
数学的道具立ての分類・節境界には進まない。

## 2026-09-17: 双曲線関数の添字つき略記を独立定義として分離

2次元イジングモデル章の残余複合定義から、各 `i\in\{1,2\}` に対する
`c_i:=\cosh 2K_i`、`s_i:=\sinh 2K_i`、`c_i^*:=\cosh 2K_i^*`、
`s_i^*:=\sinh 2K_i^*` だけを独立定義として分離した。正の結合定数と双対結合定数を入力に、
四つの略記が実数に属することまでを定義に含めた。棚卸しは全329項、数学的道具立て109項、
2次元イジングモデル220項となる。今回扱った既存棚卸しは新定義と残余複合定義の二項だけであり、
数学的道具立ての分類・節境界、残る正値性、別の節境界には進んでいない。

独立 Codex の初回 LLM による検証で、添字 `i` の量化と新記号の実数所属が不足していたこと、
棚卸しの境界説明にある先行項数が不正確だったこと、および SageMath の一つの同期コメントが
旧ラベルを指していたことを検出した。各 `i\in\{1,2\}` の量化と
`c_i,s_i,c_i^*,s_i^*\in\mathbb R` を明記し、件数に依存しない境界説明と新定義ラベルへ同期した。

プログラミングによる検証は、生成ラベルと棚卸し各329件、本文366ブロック、相互参照2294件、
SageMath対応126件、Lean 3010ジョブ、PDF 380ページについて成功した。未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

次の一単位は、残余複合定義に残る各 `i\in\{1,2\}` に対する
`c_i,s_i,c_i^*,s_i^*>0` だけを独立主張として分離する。別の節境界には進まない。

## 2026-09-16: 第二の双対関係を独立主張として分離

2次元イジングモデル章の残余複合定義から、
`\sinh(2K_2)\sinh(2K_2^*)=1` を独立主張として分離した。第二の双対結合定数、双曲線正接、
実対数、双曲線関数の定義と基本性質を入力に、指数関数へ戻す計算、倍角公式、基本恒等式を
一段ずつ示し、「実対数による実数への脱出」と明記した。棚卸しは全328項、数学的道具立て109項、
2次元イジングモデル219項となる。今回扱った既存棚卸しは新主張と残余複合定義の二項だけであり、
数学的道具立ての分類・節境界、双曲線関数の略記、残る正値性、別の節境界には進んでいない。

独立 Codex の初回 LLM による検証で、本文等号ごとの SageMath 検査がないこと、Lean 具体版が
必要十分版へ証明を委ねて人手証明と一対一になっていないこと、必要十分版の計算粒度と仮定の説明、
および具体版を必要十分版から得る特殊化が不足することを検出した。本文29等号に対応する
SageMath検査、本文の順で直接進むLean具体版、体と二の非零性だけを仮定する必要十分版、
内容名を持つ専用ファイルでの特殊化へ分離した。継続レビューでは、指数関数の一検査が別の
等号と重複していたこと、双曲線正弦の四等号と負指数側の二等号がLean具体版で圧縮されていたこと、
本状態台帳と研究メモのレビュー履歴が未同期であることを検出した。重複検査を
`\exp(2K_2^*)=1/\tanh K_2` の直接検査へ直し、圧縮していた各等号を本文と同順序の `calc` 行へ
展開し、レビュー履歴を同期した。

指摘修正後の最終 LLM による検証は未解消指摘なしで、数学的正しさ、一ステップ一定理、
人手証明とLean具体版の等号順、必要十分版と特殊化、SageMathの行単位対応、記号所属と
実数への脱出、依存方向、最大二項制約、および数学的道具立ての分類・節境界が不変であることを
確認した。

プログラミングによる検証は、新規SageMath検査29件を全件実行して0失敗となり、生成ラベルと
棚卸し各328件、本文365ブロック、相互参照2288件、SageMath対応126件、Lean 3010ジョブ、
PDF 380ページについて成功した。未解決参照、失われた証明、ノート混入、組めない文字、
版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

次の一単位は、残余複合定義から双曲線関数の添字つき略記
`c_i,s_i,c_i^*,s_i^*` だけを独立定義として分離する。残る正値性には進まない。

## 2026-09-16: 第二の双対結合定数を独立定義として分離

2次元イジングモデル章の残余複合定義から、
`K_2^*:=-\tfrac12\log(\tanh K_2)` の定義と正値性を独立させた。先行する双曲線正接の値域と
実対数の負値性を入力に、右辺の実数所属、正値性、定義による置換を一段ずつ示し、この証明が
実対数と実数の順序を用いることを「実対数による実数への脱出」と明記した。棚卸しは全327項、
数学的道具立て109項、2次元イジングモデル218項となる。今回扱った既存棚卸しは新定義と
残余複合定義の二項だけであり、数学的道具立ての分類・節境界、第二の双対関係、
双曲線関数の略記、別の節境界には進んでいない。

独立 Codex の初回 LLM による検証では、数学的内容、一ステップ一定理、依存方向、最大二項制約に
指摘はなく、状態台帳と本研究メモだけが未同期だった。現在地、未確定境界、次回単位、および
本研究メモを現行本文へ同期した。

同期後の独立 Codex の LLM による再検証で、第二の転送行列に現れる `K_2` と新定義が使う
`K_2` の依存が明示されていないことを検出した。新定義から第二の転送行列を直接参照し、
棚卸しの内部依存と直接依存を同期した。

指摘修正後の最終 LLM による検証は未解消指摘なしで、数学的正しさ、一ステップ一定理、
記号所属と実数への脱出、依存方向、本文・生成器・棚卸し・状態記録の一致、最大二項制約、
次回単位、および数学的道具立ての分類・節境界が不変であることを確認した。

プログラミングによる検証は、生成ラベルと棚卸し各327件、本文364ブロック、相互参照2282件、
SageMath対応125件、Lean 3007ジョブ、PDF 378ページについて成功した。未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

次の一単位は、残余複合定義から第二の双対関係
`\sinh(2K_2)\sinh(2K_2^*)=1` だけを独立主張として分離する。双曲線関数の略記と残る正値性には
進まない。

## 2026-09-16: 第一の双対関係を独立主張として分離

2次元イジングモデル章の残余複合定義から、
`\sinh(2K_1)\sinh(2K_1^*)=1` を独立主張として分離した。第一の双対結合定数、双曲線正接、
実対数、双曲線関数の定義と基本性質を入力に、指数関数へ戻す計算、倍角公式、基本恒等式を
一段ずつ示し、「実対数による実数への脱出」と明記した。棚卸しは全326項、数学的道具立て109項、
2次元イジングモデル217項となる。今回扱った既存棚卸しは新主張と残余複合定義の二項だけであり、
数学的道具立ての分類・節境界、第二の双対結合定数、第二の双対関係、双曲線関数の略記、
別の節境界には進んでいない。

独立 Codex の初回 LLM による検証で、未証明の指数関数の逆数公式、複数等式の同時代入、
双曲線関数の定義への直接依存漏れ、残余境界の旧説明を検出した。指数法則から逆数公式を導き、
指数等式・倍角等式・係数整理・双曲線正接の展開を別々の等号へ分け、依存と残余説明を同期した。
指摘修正後の最終 LLM による検証は未解消指摘なしで、数学的正しさ、一ステップ一定理、依存方向、
本文・生成器・棚卸し・状態記録の一致、最大二項制約、次回単位、および数学的道具立ての
分類・節境界が不変であることを確認した。

プログラミングによる検証は、生成ラベルと棚卸し各326件、本文363ブロック、相互参照2278件、
SageMath対応125件、Lean 3007ジョブ、PDF 377ページについて成功した。未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

次の一単位は、残余複合定義から第二の双対結合定数
`K_2^*:=-\tfrac12\log(\tanh K_2)` の定義と正値性だけを分離する。第二の双対関係と
双曲線関数の略記には進まない。

## 全六研究監督: 第一の双対関係を次対象として維持（2026-09-16 08:55 JST）

実行識別子 `8dc58408-74c1-4443-b24a-23d5f3782a7e`。LLMによる検証では、正の実数上の実対数と
第一の双対結合定数が依存順に独立し、`0<\tanh K_1<1` と実対数の負値性から結合定数の正値性が
読めるようになった。READMEの高校生が具体的な複素行列計算を順に読める目的に整合し、次は第一の
双対関係だけを独立させる現行段取りを維持する。

## 2026-09-16: 第一の双対結合定数を独立定義として分離

2次元イジングモデル章の残余複合定義から、
`K_1^*:=-\tfrac12\log(\tanh K_1)` の定義と正値性を独立させた。先行する双曲線正接の値域と
実対数の負値性を入力に、右辺の実数所属、正値性、定義による置換を一段ずつ示し、この証明が
実対数と実数の順序を用いることを「実対数による実数への脱出」と明記した。棚卸しは全325項、
数学的道具立て109項、2次元イジングモデル216項となる。今回扱った既存棚卸しは新定義と
残余複合定義の二項だけであり、数学的道具立ての分類・節境界、第二の双対結合定数、
双曲線関数の略記、別の節境界には進んでいない。次の一単位は第一の双対関係
`\sinh(2K_1)\sinh(2K_1^*)=1` だけを独立主張として分離する。

独立 Codex の初回 LLM による検証で、定数 `-\tfrac12` の実数所属に未定義の有理数集合記号を
用いていたことと、状態台帳に残る V2 節の章内依存順が現行棚卸しと一致しないことを検出した。
前者は実数体の逆元と符号反転の閉性を根拠とする記述へ直し、後者は現行の順23–25と次項26へ
同期した。指摘修正後の最終 LLM による検証は未解消指摘なしで、一ステップ一定理、記号の所属、
本文・生成器・棚卸し・状態記録の一致、最大二項制約、次回単位、および数学的道具立ての
分類・節境界が不変であることを確認した。

プログラミングによる検証は、生成ラベルと棚卸し各325件、本文362ブロック、相互参照2272件、
SageMath対応125件、Lean 3007ジョブ、PDF 376ページについて成功した。未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-16: 正の実数上の実対数を先行定義として分離

2次元イジングモデル章に、標準的な狭義単調全単射である実指数関数の逆写像として
`\log:\mathbb{R}_{>0}\to\mathbb{R}` を定める独立定義を追加した。逆写像の狭義単調性から、
`0<y<1` なら `\log y<0` となることを一ステップずつ示し、この箇所を「実対数による実数への
脱出」と明記した。残余複合定義は新定義を明示参照する。棚卸しは全324項、数学的道具立て109項、
2次元イジングモデル215項となる。今回扱った既存棚卸しは新定義と残余複合定義の二項だけであり、
数学的道具立ての分類・節境界、第一の双対結合定数、双対関係、第二の双対結合定数、
双曲線関数の略記には進んでいない。次の一単位は `K_1^*` の定義と正値性だけを分離する。

独立 Codex の初回 LLM による検証で、指数関数の零での値と狭義単調性が別の主張番号へ
誤って参照されていること、等式の二段階の代入が一行に束ねられていること、実数解析への移行を
指定表現で明記する必要、および状態記録の未同期を検出した。誤った項目番号を除去し、根拠を
指数関数の基本性質、実対数の逆写像性・狭義単調性へ修正した。さらに `\log 1=\log(\exp 0)`、
`\log(\exp 0)=0`、`\log 1=0` を別の行へ分け、実数への脱出表記と状態記録を同期した。
指摘修正後の最終 LLM による検証は未解消指摘なしで、一ステップ一定理、本文・棚卸し・状態記録の
一致、最大二項制約、次回単位、および数学的道具立ての分類・節境界が不変であることを確認した。

プログラミングによる検証は、生成ラベルと棚卸し各324件、本文361ブロック、相互参照2268件、
SageMath対応125件、Lean 3007ジョブ、PDF 375ページについて成功した。未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 全六研究監督: 双曲線正接の値域から実対数の負値性へ進む（2026-09-16 03:01 JST）

実行識別子 `6b9a5fbc-a636-4b5b-9cd3-2098874b867d`。LLMによる検証では、正の結合定数上の
双曲線正接が独立定義となり、`0<tanh K<1` を先行する双曲線余弦・正弦から導いたことは、第一の
双対結合定数を高校生が依存順に読める形へ分ける前進である。実対数の定義域には入ったが、その負値性は
まだ独立していないため、次は正の実数上の実対数と `0<y<1` での負値性、その後に第一の双対結合定数を
分離する。

## 2026-09-16: 正の結合定数上の双曲線正接を先行定義として分離

2次元イジングモデル章に、この模型で用いる `K\in\mathbb{R}_{>0}` に対する
`\tanh K:=\sinh K/\cosh K` を独立定義として追加した。先行する双曲線余弦・双曲線正弦の
定義と大小関係だけを使い、商が実数として定義できることと `0<\tanh K<1` を行ごとに示した。
残余複合定義は新定義を明示参照する。棚卸しは全323項、数学的道具立て109項、
2次元イジングモデル214項となる。数学的道具立ての分類・節境界、双対関係、第二の
双対結合定数、双曲線関数の略記には進んでいない。次の一単位は2次元イジングモデル章に
正の実数上の実対数と `0<y<1` での負値性を独立定義として置き、第一の双対結合定数の分離は
その後とする。

独立 Codex の初回 LLM による検証で、棚卸し生成器の一般体検出による `tanh K:=` の誤検出、
定義可能性の根拠を行ごとに分ける必要、および本記録の未同期を検出した。検出条件を実数体・複素数体の
明示定義に限定し、正の実数から実数への所属、双曲線関数の値の所属、分母の非零、実数の除法閉性を
別の行へ分けた。指摘修正後の最終 LLM による検証は未解消指摘なしだった。

プログラミングによる検証は、生成ラベルと棚卸し各323件、本文360ブロック、相互参照2266件、
SageMath対応125件、Lean 3007ジョブ、PDF 374ページについて成功した。未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 全六研究監督: 第一の双対結合定数の先行項を実行順へ変更（2026-09-15 20:59 JST）

実行識別子 `a32da8e9-de9d-4b5b-91ae-b654d01aa00f`。LLMによる検証では、開始成果
`c4ff950329a8dfd9869e54819684f3d12b9d2bf9` までの当研究差分は先行定義不足の再確認だけで、数学上の
前進はない。同じ欠落確認を反復する段取りは実行可能でないため、既に状態台帳へ固定された二項を、
双曲線正接の独立定義と正入力での値域、実対数の独立定義と零・一間での負値性の順に整備し、その後だけ
第一の双対結合定数を分離する段取りへ変更した。待機記録は研究上の前進には数えない。
## 2026-09-15 20時台: 第一の双対結合定数の先行定義待機を再確認

`origin/main` の `545aa39e7e4638acb7545cc5f56b3670de8a4c5e` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。18時台の待機記録以後の
remote 更新は、その待機記録、セルオートマトン研究、および lambda 版の変更だけで、複素行列版の
数学本文、棚卸し生成規則、生成済み棚卸しには変更がない。数学的道具立てには双曲線余弦・
双曲線正弦の独立定義があり、本文後半には逆双曲線正弦を含む実解析記述もあるが、正の実数上の
実対数の負値性と双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は先行定義の
代わりにはならないため、第一の双対結合定数の本文分離を開始しなかった。

次の一歩は同じ条件付き一項のままとする。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。

反映前に再取得した `origin/main` の `c4ff950329a8dfd9869e54819684f3d12b9d2bf9` は
lambda 版だけの更新であり、fast-forward で取り込んだ後も上記の結論は変わらなかった。

独立 Codex の LLM による検証は未解消指摘なしで、先行定義の不足、後続証明を逆用しない
依存方向、高校生可読性、一境界だけを扱う範囲、および状態記録と実行ログの一致を確認した。

プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-15 18時台: 第一の双対結合定数の先行定義待機を再確認

`origin/main` の `352f0ce6ddcda38f360eb0491caa0bf5d0dbd3a8` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。16時台の待機記録以後の
remote 更新は、セルオートマトン研究、lambda 版、および有限グラフ版の
変更だけで、複素行列版の数学本文、棚卸し生成規則、生成済み棚卸しには変更がない。数学的
道具立てには双曲線余弦・双曲線正弦の独立定義があり、本文後半には逆双曲線正弦を含む実解析記述も
あるが、正の実数上の実対数の負値性と双曲線正接の値域を含む独立した先行定義はない。後続証明内の
計算は先行定義の代わりにはならないため、第一の双対結合定数の本文分離を開始しなかった。

次の一歩は同じ条件付き一項のままとする。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。

独立 Codex の LLM による検証は未解消指摘なしで、先行定義の不足、後続証明を逆用しない
依存方向、高校生可読性、一境界だけを扱う範囲、および状態記録と実行ログの一致を確認した。

プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-15 16時台: 第一の双対結合定数の先行定義待機を再確認

`origin/main` の `13386faa49a4ad161b8ebeea3fbbd9d438939181` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。14時台の待機記録以後の
remote 更新は、全六研究の監督記録、セルオートマトン研究、lambda 版、および有限グラフ版の
変更だけで、複素行列版の数学本文、棚卸し生成規則、生成済み棚卸しには変更がない。数学的
道具立てには双曲線余弦・双曲線正弦の独立定義があり、本文後半には逆双曲線正弦を含む実解析記述も
あるが、正の実数上の実対数の負値性と双曲線正接の値域を含む独立した先行定義はない。後続証明内の
計算は先行定義の代わりにはならないため、第一の双対結合定数の本文分離を開始しなかった。

次の一歩は同じ条件付き一項のままとする。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。

独立 Codex の LLM による検証は未解消指摘なしで、先行定義の不足、後続証明を逆用しない
依存方向、高校生可読性、一境界だけを扱う範囲、および状態記録と実行ログの一致を確認した。

プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 全六研究監督: 第一の双対結合定数の先行定義待機を維持（2026-09-15 15:02 JST）

実行識別子 `26f33afc-f560-4787-851c-501e03d64e96`。LLMによる検証では、直前監督以後の差分は
正の実数上の実対数の負値性と双曲線正接の値域が未整備であることの再確認だけで、数学上の前進はない。
後続証明を逆用せず、両先行定義が整った後だけ第一の双対結合定数を分離する段取りを維持した。

## 2026-09-15 14時台: 第一の双対結合定数の先行定義待機を再確認

`origin/main` の `d0c44f2b7ff5ba85d50d8428b44d6f1640a8bada` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。12時台の待機記録以後の
remote 更新は lambda 版だけで、複素行列版の数学本文、棚卸し生成規則、生成済み棚卸しには
変更がない。数学的道具立てには双曲線余弦・双曲線正弦の独立定義があり、本文後半には
逆双曲線正弦を含む実解析記述もあるが、正の実数上の実対数の負値性と双曲線正接の値域を含む
独立した先行定義はない。後続証明内の計算は先行定義の代わりにはならないため、第一の
双対結合定数の本文分離を開始しなかった。

次の一歩は同じ条件付き一項のままとする。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。

確認中に進んだ `origin/main` の `ed13bc72eb38fedb5262dd4be21d62996b9f90ea` は lambda 版だけの
変更であり、fast-forward で取り込んだ後も上記の結論は変わらなかった。独立 Codex の LLM による
検証は未解消指摘なしで、先行定義の不足、後続証明を逆用しない依存方向、高校生可読性、
一ステップ一定理、一境界だけを扱う範囲が整合すると判定した。プログラミングによる検証は、
生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、SageMath対応125件、Lean 3007ジョブ、
PDF 373ページについて成功し、未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、
`sorry` / `admit` はいずれも0件だった。

## 2026-09-15 12時台: 第一の双対結合定数の先行定義待機を再確認

`origin/main` の `bd078407703e3856eee9f3a3381fef2aba4243bc` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。10時台の待機記録以後の
remote 更新は、その待機記録と他研究の変更だけで、複素行列版の数学本文、棚卸し生成規則、
生成済み棚卸しには変更がない。数学的道具立てには双曲線余弦・双曲線正弦の独立定義があり、
本文後半には逆双曲線正弦を含む実解析記述もあるが、正の実数上の実対数の負値性と双曲線正接の
値域を含む独立した先行定義はない。後続証明内の計算は先行定義の代わりにはならないため、
第一の双対結合定数の本文分離を開始しなかった。

次の一歩は同じ条件付き一項のままとする。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。
独立した Codex の LLM による検証では、指定文書を全文読了して今回の境界に関係する全出現、
棚卸し上の依存方向、remote 更新、二文書の差分を照合し、未解消指摘はなかった。
コミット前に再取得した `origin/main` の `1091bb5cd84f4a1f7313b3685cb91bcec406bd13` は
lambda版だけの更新であり、複素行列版へ変更がないことを確認して取り込んだ。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-15 10時台: 第一の双対結合定数の先行定義待機を再確認

`origin/main` の `4f2fdc6a0aefef5e7c9ea3346d787d6b97d89075` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。8時台の待機記録以後の
remote 更新は、その待機記録、全六研究の監督記録、セルオートマトン研究、および lambda 版の
変更だけで、複素行列版の数学本文、棚卸し生成規則、生成済み棚卸しには変更がない。数学的道具立てには
双曲線余弦・双曲線正弦の独立定義があり、本文後半には逆双曲線正弦を含む実解析記述もあるが、
正の実数上の実対数の負値性と双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は
先行定義の代わりにはならないため、第一の双対結合定数の本文分離を開始しなかった。

次の一歩は同じ条件付き一項のままとする。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。

反映前に `origin/main` の `0536fc45f28f63ca457eeac21ad061746eaefb38` も取り込んだ。
追加はセルオートマトン研究の Lean 必要十分版だけで、上記判定は変わらない。

独立した Codex の LLM による検証では未解消指摘がなく、先行定義の欠落、後続証明を先行定義へ
逆用しない依存方向、二章の分類境界、高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 全六研究監督: 第一双対結合定数の先行定義待ちを維持（2026-09-15 08:59 JST）

実行識別子 `f5cb34ff-b5ce-439f-af5e-afd4e43a91bd`。LLMによる検証では、前回以後も実対数の
負値性と双曲線正接の値域を含む独立先行定義は増えておらず、state・MEMORYの再確認は数学上の
前進ではない。両先行定義後だけ第一双対結合定数を分離する段取りを維持した。

## 2026-09-15 8時台: 第一の双対結合定数の先行定義待機を再確認

`origin/main` の `7ee31d5ae69467742553938cb69b4a7fab7d3b72` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。6時台の待機記録以後の
remote 更新は、その待機記録、セルオートマトン研究、lambda 版、および有限グラフ版の変更だけで、
複素行列版の数学本文、棚卸し生成規則、生成済み棚卸しには変更がない。数学的道具立てには
双曲線余弦・双曲線正弦の独立定義があり、本文後半には逆双曲線正弦を含む実解析記述もあるが、
正の実数上の実対数の負値性と双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は
先行定義の代わりにはならないため、第一の双対結合定数の本文分離を開始しなかった。

次の一歩は同じ条件付き一項のままとする。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。

独立した Codex の LLM による検証では未解消指摘がなく、先行定義の欠落、後続証明を先行定義へ
逆用しない依存方向、二章の分類境界、高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-15 6時台: 第一の双対結合定数の先行定義待機を再確認

`origin/main` の `3d719dc582895308ff704b6fdd0e56ac6df99cab` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。2時台の待機記録以後の
remote 更新は、その待機記録、セルオートマトン研究、lambda 版、および有限グラフ版の変更だけで、
複素行列版の数学本文、棚卸し生成規則、生成済み棚卸しには変更がない。数学的道具立てには
双曲線余弦・双曲線正弦の独立定義がある一方、正の実数上の実対数の負値性と双曲線正接の値域を含む
独立した先行定義はない。後続証明内の計算は先行定義の代わりにはならないため、第一の
双対結合定数の本文分離を開始しなかった。

次の一歩は同じ条件付き一項のままとする。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。

独立した Codex の LLM による検証では未解消指摘がなく、先行定義の欠落、後続証明を先行定義へ
逆用しない依存方向、二章の分類境界、高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 全六研究監督: 第一双対結合定数の先行定義待ちを維持（2026-09-15 04:40 JST）

実行識別子 `e73ddff5-bbd6-471e-ac42-54c751cae720`。LLMによる検証では、前回以後も実対数の負値性と双曲線正接の値域を含む
独立先行定義は増えておらず、数学上の前進はない。両先行定義後だけ第一双対結合定数を分離する
段取りを維持した。

## 2026-09-15 2時台: 第一の双対結合定数の先行定義待機を再確認

`origin/main` の `637ddc6895dd6fca6e47cf4149e2c503d0afe124` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。0時台の待機記録以後の
remote 更新は、その待機記録、セルオートマトン研究、および lambda 版の変更だけで、複素行列版の
数学本文と棚卸しには変更がない。数学的道具立てには双曲線余弦・双曲線正弦の独立定義がある一方、
正の実数上の実対数の負値性と双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は
先行定義の代わりにはならないため、第一の双対結合定数の本文分離を開始しなかった。

次の一歩は同じ条件付き一項のままとする。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。

独立した Codex の LLM による検証では、今回の境界に関係する全出現、棚卸し上の依存方向、
remote 更新、および二文書の差分を照合し、未解消指摘はなかった。プログラミングによる検証は、
生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、SageMath対応125件、Lean 3007ジョブ、
PDF 373ページについて成功した。未解決参照、失われた証明、ノート混入、組めない文字、
版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

反映前に `origin/main` の `5d14b698db6c50bd2fab92fd4791f4b86ce53262` も取り込んだ。
追加は全六研究の監督記録とセルオートマトン研究の実行手順更新だけで、上記の数学本文・
棚卸し・依存境界の判定は変わらない。

## 2026-09-15 0時台: 第一の双対結合定数の先行定義待機を再確認

`origin/main` の `689cd1aa8fae424f64707d7ef450ae38e762917b` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。22時台の照合以後の
remote 更新は、同じ照合結果の記録と別研究の変更だけで、複素行列版の数学本文と棚卸しには
変更がない。数学的道具立てには双曲線余弦・双曲線正弦の独立定義がある一方、正の実数上の実対数の
負値性と双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は先行定義の代わりに
はならないため、第一の双対結合定数の本文分離を開始しなかった。

次の一歩は同じ条件付き一項のままとする。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。

独立した Codex の LLM による検証では、今回の境界に関係する全出現、棚卸し上の依存方向、
remote 更新、および二文書の差分を照合し、未解消指摘はなかった。プログラミングによる検証は、
生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、SageMath対応125件、Lean 3007ジョブ、
PDF 373ページについて成功した。未解決参照、失われた証明、ノート混入、組めない文字、
版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-14 22時台: 第一の双対結合定数の先行定義待機を再確認

`origin/main` の `848445e5a87e835e440317c0334dc9e6ce2e57f1` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。20時台の照合以後の remote 更新は、
同じ照合結果と全六研究監督の記録、および別研究の変更だけで、複素行列版の数学本文と棚卸しには変更がない。
数学的道具立てには双曲線余弦・双曲線正弦の独立定義がある一方、正の実数上の実対数の負値性と
双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は先行定義の代わりにはならないため、
第一の双対結合定数の本文分離を開始しなかった。

次の一歩は同じ条件付き一項のままとする。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。

独立した Codex の初回 LLM による検証では、逆双曲線正弦の定義が既にあるため「双曲線余弦・
双曲線正弦の定義だけ」という表現は不正確だと指摘された。今回分を上記の表現へ修正し、再レビューでは
未解消指摘なしとなった。プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、
相互参照2263件、SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功した。
未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` は0件だった。

## 全六研究監督: 第一双対結合定数の先行定義待ちを維持（2026-09-14 21:01 JST）

実行識別子 `91e3e4bb-b5cd-45c0-a338-37ebc13d5f4e`。LLMによる検証では、前回以後の当研究差分は
実対数と双曲線正接の先行定義不足を再記録したものだけで、数学上の前進ではない。両先行定義後だけ
第一双対結合定数を分離する段取りを維持した。

## 2026-09-14 20時台: 第一の双対結合定数の先行定義待機を再確認

`origin/main` の `d0a43744631f42fb0a954d11cb686c8ef4d93b0e` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。18時台の照合以後の remote
更新は18時台の照合結果の記録と別研究の Cauchy 列形式化だけで、複素行列版の数学本文と棚卸しには
変更がなかった。
正の実数上の実対数について `0<y<1` なら `\log y<0` となる符号性と、双曲線正接について
`x>0` なら `0<\tanh x<1` となる値域を含む独立した先行定義は、いずれもまだ存在しない。
後続証明内の計算は先行定義の代わりにはならないため、第一の双対結合定数の本文分離を開始しなかった。

次の一歩は同じ条件付き一項のままとする。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。
独立した Codex の初回 LLM による検証では、18時台以後の remote 更新内訳から18時台の照合結果の
記録が漏れていたことを検出し、コミット履歴に合わせて修正した。先行定義の欠落、後続証明を
先行定義へ逆用しない依存方向、二章の分類境界、高校生可読性、および一境界だけを扱う範囲には
ほかの指摘がなく、修正後の最終再レビューは未解消指摘なしとなった。

プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-14: 第一の双対結合定数の先行定義待機を18時台のremote最新で再確認

`origin/main` の `8f186362044459b7a0ff316d2dbd79c0be8c89c6` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。14時台の照合以後の remote 更新は、
その照合結果と全六研究監督の記録、および別研究の変更だけで、複素行列版の数学本文と棚卸しには
変更がない。数学的道具立てには双曲線余弦・双曲線正弦の定義だけがあり、正の実数上の実対数の
負値性と双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は先行定義の代わりには
ならないため、第一の双対結合定数の本文分離を開始しなかった。次回も両先行定義の整備を確認した後に、
この一定義だけを分離する。残余複合定義、棚卸し生成規則、双対関係、第二の双対結合定数、
双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。
独立した Codex の LLM による検証では未解消指摘がなく、本文全26ファイル・359ブロックと
棚卸し全322件、14時台以後の履歴を照合して、先行定義の欠落、後続証明を先行定義へ逆用しない
依存方向、二章の分類境界、高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 全六研究監督: 第一双対結合定数の先行定義待ちを維持（2026-09-14 15:02 JST）

実行識別子 `35cb2607-6d12-4f2b-a439-7b6aece2a410`。LLMによる検証では、前回以後の統合差分は
実対数と双曲線正接の先行定義不足をstate・MEMORYへ再確認したものだけで、数学本文・Lean・SageMathの
新成果ではない。後続証明を先行定義へ逆用せず、両定義の符号性・値域が整った後だけ第一双対結合定数を
分離する段取りを維持した。

## 2026-09-14: 第一の双対結合定数の先行定義待機を14時台のremote最新で再確認

`origin/main` の `a5eef69324930fd2f67b0852155bef75fd7d1f9a` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。12時台の待機記録以後、
複素行列版の数学本文と棚卸しには変更がない。数学的道具立てには双曲線余弦・双曲線正弦の定義だけがあり、
正の実数上の実対数の負値性と双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は
先行定義の代わりにはならないため、第一の双対結合定数の本文分離を開始しなかった。次回も両先行定義の
整備を確認した後に、この一定義だけを分離する。残余複合定義、棚卸し生成規則、双対関係、
第二の双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。
独立した Codex の LLM による検証では未解消指摘がなく、本文全26ファイル・359ブロックと棚卸し全322件を
照合して、先行定義の欠落、後続証明を先行定義へ逆用しない依存方向、二章の分類境界、高校生可読性、
および一境界だけを扱う範囲が整合すると判定した。プログラミングによる検証は、生成ラベルと棚卸し各322件、
本文359ブロック、相互参照2263件、SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、
未解決参照、失われた証明、ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-14: 第一の双対結合定数の先行定義待機を12時台のremote最新で再確認

`origin/main` の `0b66f0460d1ae1a1ab7bc22d45b520b88cf5d3f2` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。8時台の待機記録以後も、
複素行列版の数学本文と棚卸しには変更がない。数学的道具立てには双曲線余弦・双曲線正弦の定義だけがあり、
正の実数上の実対数の負値性と双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は
先行定義の代わりにはならないため、第一の双対結合定数の本文分離を開始しなかった。次回も両先行定義の
整備を確認した後に、この一定義だけを分離する。残余複合定義、棚卸し生成規則、双対関係、
第二の双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。
独立した Codex の LLM による検証では未解消指摘がなく、本文全26ファイル・359ブロック、棚卸し、
8時台以後の履歴を照合して、先行定義の欠落、後続証明を先行定義へ逆用しない依存方向、
二章の分類境界、高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 全六研究監督: 第一双対結合定数の先行定義待ちを維持（2026-09-14 09:02 JST）

実行識別子 `7907f348-ccf0-47ad-81fa-a80222f688d9`。LLMによる検証では、08時台までの統合差分は実対数と双曲線正接の先行定義不足を再確認したstate・MEMORYだけで、数学本文・Lean・SageMathの新成果ではない。両定義の符号性・値域が整った後だけ第一双対結合定数を分離する段取りを維持した。

## 2026-09-14: 第一の双対結合定数の先行定義待機を8時台のremote最新で再確認

`origin/main` の `a0619d1a64dce35ca4d7340c649936c0a4f11f04` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。6時台の待機記録以後の
remote 更新は他プロジェクトの記録だけで、複素行列版の数学本文と棚卸しには変更がない。
数学的道具立てには双曲線余弦・双曲線正弦の定義だけがあり、正の実数上の実対数の負値性と
双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は先行定義の代わりにはならないため、
第一の双対結合定数の本文分離を開始しなかった。次回も両先行定義の整備を確認した後に、
この一定義だけを分離する。残余複合定義、棚卸し生成規則、双対関係、第二の双対結合定数、
双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。
独立した Codex の LLM による検証では指摘がなく、本文全26ファイル・359ブロック、棚卸し、
直近履歴を照合して、先行定義の欠落、後続証明を先行定義へ逆用しない依存方向、二章の分類境界、
高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-14: 第一の双対結合定数の先行定義待機を6時台のremote最新で再確認

`origin/main` の `9e9945250a90667ff138f599cbe2409d79dcfbc6` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。4時台の待機記録以後の
remote 更新は同じ待機記録だけで、複素行列版の数学本文と棚卸しには変更がない。
数学的道具立てには双曲線余弦・双曲線正弦の定義だけがあり、正の実数上の実対数の負値性と
双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は先行定義の代わりにはならないため、
第一の双対結合定数の本文分離を開始しなかった。次回も両先行定義の整備を確認した後に、
この一定義だけを分離する。残余複合定義、棚卸し生成規則、双対関係、第二の双対結合定数、
双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。
独立した Codex の LLM による検証では指摘がなく、本文全26ファイル・359ブロック、棚卸し、
直近履歴を照合して、先行定義の欠落、循環しない依存方向、二章の分類境界、
高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-14: 第一の双対結合定数の先行定義待機を4時台のremote最新で再確認

`origin/main` の `564155a6e709f57273a34f1e4cc9a852d5755be1` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。2時台の待機記録以後の
remote 更新は同じ待機記録と全六研究の監督記録だけで、複素行列版の数学本文と棚卸しには変更がない。
数学的道具立てには双曲線余弦・双曲線正弦の定義だけがあり、正の実数上の実対数の負値性と
双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は先行定義の代わりにはならないため、
第一の双対結合定数の本文分離を開始しなかった。次回も両先行定義の整備を確認した後に、
この一定義だけを分離する。残余複合定義、棚卸し生成規則、双対関係、第二の双対結合定数、
双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。
独立した Codex の LLM による検証では指摘がなく、本文全26ファイル・359ブロック、棚卸し、
直近履歴を照合して、先行定義の欠落、循環しない依存方向、二章の分類境界、
高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-14: 第一の双対結合定数の先行定義待機を2時台のremote最新で再確認

`origin/main` の `027279c0e767b15694300482b90b81cd51277e55` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。直前の待機記録以後の
remote 更新は有限グラフ版の状態台帳と研究記録だけで、複素行列版の数学本文と棚卸しには変更がない。
数学的道具立てには双曲線余弦・双曲線正弦の定義だけがあり、正の実数上の実対数の負値性と
双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は先行定義の代わりにはならないため、
第一の双対結合定数の本文分離を開始しなかった。次回も両先行定義の整備を確認した後に、
この一定義だけを分離する。残余複合定義、棚卸し生成規則、双対関係、第二の双対結合定数、
双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。
独立した Codex の LLM による検証では指摘がなく、本文全26ファイル・359ブロック、棚卸し、
直近履歴を照合して、先行定義の欠落、循環しない依存方向、二章の分類境界、
高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 全六研究監督: 第一の双対結合定数の先行定義待ちを維持（2026-09-14 02:58 JST）

実行識別子 `0a88b0e4-b340-4857-a657-5389f7dd095c`。LLMによる検証では、直前監督以後の四回の
統合差分は実対数・双曲線正接の独立先行定義不足をstate・MEMORYへ再確認しただけで、数学本文・
Lean・SageMathの新成果はない。両定義の符号性・値域が整った後だけ第一の双対結合定数を分離する。

## 2026-09-14: 第一の双対結合定数の先行定義待機をremote最新で再確認

`origin/main` の `7a46cba4348a6d6a7a6aa6bc1618b7047cb15088` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。数学的道具立てには
双曲線余弦・双曲線正弦の定義だけがあり、正の実数上の実対数の負値性と双曲線正接の値域を含む
独立した先行定義はない。後続証明内の計算は先行定義の代わりにはならないため、第一の双対結合定数の
本文分離を開始しなかった。次回も両先行定義の整備を確認した後に、この一定義だけを分離する。
残余複合定義、棚卸し生成規則、双対関係、第二の双対結合定数、双曲線関数の略記、別の節境界、
および数学的道具立ての分類・節境界は変更していない。
独立した Codex の LLM による検証では指摘がなく、本文全26ファイル・359ブロック、棚卸し、
直近履歴を照合して、先行定義の欠落、循環しない依存方向、二章の分類境界、
高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-13: 第一の双対結合定数の先行定義待機を22時台のremote最新で再確認

`origin/main` の `3063dbe1a9e205e789ae898d7286895c7b9f4b86` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。16時台の待機記録以後の
複素行列版の変更は待機記録だけで、数学本文と棚卸しには変更がない。数学的道具立てには
双曲線余弦・双曲線正弦の定義だけがあり、正の実数上の実対数の負値性と双曲線正接の値域を含む
独立した先行定義はない。後続証明内の計算は先行定義の代わりにはならないため、第一の双対結合定数の
本文分離を開始しなかった。次回も両先行定義の整備を確認した後に、この一定義だけを分離する。
残余複合定義、棚卸し生成規則、双対関係、第二の双対結合定数、双曲線関数の略記、別の節境界、
および数学的道具立ての分類・節境界は変更していない。
独立した Codex の LLM による検証では指摘がなく、本文全26ファイル・359ブロック、棚卸し、
16時台以後の履歴を照合して、先行定義の欠落、循環しない依存方向、二章の分類境界、
高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、組めない文字、版面外へ出た行、`sorry` / `admit` はいずれも0件だった。

## 2026-09-13: 第一の双対結合定数の先行定義待機を16時台のremote最新で再確認

`origin/main` の `debe966a8fab53a3fe238eec1f4a2ba15bf35954` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。14時台の待機記録以後の
remote更新は全六研究の監督記録だけで、複素行列版の数学本文と棚卸しには変更がない。
数学的道具立てには双曲線余弦・双曲線正弦の定義だけがあり、正の実数上の実対数の負値性と
双曲線正接の値域を含む独立した先行定義はない。後続証明内の計算は先行定義の代わりにはならないため、
第一の双対結合定数の本文分離を開始しなかった。次回も両先行定義の整備を確認した後に、この一定義だけを分離する。
残余複合定義、棚卸し生成規則、双対関係、第二の双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての
分類・節境界は変更していない。
独立した Codex の LLM による検証では指摘がなく、先行定義の欠落、循環しない依存方向、二章の分類境界、
高校生可読性、および一境界だけを扱う範囲が整合すると判定した。プログラミングによる検証は、生成ラベルと
棚卸し各322件、本文359ブロック、相互参照2263件、SageMath対応125件、Lean 3007ジョブ、
PDF 373ページについて成功し、未解決参照、失われた証明、ノート混入、`sorry` / `admit` はいずれも0件だった。

## 全六研究監督: 第一の双対結合定数の先行定義待機を維持（2026-09-13 15:00 JST）

実行識別子 `b4c7b222-1bc7-4947-84a9-417b0c1fc324`。LLMによる検証では、正の実数上の実対数と
双曲線正接の独立定義・符号性・値域が先行するまで第一の双対結合定数を分離しない段取りは妥当である。
開始成果以後の差分は同じ不足のstate・MEMORY再確認だけで、数学本文・Lean・SageMathの前進はない。

## 2026-09-13: 第一の双対結合定数の先行定義待機を14時台のremote最新で再確認

`origin/main` の `92996471c3b460162cbaf09e020d8d67234da012` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。8時台の待機記録以後、
複素行列版の数学本文と棚卸しには変更がない。数学的道具立てには双曲線余弦・双曲線正弦の
定義だけがあり、正の実数上の実対数の負値性と双曲線正接の値域を含む独立した先行定義はない。
後続証明内の計算は先行定義の代わりにはならないため、第一の双対結合定数の本文分離を開始しなかった。
次回も両先行定義の整備を確認した後に、この一定義だけを分離する。残余複合定義、棚卸し生成規則、双対関係、
第二の双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。
独立した Codex の LLM による検証では指摘がなく、先行定義の欠落、循環しない依存方向、二章の分類境界、
高校生可読性、および一境界だけを扱う範囲が整合すると判定した。プログラミングによる検証は、生成ラベルと
棚卸し各322件、本文359ブロック、相互参照2263件、SageMath対応125件、Lean 3007ジョブ、PDF 373ページに
ついて成功し、未解決参照、失われた証明、ノート混入、`sorry` / `admit` はいずれも0件だった。

## 2026-09-13: 第一の双対結合定数の先行定義待機を8時台のremote最新で再確認

`origin/main` の `db3541d70c088eb80c99dd04db23d1c9a4bfd365` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。remote の直近更新も
先行定義不足の再確認記録だけで、数学本文と棚卸しには変更がなかった。自由エネルギー章の
実対数は連続性を外部事実として列挙するだけであり、後続証明に現れる双曲線正接の値域と
実対数の符号性も、対象を独立して定めて性質を示す先行定義ではない。必要な二つの先行定義は
未整備のままであるため、第一の双対結合定数の本文分離を開始しなかった。次回も両先行定義の
整備を確認した後に、この一定義だけを分離する。残余複合定義、棚卸し生成規則、双対関係、
第二の双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は
変更していない。
独立 Codex の LLM による検証は未解消指摘なしで、先行定義の欠落、循環しない依存方向、
分類境界、二章制約、高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、`sorry` / `admit` はいずれも0件だった。

## 2026-09-13: 第一の双対結合定数の先行定義待機を6時台のremote最新で再確認

`origin/main` の `2b2b893b520cffadbb72779adf5b94d08fc0b1ea` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。remote の直近更新も
先行定義不足の再確認記録だけで、数学本文と棚卸しには変更がなかった。自由エネルギー章の
実対数は連続性を外部事実として列挙するだけであり、後続証明に現れる双曲線正接の値域と
実対数の符号性も、対象を独立して定めて性質を示す先行定義ではない。必要な二つの先行定義は
未整備のままであるため、第一の双対結合定数の本文分離を開始しなかった。次回も両先行定義の
整備を確認した後に、この一定義だけを分離する。残余複合定義、棚卸し生成規則、双対関係、
第二の双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は
変更していない。
独立 Codex の LLM による検証は未解消指摘なしで、先行定義の欠落、循環しない依存方向、
分類境界、二章制約、高校生可読性、および一境界だけを扱う範囲が整合すると判定した。
プログラミングによる検証は、生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、
SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、
ノート混入、`sorry` / `admit` はいずれも0件だった。

## 2026-09-13: 第一の双対結合定数の先行定義待機を4時台のremote最新で再確認

`origin/main` の `d260bce62a81b14cb13ddc284d3075dd07949728` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。remote の直近更新は研究監督記録
だけで、数学本文と棚卸しには変更がなかった。自由エネルギー章の実対数は連続性を外部事実として
列挙するだけであり、後続証明に現れる双曲線正接の値域と実対数の符号性も、対象を独立して定めて
性質を示す先行定義ではない。必要な二つの先行定義は未整備のままであるため、第一の双対結合定数の
本文分離を開始しなかった。次回も両先行定義の整備を確認した後に、この一定義だけを分離する。
残余複合定義、棚卸し生成規則、双対関係、第二の双対結合定数、双曲線関数の略記、別の節境界、
および数学的道具立ての分類・節境界は変更していない。
独立 Codex の LLM による検証は、最初のレビューで remote SHA の転記誤りを検出し、訂正後の
同一査読セッションによる全文再レビューで未解消指摘なしとなった。事実性、分類境界、依存方向、
二章制約、高校生可読性、一境界だけを扱う範囲が整合すると判定した。プログラミングによる検証は、
生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、SageMath対応125件、
Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、ノート混入、
`sorry` / `admit` はいずれも0件だった。

## 2026-09-13: 第一の双対結合定数の先行定義待機を2時台のremote最新で再確認

`origin/main` の `a6ebcea4dc0b4b5fc29d6cb6810c8a511d813a74` を fetch 後、生成済み棚卸しの
全定義と構造化本文にある実対数・双曲線正接の全出現を再照合した。自由エネルギー章の実対数は
連続性を外部事実として列挙するだけであり、後続証明に現れる双曲線正接の値域と実対数の符号性も、
対象を独立して定めて性質を示す先行定義ではない。必要な二つの先行定義は未整備のままであるため、
第一の双対結合定数の本文分離を開始しなかった。次回も両先行定義の整備を確認した後に、
この一定義だけを分離する。残余複合定義、棚卸し生成規則、双対関係、第二の双対結合定数、
双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界は変更していない。
独立 Codex の LLM による検証は未解消指摘なしで、事実性、分類境界、依存方向、二章制約、
高校生可読性、一境界だけを扱う範囲が整合すると判定した。プログラミングによる検証は、
生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、SageMath対応125件、
Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、ノート混入、
`sorry` / `admit` はいずれも0件だった。

## 2026-09-12: 第一の双対結合定数の先行定義待機を18時台のremote最新で再確認

`origin/main` の `b10f05cf3c8e4606f8cc76eb84518c35e35e53b0` を fetch 後、構造化本文の
全定義を再照合した。自由エネルギー章の実対数は連続性を外部事実として列挙するだけであり、
後続証明に現れる双曲線正接の値域と実対数の符号性も、対象を独立して定めて性質を示す
先行定義ではない。必要な二つの先行定義は未整備のままであるため、第一の双対結合定数の
本文分離を開始しなかった。次回も両先行定義の整備を確認した後に、この一定義だけを分離する。
残余複合定義、棚卸し生成規則、双対関係、第二の双対結合定数、双曲線関数の略記、別の節境界、
および数学的道具立ての分類・節境界は変更していない。
独立 Codex の LLM による検証は未解消指摘なしで、事実性、分類境界、依存方向、二章制約、
高校生可読性、一境界だけを扱う範囲が整合すると判定した。プログラミングによる検証は、
生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、SageMath対応125件、
Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、ノート混入、
`sorry` / `admit` はいずれも0件だった。

## 2026-09-12: 第一の双対結合定数の先行定義待機を16時台のremote最新で再確認

`origin/main` の `bd35992e734aac0342d9867212b4f751bdf663e8` を fetch 後、構造化本文の
全定義を再照合した。自由エネルギー章には実対数の連続性を外部事実として挙げる記述があり、
後続証明には双曲線正接の値域と実対数の符号性を使う計算があるが、いずれも対象を独立して
定めて性質を示す先行定義ではない。必要な二つの先行定義は未整備のままであるため、第一の
双対結合定数の本文分離を開始しなかった。次回も両先行定義の整備を確認した後に、この一定義だけを
分離する。残余複合定義、棚卸し生成規則、双対関係、第二の双対結合定数、双曲線関数の略記、
別の節境界、および数学的道具立ての分類・節境界は変更していない。
独立 Codex の LLM による検証は未解消指摘なしで、事実性、分類境界、依存方向、二章制約、
高校生可読性、一境界だけを扱う範囲が整合すると判定した。プログラミングによる検証は、
生成ラベルと棚卸し各322件、本文359ブロック、相互参照2263件、SageMath対応125件、
Lean 3007ジョブ、PDF 373ページについて成功し、未解決参照、失われた証明、ノート混入、
`sorry` / `admit` はいずれも0件だった。

## 2026-09-12: 第一の双対結合定数の先行定義待機を10時台のremote最新で再確認

`origin/main` の `fbababef259fd8254bf0b4f235f9ff99e4fb6b40` を fetch 後、構造化本文の
全定義を再照合した。正の実数上の実対数について `0<y<1` なら `\log y<0` となる符号性と、
正の実数上の双曲線正接について `x>0` なら `0<\tanh x<1` となる値域を含む独立定義は、
いずれも引き続き存在しない。両定義は数学的道具立てに属し、今回は同章の分類・節境界を
変更しないため、第一の双対結合定数の本文分離を開始しなかった。次回も両先行定義の整備を
確認した後に、この一定義だけを分離する。残余複合定義、棚卸し生成規則、双対関係、第二の
双対結合定数、双曲線関数の略記、および別の節境界は変更していない。

独立 Codex の LLM による検証は未解消指摘なしで、分類境界、依存方向、二章制約、高校生可読性、
一境界だけを扱う範囲が整合すると判定した。プログラミングによる検証は、生成ラベル322件、
本文359ブロック、相互参照2263件、SageMath対応125件、Lean 3007ジョブ、PDF 373ページについて
成功し、未解決参照、失われた証明、ノート混入、`sorry` / `admit` はいずれも0件だった。

## 全六研究監督: Jordan–Wigner表示完了後の先行定義境界を照合（2026-09-13 09:10 JST）

LLMによる検証では、全スピン反転行列のJordan–Wigner表示を構造化本文・SageMath・Lean二版へ統合し、定義と表示定理を分離したことを研究上の前進とした。その後、二つの重複単位行列を既存項への参照へ置換した。第一の双対結合定数へ進むには、正の実数上の実対数と双曲線正接の独立定義・符号性・値域が先行して必要であり、現行stateの条件付き待機へ段取りを修正した判断は妥当である。次の具体的対象は、両先行定義の整備を確認した後の第一の双対結合定数一項であり、未整備の間は本文を変更しない。
前回追記の読解終点 `82201de514e266d8435ad8e0b68b471e09043fd3` から `db3541d70c088eb80c99dd04db23d1c9a4bfd365` までは先行定義不足の再確認だけで、数学本文の新しい統合成果はない。

## 2026-09-12: 第一の双対結合定数の先行定義待機をremote最新で再確認

remote default の最新状態で構造化本文全体を照合した。正の実数上の実対数について
`0<y<1` なら `\log y<0` となる符号性を含む独立定義と、正の実数上の双曲線正接について
`x>0` なら `0<\tanh x<1` となる値域を含む独立定義は、いずれもまだ存在しない。
したがって第一の双対結合定数 `K_1^*:=-\tfrac12\log(\tanh K_1)` を残余複合定義から
分離する条件は満たされていない。本文と棚卸し生成規則は変更せず、次回も両先行定義が
整備済みであることを確認した後に、この一定義だけを分離する。双対関係、第二の双対結合定数、
双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界には進まない。

## 2026-09-12: 第一の双対結合定数に必要な先行定義境界を固定

2次元イジングモデル章の残余複合定義から
`K_1^*:=-\tfrac12\log(\tanh K_1)` だけを分離する条件を、現行本文と棚卸し生成規則で照合した。
自己完結した一定義にするには、正の実数上の実対数、正の実数上の双曲線正接、第一の双対結合定数の
少なくとも三項が必要である。現行本文には前二者の独立定義がなく、`K_1>0` から
`0<\tanh K_1<1` を得て実対数の定義域へ入る根拠も、`0<y<1` なら `\log y<0` となる
符号性から `K_1^*>0` を得る根拠も未整備であるため、実行規約に従って本文分割を行わなかった。

棚卸しには不足する二つの先行定義候補と、上記の値域・符号性を含む両定義が整備済みであることを
条件とする次回一単位を固定した。
次回は条件を満たした後、2次元イジングモデル章の第一の双対結合定数だけを分離する。双対関係、
第二の双対結合定数、双曲線関数の略記、別の節境界、および数学的道具立ての分類・節境界には進まない。

## 2026-09-10: 転送行列とサイト作用素の複合定義の境界候補を固定

2次元イジングモデル章の既存項目「転送行列とサイト作用素の記号定義」一項だけを棚卸しした。
本文の各定義片を章内依存順11–15と照合し、順11はサイトごとの `σ^z`、順12は
サイトごとの `σ^z` と `V_1`、順13は `K_2^*` と `s_2`、順14は
サイトごとの `σ^x`・`K_2^*`・`s_2`・`V_2`、順15は `V_1,V_2` だけを使うと確定した。
Jordan–Wigner 行列、全スピン反転行列とその Jordan–Wigner 表示、`K_1^*` とその
双対関係、`K_2^*` の双対関係、添字つき双曲線関数値の正値性はこの複合定義から直接使われない。
二次の単位行列は既存の Pauli 行列項、`2^M` 次の単位行列は既存のクロネッカー積項で意味が定まるため、
イジング章の独立境界にはせず、参照へ置き換える重複除去候補とした。

三項以上の本文分割と形式化同期が必要なので本文は変更せず、定義と併記された三主張も分けた十三の
イジング章境界候補、二つの重複除去候補、利用先、次回の一単位を
棚卸し生成器と状態台帳へ固定した。次回は最初の利用点を持つ「サイトごとの Pauli 行列族」だけを
添字つきの一つの定義へ分離する。元の複合定義から新定義を参照させて旧ラベル経由の全後続参照を保ち、
順11だけを新ラベルへの直接参照へ移すことで、変更する既存棚卸し項目を二項に限る。数学的道具立ての分類・節境界、
`V_1,V_2`、Jordan–Wigner 行列、全スピン反転行列、双対結合定数には進まない。
## 2026-09-10: 全スピン反転行列の固有値候補を形式化し三節境界を確定

2次元イジングモデル章の既存項目「全スピン反転行列の作用の固有値が `+1` または `-1` に限ること」
一項だけを扱った。本文は行列作用の結合則と複素線型性を成分和十三段で準備し、
`ε²=I` と固有値方程式から零積の場合分けまでの十九段を続ける。Lean 具体版はこの三十二段を同じ順で追う。
必要十分版は二回作用で元へ戻る線型写像、可換性を仮定しない整域、無ねじれ加群に抽象化し、具体版から別定理の特殊化で接続する。
SageMath は固有空間の次元公式を含めず、同じ三十二段を `M=1,…,5` と両符号の有限例について一段一ファイルで厳密判定する。
棚卸しでは、固有空間、二乗と固有値候補、相補射影を三節へ確定した。

独立CodexのLLMによる検証で、必要十分版特殊化のLeanコンパイル失敗、準備の成分計算がLeanに無いための一対一対応不成立、
一行で複数の体の法則を適用した箇所、具体版と必要十分版の相互対応注記、固定SHA-256と資料一覧の漏れを検出した。特殊化の書換え、Leanの成分和十三段、本文・Lean・SageMathの段分け、相互対応注記、資料登録を同期した。
次回は2次元イジングモデル章の
既存項目「転送行列とサイト作用素の記号定義」だけを棚卸しする。三つ以上の定義境界があるため、
本文を大規模に変更せず、境界候補と次回に分離する一単位を固定する。数学的道具立てには進まない。

## 全六研究監督: 固有値候補のcheckpointを未判定で保持（2026-09-10 03:02 JST）

LLMによる検証では、remote defaultに新しい統合済み数学成果はない。別worktreeには全スピン反転行列の固有値候補を本文・SageMath・Lean二版へ対応させた未コミットcheckpointがあり、二乗公式と固有方程式だけから固有値を正負一へ絞る本質を次元公式から分離している。exit 124後の完了検査と統合前なので研究上の前進は未判定とし、成果を上書きせず保持する。段取り変更はない。

## 2026-09-08: 全スピン反転行列の負固有空間の複素部分線型空間性を分離

2次元イジングモデル章の既存項目から、`F^{(-)}` の複素部分線型空間性一項だけを独立ブロックへ
分離した。本文では零ベクトル、和、複素スカラー倍の閉性を、行列と数ベクトルの積の成分表示から
20段の等式として示した。Lean の具体版は同じ20段と部分加群を構成し、必要十分版は有限添字と
可換環だけを残して同じ計算を証明する。SageMath は `M=2` の有限例の全4成分について、20段を
`QQ(i)` 上の厳密等号として一ファイルずつ検査した。

独立CodexのLLMによる検証では数学本体と本文・Lean・SageMathの一対一対応に未解消指摘はなかった。
固定SHA、生成済み棚卸し、下流の形式化記録、状態台帳と本ファイルの同期漏れ、およびLeanで点ごとの
負号を評価する二箇所を修正した。次回は2次元イジングモデル章の既存項目「全スピン反転行列の二乗と
固有値候補」一項だけを照合し、次元公式・射影子以後と数学的道具立てには進まない。

## 全六研究監督: 負固有空間の部分空間性完了と二乗・固有値候補の照合への移行（2026-09-09 02:58 JST）

LLMによる検証では、負固有ベクトル集合の複素部分線型空間性を本文・二十段の有限校正・Lean具体版・必要十分版で閉じたことを研究上の前進と判断した。負側には符号反転があるため、正側の可換半環と異なり必要十分版は加法逆元を持つ可換環を要する。段取り変更なし。次は全スピン反転行列の二乗と固有値候補の現行ブロック境界だけを照合し、次元公式・射影子以後へ進まない。

## 全六研究監督: 正負固有ベクトル集合の定義分離完了（2026-09-08 15:05 JST）

LLMによる検証では、全スピン反転行列の正負固有ベクトル集合を具体的な行列作用で別々に定義し、Lean定義と有限SageMath校正へ同期したことを研究上の前進と判断した。段取り変更なし。次は正固有ベクトル集合の複素部分線型空間性一項だけである。

## 全六研究監督: 射影表示完了と正固有空間定義への移行（2026-09-07 16:28 JST）

LLMによる検証では、セクター射影後の転送行列表示がLean具体版・必要十分版で閉じ、V2の既存対応が確定し、全スピン反転固有空間の混在ブロックが二定義・二部分空間主張へ分離されたことを研究上の前進と判断した。段取り変更なし。次は固有値+1の固有ベクトル全体の具体行列による定義一項である。

## 全六研究監督: セクター射影表示の最終接続前（2026-09-06 20:59 JST）

LLMによる検証では、V1の固有空間制限、下流の一般仮定除去、実行列Wと複素物理転送行列の同一視を研究上の前進と判断した。段取り変更なし。次はこれらと既存Vsym・epsProjをつなぐ射影後等式のLean最終定理一単位である。

## 2026-09-04: $T_{(V')}$ の固定作用の Step 3 を整列式へ統一

ising-lambda 自動ループの tick 197 で、`008_TV1_hatZ_hatY_part2` の主張「$\gamma_2(\theta_\mu)=0$ のとき $T_{(V')}$ が $\hat Z,\hat Y$ を固定する」の Step 3 にある、二次項の交換子が零であることからスカラー倍・有限和を経て $[X,W]=O$ に至る散文中の式を、一行一操作・行末根拠の整列式へ移した。内容・参照は変えていない。次は同じ証明の Step 4 に残る散文中の式を確認する。

## 2026-09-03: 偶セクターの合成共役写像を単一共役へ閉じる二項節を確定

状態台帳の次の一歩に従い、偶セクターの合成共役写像 `T_{(V^{(+)})}` の定義と、それが
`V^{(+)}` による共役に一致する主張の二項だけを確定した。定義は、半指数行列と `V_2` の可逆性、
一般の `T_g`、`V^{(+)}` の三因子表示を直接入力に、三つの共役の合成だけを定める。一致の主張では、
半指数行列と `V_2` の可逆性から最初の二因子の積も可逆であることを明記し、
既存の一般合成則 `T_g\circ T_h=T_{gh}` を二回適用して
`T_{(V^{(+)})}=T_{V^{(+)}}` へ閉じた。一般合成則自体はこの主張内で再証明していない。

Lean の `TVPlus`・`TVPlus_apply` と `TVPlus_eq_TConj`・`TVPlus_apply_eq_conj`、SageMath の
積の左右逆と、二回の合成則を全行列単位上で調べる各検査を二項へ対応させ、棚卸し生成時に本文、
直接依存、章配置、Lean の証明本体、SageMath の実検査本体を固定する。直後の正定値行列 `W` は実対称生成子と正定値行列の
指数関数を入力にする独立した別枝で、この二項と相互に依存せず外部入力集合もすべて切り替わるため、
一致の主張の後で節を閉じた。

次回の一単位は正定値行列 `W` の一項だけとし、直後の Rayleigh 上限の定義との依存方向と入力集合を
確認する。それ以降の独立した境界へは進まない。

## 2026-09-02: 共役写像の一般線型性と半指数行列への特殊化を分離

状態台帳の次の一歩に従い、三つの境界候補のうち先頭二つだけを確定した。一般の可逆な有限複素行列
`g` による共役写像 `T_g` の複素線型性は数学的道具立ての独立主張へ移し、行列サイズの範囲を明記し、
定義、左右の分配、左右の行列積と複素スカラー倍の両立を一行一根拠で示した。Lean の `TConj_linear` と具体版も
同じ行列積の段へ開き、必要十分版からの特殊化関係も別定理で記録した。SageMath は Gaussian
有理数体上の一般複素行列について本文の六段を54件の厳密等号で検査した。

偶セクター半指数行列への特殊化は2次元イジングモデルの独立主張とし、半指数行列の可逆性、一般形、
半整数運動量と添字集合を直接入力にした。Lean の `linearity_of_T_V1halfPlus` は本文と同じ格子幅・添字仮定を持ち、具体版の一般形へ代入し、
章C′の SageMath は半指数行列への代入を別名で検査する。後続の合成共役計算では、内側の `V_2` と外側の半指数行列をそれぞれ対応する特殊化ラベルへ接続した。

第三候補の `V_2` 特殊化は既存内容を失わない独立ブロックへ分けただけで、章配置と形式化対応の
再確認は次回へ残した。棚卸しは数学的道具立て109件、2次元イジングモデル196件の全305件となった。
次回の一単位は `V_2` 特殊化だけとし、合成写像 `T_{(V^{(+)})}` の後続境界へは進まない。

継続tickでremote defaultを取り込んだ際、半指数行列の可逆性の証明が一続きの式変形へ更新され、
行列指数関数の可逆性への参照が数式内の `\blkref` へ移った。数式・根拠・依存の意味が不変であることを
照合し、棚卸しの明示的前提と本文 fingerprint を現行本文へ同期した。

別エージェントのレビューで、一般形における行列サイズの未量化、スカラー倍移動の根拠と Lean の不一致、後続計算における二特殊化の参照混同を検出した。本文、SageMath、棚卸し、後続参照を上記の対応へ修正し、同じ単位で再レビューした。

## 2026-09-02: 共役写像の線型性について三つの境界候補を固定

状態台帳の次の一歩に従い、章内依存順67の共役写像の線型性一項だけを棚卸しした。現行本文は、
一般の可逆な有限複素行列 `g` による `T_g` の複素線型性と、偶セクターの半指数行列および `V_2`
による二つの特殊化を一ブロックへ束ねている。一般形はイジング模型を仮定せず意味が定まるため
数学的道具立てに属し、二つの転送行列による特殊化はイジング固有である。

Lean は `TConj_linear` とその具体版 `linearity_of_T_on_check`、二つの特殊化
`linearity_of_T_V1halfPlus`・`linearity_of_T_V2` を別定理として持つが、いずれも抽象定理の適用で、
人手本文の具体的な行列積計算とは一対一に対応しない。人手証明も一つの等号で左右の分配と二つの
スカラー移動をまとめている。二特殊化は `V^{(+)}` 自体の可逆性を誤って根拠にし、各構成因子の
可逆性、分割後の一般形、半整数運動量モードへの直接依存が欠けている。

SageMath は一般行列 `X,W` の終端等式と半指数行列・`V_2` の特殊化に加え、同じラベルへ対象外の
`V^{(+)}` による単一共役も混在させている。これは合成写像 `T_{(V^{(+)})}` ではなく、後者を扱うには
順68の定義と順69の単一共役との一致が必要であるため、本項の候補には含めない。

一ブロック一主張と二章分類へ揃えるには三主張への本文分割と形式化ラベルの同期が必要なので、今回は
本文・Lean・SageMathを変更せず、一般形、半指数行列、`V_2` の三つを境界候補として棚卸し生成器と
生成出力へ固定した。次回の一単位は先頭二候補、すなわち一般の `T_g` の線型性と半指数行列への
特殊化だけとする。`V_2` の特殊化、合成写像を扱う後続境界、章内依存順68以降、独立した別境界へは
進まない。

棚卸し再生成では、remote 取込で共同固有空間分解の `trace_of_idempotent` 参照が構造化参照から
数式内の根拠へ移り、自動抽出された依存辺が消えていた。現行本文で実際に使う根拠であることを照合し、
明示的な意味的前提として固定して依存辺と参照回数を復旧した。

## 2026-09-02: 偶セクター転送行列の構成因子の可逆性を順66で確定

状態台帳の次の一歩に従い、章内依存順66の `V^{(+)}` の可逆性一項だけをレビューした。順64の
半指数行列と順65の `V_2` の可逆性を直接入力に、最初の二因子の積、続いて三因子の積が可逆で
あることを、可逆行列の積の閉性を一回ずつ適用する本文へ展開した。行列の住処
`R=\mathrm{Mat}(2^M,\mathbb{C})` も明記し、一ブロック一主張と一ステップ一定理を満たした。

Lean の `isUnit_VPlus` は同じ三単元の積を構成し、SageMath は明示逆との右積
`V^{(+)}V^{(+)-1}=I` を検査する。形式化対応表では半指数行列の可逆性と `V^{(+)}` の可逆性を
別行へ分け、各本文ラベルとの対応を修正した。棚卸し生成器は順66の全直接依存、本文 fingerprint、
説明粒度、Lean 宣言、SageMath 実検査、および順67との依存方向・入力集合の切り替わりを固定する。
これにより「偶セクター転送行列の構成因子の可逆性」の節を順66で閉じた。

次回の一単位は章内依存順67の共役写像の線型性一項だけとする。一般の `T_g` の線型性と
`T_{(V^{(+)})}` への特殊化が一ブロック一主張を満たすかを確認し、順68以降と独立境界へは進まない。

## 2026-09-02: login shell の mise hook を有限化

Codex が `timeout 120 git fetch origin` を `/bin/bash -lc` で起動した際、本文の `timeout` より前に
`.bashrc` の `mise activate` が `mise hook-env -s bash` を実行し、設定探索が停滞した。run8では
本文のfetchへ到達するまで約43分を要し、外側tickは成功マーカーなしで異常終了した。作業差分はなく、
専用worktreeをremote defaultへfast-forwardしてから恒久修正した。

tick はmise shimをPATHから除いてNode 22.22.3の実体を固定し、Codex とその子シェルへ
`MISE_NO_CONFIG=1` を継承する。さらに全 `exec_command` に `login=false` を明示する契約をプロンプトへ
追加した。回帰テストはこの静的契約に加え、同じ隔離環境の `/bin/bash -lc` と `/bin/bash -c` が
10秒上限内にNode・npm実行へ到達することを検査する。
remote default取り込み後の全検証では、クロネッカー積基底の二本の計算鎖とクロネッカー積の転置で、
参照一覧が根拠行末へ移った既存変更を検出した。内容・式変形・根拠・参照・依存が不変であることを
履歴と本文で照合し、レビュー済み節が保持する外部入力fingerprintを現行本文へ同期した。

## 2026-09-02: 半指数行列と第二転送行列の可逆性を二主張へ分割

状態台帳の次の一歩に従い、三つの可逆性境界候補のうち先頭二候補だけを扱った。偶セクターの
半指数行列の可逆性と第二の転送行列 `V_2` の可逆性を独立した主張へ分け、分割後の章内依存順を
順64・順65とした。順66には両主張を直接入力とする `V^{(+)}` 自体の可逆性を残した。

Lean の `isUnit_V1halfPlus` と `isUnit_V2` の対応コメントを新しい本文ラベルへ更新し、SageMath の
半指数行列と `V_2` の逆行列積検査も同じラベルへ同期した。棚卸し生成器は二主張の全直接依存、
本文 fingerprint、提示順、Lean 宣言、SageMath 実検査を固定し、304件の一覧を再生成する。

次回の一単位は順66の `V^{(+)}` の可逆性一項だけとする。順64–65を入力とする積の可逆性と、
Lean の `isUnit_VPlus`、SageMath の `V^{(+)}V^{(+)-1}=I` の対応をレビューする。順67の共役写像の
線型性と独立した別境界へは進まない。

## 2026-09-02: 偶セクター転送行列の構成因子について三つの可逆性境界候補を固定

状態台帳の次の一歩に従い、章内依存順64の「`V^{(+)}` を作る行列の可逆性」だけを棚卸しした。
現行の一主張は、偶セクターの半指数行列、第二の転送行列 `V_2`、偶セクター転送行列 `V^{(+)}`
という三対象の可逆性を束ねる。証明も、指数行列の逆行列、正のスカラーと指数行列の積の逆行列、
可逆因子で挟んだ積の逆行列という三段の異なる推論からなる。三段目は先頭二対象の可逆性を使う。

Lean は `isUnit_V1halfPlus`、`isUnit_V2`、`isUnit_VPlus` へ既に分かれている。SageMath も半指数行列、
`V_2`、`V^{(+)}` の逆行列積を三つの実検査行で別々に確認する。このため一ブロック一主張にするには
本文の三分割と形式化ラベルの同期が必要である。新規モードの境界条件に従い、今回は本文・Lean・SageMathを
変更せず、三つを境界候補として棚卸し生成器の固定検査と生成出力へ記録した。

次回の一単位は先頭二候補、すなわち偶セクターの半指数行列の可逆性と `V_2` の可逆性だけとする。
本文を二主張へ分け、対応する Lean 定理と SageMath 検査へ本文ラベルを同期する。三つ目の `V^{(+)}` の
可逆性、直後の共役写像の線型性、および独立した別境界へは進まない。

## 2026-09-02: 偶セクター転送行列と逆行列のトレース正値性まで節を確定

状態台帳の次の一歩に従い、章内依存順63の `\mathrm{tr}((V^{(+)})^{-1})>0` だけをレビューした。
本文は既に一ブロック一主張で、節内では直前の `(V^{(+)})^{-1}` の正定値性だけを受け、外部入力の
正定値行列の指数関数と集合・代数構造の記号も用いて、正定値行列のトレースが正であることを一段だけ適用する。Lean の `trace_VPlusInv_pos` も `VPlusInv_posDef` に
`trace_pos` を一段適用する同じ推論である。SageMath の既存検査では候補逆行列のトレースの
全体最小値が `1.032>0` である。本文・Lean・SageMath の対応と推論粒度に追加分割は不要と判定し、
「偶セクター転送行列の正定値性・可逆性とトレース正値性」の節を順63で閉じた。

直後の順64は三つの構成因子の可逆性を扱う別枝で、順59–63とは相互に依存せず、順65だけが順64を
受ける。次回は順64の一項だけをレビューし、三つの出力を分ける境界候補と次回に扱う最大二項を
状態台帳へ記録する。順65の共役写像の線型性へは進まない。

棚卸し再生成時に、既存tickが Pauli 行列積の行列積根拠を各式の行末 `\blkref{mat_mult}` へ移したため、
本文 fingerprint が変わり、構造化参照ノードとしての前提辺も消えていた。数式・主張・証明段数は
不変であることを履歴と現行本文で照合し、fingerprint を現行値へ同期したうえで、`mat_mult` を
棚卸しの明示的前提として固定し、依存辺を保持した。

## 2026-09-02: 偶セクター転送行列の正定値性と可逆性を二主張へ分割

旧章内依存順58の五候補から、`V^{(+)}` の正定値性と、左右逆による可逆性・逆行列の明示式だけを
今回の一単位として分割した。可逆性の証明では指数行列の四つの左右逆を一行ずつ示し、
`V^{(+)}R^{(+)}=I` と `R^{(+)}V^{(+)}=I` を別々の計算鎖にした。Lean の対応を
`VPlus_posDef`、`VPlus_mul_VPlusInv`、`VPlusInv_mul_VPlus` へ同期し、SageMath も右積と左積を
別ファイルで検査した。最大相対残差は右積 `1.889e-11`、左積 `2.197e-11` で、いずれも合格した。

残る `(V^{(+)})^{-1}` の正定値性、`\mathrm{tr}(V^{(+)})` の正値性、
`\mathrm{tr}((V^{(+)})^{-1})` の正値性は一ブロックのまま章内依存順60へ保留した。
直後の順61にある構成因子の可逆性とは相互に依存せず、順62の共役写像の線型性は順61だけを受けるため、
順60の後は節境界候補のままである。次回の一単位は残余の先頭二候補、すなわち逆行列の正定値性と
`\mathrm{tr}(V^{(+)})` の正値性に限定する。候補逆行列の全固有値正値性を独立検査して
`VPlusInv_posDef`・`trace_VPlus_pos` との対応を同期し、残る逆行列トレースの正値性と順61以降へは進まない。

棚卸し再生成を停止させた Jordan–Wigner 行列の線型独立性と `V_1` 表示の fingerprint 差分は、
既存tickの履歴と現行本文を照合し、式変形の根拠配置だけが行中から `aligned` の行末列へ移り、
数式・根拠・参照・依存は不変と確認して現行値へ同期した。別エージェントのレビューでは、分割後の
正定値性 statement が接続語で終わる未完全文を検出して修正し、再レビューで未解消指摘なしを確認した。

## 2026-09-02: 偶セクター転送行列の五境界候補と次回二項を固定

章内依存順58の現行本文、SageMath、Leanを照合した。現行本文は一ブロックに、`V^{(+)}` の
正定値性、`V^{(+)}` の可逆性、`(V^{(+)})^{-1}` の正定値性、`\mathrm{tr}(V^{(+)})` の正値性、
`\mathrm{tr}((V^{(+)})^{-1})` の正値性という五成果を束ねている。Lean は順に `VPlus_posDef`、
`VPlus_mul_VPlusInv` と `VPlusInv_mul_VPlus`、`VPlusInv_posDef`、`trace_VPlus_pos`、
`trace_VPlusInv_pos` へ分離済みである。一方、SageMath はこれらを定数 `c` の決定と同じ
`check_05_positive_definite_and_c.sage` へ束ね、左右逆と候補逆行列の全固有値正値性を独立項として
検査していない。

三項以上の本文分割と形式化同期が必要なので、今回は本文・SageMath・Leanを変更せず、五つを節境界候補として
棚卸し生成器の固定検査と生成出力へ記録した。次回の一単位は先頭二候補、すなわち `V^{(+)}` の正定値性と
`V^{(+)}` の可逆性（左右逆と逆行列の明示式）だけとする。本文を二つの主張へ分け、SageMath に左右逆の
独立検査を置き、上記三つの Lean 定理との対応を同期してから順58の後の節境界候補を再判定する。
残る逆行列の正定値性と二つのトレース正値性、および順59以降の別境界へは進まない。

棚卸し再生成を止めていたクロネッカー積基底の fingerprint 差分は、既存コミットで根拠配置が
`aligned` の `&&` へ移っただけで、意味・式変形・根拠・参照・依存が不変だった。生成器内の三つの固定値を
現行 hash `c257a4a58107579de48a064c4d124f5608f95fab64bdcd1c4dbd76f2b3c6c1a3` へ同期した。
同じ再生成に現れた三つの fingerprint 差分も履歴と現行本文を照合した。フェルミオン数演算子の冪等性は
`5f6b5787093c788f3ce3dc90bdcd74cf39f581006b97869e5bc07bb6a79b1aad`、半整数運動量モードの
反交換関係は `e9b44b31453da94554f0528485a4951a35dd5a830af2ca6c200db902f4daeb04`、等方結合定数差の
基本性質は `82cc1dbbec3434bcd0949f89e2bdc44045d03b8719fb27fd31b16e0a0d273927` が現行値である。
いずれも既存の式変形の根拠を `aligned` の `&&` 列へ移した変更だけで、式変形・根拠・段数・参照は不変、
再生成前後の直接依存集合も同一だったため、意味と依存は変わっていない。

## 2026-09-02: 偶セクター転送行列の正定値性の節境界候補を記録

2次元イジングモデル章の章内依存順58の後を「偶セクター転送行列の正定値性」の節境界候補とした。
順58は `V^{(+)}` の三因子表示を正定値行列の `B^*AB` へ直し、正のスカラー倍を施して
`V^{(+)}` の正定値性を示す。符号を反転した同じ計算から逆行列の正定値性を示し、両行列の
トレースが正の実数であることへ閉じる。

直後の順59は同じ `V^{(+)}` と半指数行列を再利用するが、一般の指数行列の可逆性と可逆元の積を
入力に構成因子の可逆性を示し、順58とは相互に依存しない。順60の共役写像 `T_g` の線型性は
順59を直接入力として特殊例を正当化する一方、順58には依存しない。この依存と入力集合の切り替わりから、
現行グラフでは順58の後が境界候補になる。生成時に順58の全直接依存、対象と全外部入力の本文 fingerprint、
順59–60の全直接依存と本文、順58・59の相互非依存、順59から順60への依存、および二箇所の
入力集合の切り替わりを固定検査する。

別エージェントのレビューで、順58が正定値性・可逆性・逆行列の正定値性・二つのトレース正値性を
一ブロックへ束ね、Leanでは複数定理へ分かれていることを確認した。順59も三つの行列の可逆性を束ね、
順60にも一般形と特殊例が同居するため、三項以上の本文分割・形式化対応の再点検が必要である。
今回の新規モードの制約に従い本文は大規模変更せず、境界を構造確定しなかった。順59の証明が使う
結合定数・双曲線関数の略記・`V_2` の表示への意味的依存が欠けていたため、転送行列記号の定義を
明示参照して依存を修復した。

棚卸し再生成前に、既存tickがノルムの平方単調性を一行一関係・行末根拠つきへ展開した変更を
旧本文と照合した。意味・式変形・根拠・参照・依存は不変だったため、既存節が固定する外部入力
fingerprint を現行本文へ同期した。同じ再生成で現れた `c=(2s_2)^{M/2}` の証明の fingerprint 差分も、
既存コミットで二段の等式の根拠配置だけが変わり、意味・参照・依存は不変であることを照合した。
コミット前に取り込んだremote defaultでは、ノルムの劣乗法則の四本の鎖にある根拠14行が行末列へ
移されていた。式変形・根拠・段数・参照・依存が不変であることを差分で照合し、生成物を同期した。

次は章内依存順58の `V^{(+)}` の正定値性だけを一単位として、複数出力を一ブロック一主張へ分割し、
SageMath・Lean対応を同期してから順58の後の節境界候補を再判定する。順59以降の別境界へは進まない。

## 2026-09-01: ノルムの平方単調性の式変形を統一

「ノルムの基本性質」（`linear_space_general_002c_claim_matrix_norm_triangle_inequality`）の平方の単調性を示す二本の鎖で、一行に複数あった関係を一行一関係・行末根拠つきの `aligned` へ開いた。内容・式変形・根拠・参照は変えていない。本文 check と PDF 356 ページを通した。

## 2026-09-01: 偶セクター転送行列と符号付きトレースの正値公式を二項節として確定

2次元イジングモデル章の章内依存順56–57を「偶セクター転送行列と符号付きトレースの正値公式」
として閉じた。順56は `V_1^{(+)}` の半指数行列と `V_2` から偶セクター転送行列 `V^{(+)}` を
定義し、順57は配置基底上の対角作用、全スピン反転行列との可換性、開鎖イジング模型の有限和を
使って `\mathrm{tr}(\varepsilon V^{(+)})` を明示的な正の実数へ計算する。

直後の順58は `V^{(+)}` の定義を再利用するが、エルミート正定値行列の指数関数と実対称生成子を
入力に正定値性を示す別枝である。順57と順58は相互に依存せず、全直接依存集合も異なるため、
順57の後を節境界とした。生成時に二項の連続性と全直接依存、対象と全外部入力の本文 fingerprint、
順57への一意な閉包、順58の直接依存・本文、順57と順58の相互非依存、および対象三項の説明粒度を
固定検査する。対象二項の本文分割や形式化同期は不要だった。

棚卸し再生成前に、既存tickが可換な行列指数関数の積公式の基底場合 `AI=A=IA` を二つの等号へ
展開した変更を本文照合した。意味・参照・依存は不変だったため、この項目を外部入力とする既存節と
今回の節の fingerprint を現行値へ同期した。

次は章内依存順58の `V^{(+)}` の正定値性と順59の構成因子の可逆性を本文と照合し、順60の
共役写像 `T_g` の線型性との入力集合・相互依存を確認して次の節境界を判定する。

## 2026-09-01: 偶セクターの半指数行列と平方根性を二項節として確定

2次元イジングモデル章の章内依存順54–55を「偶セクターの半指数行列と平方根性」として閉じた。
順54は偶セクター生成子 `H_1^{(+)}` から半指数行列を定義し、順55は可換な行列指数関数の積公式と
一般の `V_1^{(\pm)}` の上符号を用いて、その二乗が `V_1^{(+)}` に等しいことを示す。

直後の順56は半指数行列の定義だけを再利用して `V_2` と挟み、偶セクター転送行列 `V^{(+)}` を
定義するが、順55の平方根性には依存しない。順56では転送行列の記号を直接入力へ追加する一方、
`H_1^{(+)}`、指数関数の積公式、一般の `V_1^{(\pm)}` 定義を直接入力から外すため、順55の後を
節境界とした。生成時に二項の連続性、項目ごとの全直接依存、対象と全外部入力の本文 fingerprint、
順55への一意な閉包、順56の直接依存・本文・順55からの非依存、入力集合の切り替わり、および
対象三項の説明粒度を固定検査する。対象二項の本文分割や形式化同期は不要だった。

全検証前に取り込んだ remote default では、指数級数の各点収束証明にある線型性の式変形八行が、
行中の根拠から他の証明と同じ行末の根拠列へ移されていた。数式・適用根拠・参照・依存は不変である
ことを差分で照合し、この本文を入力とする既存二節の fingerprint を現行値へ同期した。

次は章内依存順56の偶セクター転送行列 `V^{(+)}` の定義と順57の
`\mathrm{tr}(\varepsilon V^{(+)})` の正値公式を本文と照合し、順58の `V^{(+)}` の正定値性との
入力集合・相互依存を確認して次の節境界を判定する。

## 2026-09-01: 論文構成tickの有限時間継続契約を固定

正規実行が二回続けて55分上限へ達した。いずれも成果差分、Lean build、棚卸し検査、相互レビューは
前進しており、原因は失敗した検証ではなく、七項の本文分割・形式化同期・レビュー・全検証・remote反映を
一つのCodex呼出しへ束ね、打ち切り後も完了工程と新規研究を区別しない契約だった。

新規着手は既存棚卸しの最大二項に制限した。三項以上の分割が必要なら、大規模編集を始めず境界候補と
次回単位の記録を成果にする。未コミット成果があれば継続モードへ固定し、新規境界へ進まず、既存差分の
レビュー・修正・全検証・コミット・remote default反映だけを行う。有限上限時に差分が残る場合は
`CHECKPOINT` として正常に保全する。commit済み・push未了でも継続できるよう、remote defaultに未包含の
ローカルコミットも前回成果として扱う。結果判定の回帰テストでは、cleanでremote一致、dirty、cleanで
ローカルaheadの三状態と、二項上限、CHECKPOINT契約を検査する。

## 2026-09-01: 偶セクター生成子のスピン作用素表示を七項節として確定

旧章内依存順39に混在していた偶セクターの生成子、半指数行列、転送行列、共役写像、可逆性、
平方根性、共役合成一致を独立した定義・主張へ分けた。別エージェントの初回レビューで、
旧生成子表示ブロックに再利用される `D_0,G` の定義が残ること、項目ごとの全直接依存が
固定されていないこと、平方根定義の直接参照と SageMath・Lean の対応記録が分割に追随していないことを
検出した。`D_0` と `G` を独立定義へ分け、参照と対応記録を新ラベルへ同期した。

分割後の章内依存順47–53を「偶セクター生成子のスピン作用素表示」として七項の節へ閉じた。
順47で一般の `H_1^{(\pm)}` から上符号を選ぶ一対象だけを定義し、順48–49で開鎖項 `D_0` と周期境界項 `G` を定義し、順50で
`iH_1^{(+)}=D_0+\varepsilon G` を示す。順51–53は対角作用、可換性、二乗を一主張ずつ示し、
生成子表示、配置基底上の対角作用、`(\varepsilon G)^2=I` の三出力へ閉じた。

直後の順54は順47だけを再利用して `V_1^{(+)}` の半指数行列を定義し、順48–53には依存しない。
順54で入力集合が切り替わるため、順53の後を節境界とした。生成時に七項の連続性、項目ごとの
全直接依存、定義と主張の種別、対象と全外部入力の本文 fingerprint、三つの節末出力、順54の直接依存・本文・
順48–53からの非依存、および入力集合の切り替わりを固定検査する。対象七項は現行の説明粒度検査に合格し、
外部入力には説明粒度の未解決が残る。

remote default取り込みで半整数運動量モードの式変形鎖が一行一根拠へ再編され、`H_1^{(+)}` から
一般の `H_1^{(\pm)},H_2` 定義への直接依存が棚卸しへ現れたため、節の内容を変えず依存順を現行本文へ同期した。

最終レビューでは、上符号生成子の定義に残っていた `V_1^{(+)}` の指数表示を除き、平方根性から
一般の `V_1^{(\pm)}` 定義を直接参照した。`D_0,G` は `H_1^{(+)}` と並行する定義へ直し、生成子表示で
三定義が合流する依存グラフにした。生成子表示・平方根性・共役合成・可換性・配置基底作用の各証明は、
定義展開と有限和への適用を行末ラベル付きで一行ずつ記した。外部入力の一般生成子ブロックは
`H_1^{(\pm)},H_2,V_1^{(\pm)},V_2` を束ねるため、将来の分割対象として棚卸しと状態台帳へ残した。

次は章内依存順54の `V_1^{(+)}` の半指数行列の定義と順55の平方根性を本文と照合し、
順56の偶セクター転送行列 `V^{(+)}` の定義との入力集合・相互依存を確認して次の節境界を判定する。

## 2026-09-01: 実対称な生成子と符号反転共役を二項節として確定

2次元イジングモデル章の章内依存順37–38を「実対称な生成子と符号反転共役」として二項の節へ閉じた。
順37は Pauli 行列の積とクロネッカー積の転置から `iK_1H_1^{(\pm)}` と `iK_2^*H_2` を
実係数の Pauli 行列積で表し、実対称性を示す。順38は順37で得た `H_2` の表示を直接使い、
両方の生成子を同時に負号へ移す可逆行列による共役へ進む。後続分割前の当時は、直後の順39が偶セクターの転送行列と
共役写像を束ねた複合ブロックだった。後続の論文構成再編と直接依存の顕在化後は、順39が一般の
`H_1^{(\pm)},H_2` の定義、順40が偶セクター生成子 `H_1^{(+)}` の独立定義である。

別エージェントの初回レビューで、順38固有の直接依存集合が節全体の外部入力集合だけでは固定されない
ことと、合格済みのエルミート性定義を粒度未解決と誤記したことを検出した。順38の直接依存七件を
完全一致検査へ追加し、粒度記述を現行の生成結果へ合わせた。再レビューでは指摘がなかった。
生成時に二項の連続性、内部依存、順38の全直接依存、対象と全外部入力の本文 fingerprint、順38への
一意な閉包、後続する偶セクター生成子との相互非依存、その本文・直接依存、入力集合の追加・除外、および粒度判定を
固定検査する。棚卸し再生成時に、既存 tick が `H_1^{(\pm)},H_2` の Fourier 表示の証明で根拠配置を
統一した変更を本文照合し、内容・参照・依存が不変であることを確認して fingerprint を同期した。
コミット後の remote default 取り込みで、半整数運動量モードの二本の式変形鎖が行末根拠列へ統一された
変更も同様に照合し、内容・参照・依存が不変であることを確認して fingerprint を同期した。

次は章内依存順39の偶セクターの転送行列 `V^{(+)}` と共役写像 `T_{(V^{(+)})}` の定義を本文と照合し、
章内依存順40の `iH_1^{(+)}` の Pauli 行列表示との入力集合・相互依存を確認して次の節境界を判定する。

## 2026-09-01: run20 の外部入力 fingerprint 停止を修復

棚卸し対象 `linear_space_general_004_lemma_centralizer_is_scalar` について、remote default で三段の
式変形の根拠が行末列へ移された変更を旧本文と照合した。数式・適用根拠・参照・依存関係は不変であり、
説明粒度にも変更がないため、可逆行列と共役写像の節が固定する外部入力 fingerprint を現行本文へ同期した。
同じ本文を受理し、1文字でも異なる内容を同じ fingerprint として受理しない回帰テストを通常の
`npm run check` へ追加した。run20 が保持した七項節の成果は破棄していない。

## 2026-09-01: セクター上の置き換えを分割し七項節として確定

2次元イジングモデル章の章内依存順30–36を「境界項の符号を固定した指数行列・全スピン反転対称性・
セクター上の置き換え」として七項の節へ閉じた。順30で `V_1^{(\pm)}` を定義し、順31は V1 の
固有空間への制限と相補射影の像から射影後の V1 を `V_1^{(\pm)}` へ置き換える主定理へ進む。
並行して順32–35は半指数行列、その平方根性、全スピン反転行列との可換性、相補射影との可換性へ進む。
別エージェントのレビューで、旧順35が射影後の置換と積の冪への反復を一ブロックへ束ねていたことを
検出した。Lean 側は既に二定理へ分離され、後続も冪の主張だけを利用していたため、人手本文も二主張へ
分けた。分割後の順36は順31の置換等式、相補射影の冪等性、順35の可換性を合流させ、置き換えを転送行列の積の
非負整数冪へ反復する系として節を閉じる。直後の順37は `V_1^{(\pm)}` の定義を再利用するが
順31–36には依存せず、Pauli 行列とクロネッカー積の転置から `iK_1H_1^{(\pm)}` と `iK_2^*H_2` の
実対称性を示すため、順36の後を節境界とした。生成時に七項の連続性・内部依存、対象と全外部入力の
本文 fingerprint、順36への一意な閉包、順37の直接依存・本文・順31–36からの非依存、および入力集合の
追加・除外を固定検査する。対象七項は現行の説明粒度検査に合格し、外部入力には説明粒度の未解決が残る。
棚卸し再生成時に、既存 tick が実数指数級数の三本と行列指数級数の四本の式変形鎖を行末根拠へ統一した
変更を本文照合し、内容・参照・依存が不変であることを確認して両方の fingerprint を同期した。
次は章内依存順37の `iK_1H_1^{(\pm)}` と `iK_2^*H_2` の実対称性を本文と照合し、章内依存順38の
符号反転共役との入力集合・相互依存を確認して次の節境界を判定する。

## 2026-09-01: 境界項の符号を固定した指数行列と全スピン反転対称性を五項節として確定

2次元イジングモデル章の章内依存順30–34を「境界項の符号を固定した指数行列と全スピン反転対称性」
として五項の節へ閉じた。順30で境界項の符号を固定した二つの指数行列 `V_1^{(\pm)}` を定義する。
別エージェントのレビューで、旧順31が未定義の `H_1^{(\pm)}` と平方根記号を先取りし、相補射影の
可換性まで一ブロックへ束ねていたことを検出した。このため、半指数行列の定義、その二乗が
`V_1^{(\pm)}` になる主張、全スピン反転行列との可換性、相補射影との可換性へ分割した。分割後は
順30から順34へ一方向に進み、未定義の `H_1^{(\pm)}` を使わず指数の中身を明記し、証明内だけで
`G^{(\pm)}` と略記する。直後の順35は順34に加えて、既に閉じた相補射影の性質と V1 の固有空間への
制限を再結合し、セクター上の V1 の置き換えと積の冪へ進む別の主張である。順35は順30–33を直接
参照せず、前節の内部計算に使う Pauli 行列・クロネッカー積・指数級数の入力を外すため、順34の後を
節境界とした。生成時に五項の連続性、内部依存辺、対象と全外部入力の本文 fingerprint、順34への
一意な閉包、順35の章内順・直接依存・本文 fingerprint を固定検査する。対象五項は現行の説明粒度
検査に合格し、外部入力では集合と代数構造の記号、複素数、混在した転送行列・サイト作用素の記号、
行列指数関数、行列と線型写像の対応の粒度が未解決である。remote default の同時更新で共役写像の
単射性の一行三等号が三段の行末根拠つきの鎖へ変わった箇所は、内容・参照・依存が不変であることを
照合して fingerprint を同期した。次は章内依存順35のセクター上での `V_1` の置き換えを本文と照合し、
章内依存順36の `iK_1H_1^{(\pm)}` と `iK_2^*H_2` の実対称性との入力集合・相互依存を確認して
次の節境界を判定する。

## 2026-09-01: V1 の固有空間への制限を一項節として確定

2次元イジングモデル章の章内依存順29を「V1 の固有空間への制限」として一項の節へ閉じた。
この主張は、V1 の Jordan–Wigner 行列表示、全スピン反転行列の二つの固有空間、ノルムの基本性質の数ベクトル版を入力に、境界項の
全スピン反転行列を固有値 `+1` または `-1` へ置き換え、行列指数関数の部分和を通じて V1 の作用を
各固有空間へ制限する。直後の順30は二つの指数行列 `V_1^{(\pm)}` を定義するだけで順29へ依存せず、
順29も同じ指数行列を証明内の局所的な略記として定めて自足するため、二項に相互依存はない。
順30では転送行列とサイト作用素の記号定義を引き続き入力としつつ、V1 の Jordan–Wigner 表示、固有空間、一因子の反可換性、ノルムの基本性質の数ベクトル版、作用対応の積・指数保存を入力から
外し、線型写像の指数関数の定義を追加する。この入力集合の切り替わりにより、順29の後を節境界とした。
生成時に対象と全外部入力の本文fingerprint、章内順、節末出力、順30の直接依存・本文、二項間の
相互非依存、および入力集合の追加・除外を固定検査する。対象は抽象線型写像との往復を証明全体で使うため
本文粒度は未解決であり、外部入力にも集合と代数構造の記号、複素数、混在したサイト作用素の記号、
ノルムの基本性質の数ベクトル版、行列と線型写像の対応および指数関数保存の粒度未解決が残る。棚卸し再生成時に、既存tickが
クロネッカー積の各因子についての線型性の根拠を行末列へ移した変更を本文照合し、意味・依存・段数・
参照が不変であることを確認してfingerprintを同期した。別エージェントのレビューで、極限の一意性に使うノルムの基本性質の数ベクトル版と、順30が使う転送行列・サイト作用素の記号定義への明示参照が欠けていたことを検出し、本文と固定検査へ補った。次は章内依存順30の、境界項の符号を固定した二つの指数行列 `V_1^{(\pm)}` の定義を
本文と照合し、章内依存順31の全スピン反転行列と `V_1,V_2,V_1^{(\pm)}` との可換性との
入力集合・相互依存を確認して次の節境界を判定する。

## 2026-09-01: 全スピン反転行列の固有空間と相補射影を三項節として確定

2次元イジングモデル章の章内依存順26–28を「全スピン反転行列の固有空間と相補射影」として
三項の節へ閉じた。順26の固有空間定義と、それに相互依存しない順27の二乗・固有値計算が、
順28の相補射影の主張へ合流する。初回レビューで、順27がサイト作用素の積を未証明のまま
クロネッカー積表示へ移し、固有値の推論を一段へ圧縮していたこと、順26を偽の直接入力としていたこと、
順28で像の元を与えるベクトルの所属が欠けていたことを検出した。サイト作用素の積、行列から作用への
移送、固有ベクトルの成分を使う係数消去、複素数の零積則を一段ずつ展開し、順26と順27の相互非依存、
およびベクトルの所属を明記した。直後の順29は順26だけを再利用し、順27・28へ依存しない。
入力集合も相補射影の定義とクロネッカー積の積の規則から、V1のJordan–Wigner行列表示、
一因子の反可換性、ノルムの基本性質の数ベクトル版、行列指数関数の作用保存へ切り替わるため、順28の後を節境界とした。生成時に
三項の連続性、順28へ入る二本の内部依存辺、対象と全外部入力の本文fingerprint、節末出力、
順29の直接依存・本文・非依存、および入力集合の追加・除外を固定検査する。固有空間定義には
抽象線型写像の記述が残るため本文粒度は未解決である。remote defaultでクロネッカー積の定義と
積の規則の根拠が式の行末列へ移った変更は、数式・参照・依存が不変であることを照合して
fingerprintを同期した。次は章内依存順29のV1の固有空間への制限を本文と照合し、章内依存順30の
境界項の符号を固定した二つの指数行列 `V_1^{(\pm)}` の定義との入力集合・相互依存を確認して次の節境界を判定する。

## 2026-08-31: V1・V2 の Jordan–Wigner 行列表示を二項節として確定

2次元イジングモデル章の章内依存順24–25を「V1・V2 の Jordan–Wigner 行列表示」として
二項の節へ閉じた。初回レビューで、独立な二等式を一ブロックへ束ねたまま一項節としていたことが
一ブロック一主張の規約に反すると判明したため、V1 と V2 の主張・証明を分割した。順24はPauli行列の
積とクロネッカー積の規則から隣接サイト項と周期境界項を計算してV1の表示へ閉じ、順25は同じ外部入力
から単一サイト項を計算してV2の表示へ閉じる。二項は同じ入力を共有する並行した出力で相互依存はない。
直後の順26は全スピン反転行列の二つの固有空間を定義するだけで、二つの表示を使わない。順26では
Pauli行列の積とクロネッカー積の規則を入力から外し、行列を数ベクトル空間上の線型写像として作用させる
対応を追加する。この入力集合の切り替わりにより、順25の後を節境界とした。生成時に二項と全外部入力の
本文fingerprint、章内順、内部依存がないこと、二つの節末出力、順26の直接依存・本文fingerprint、
節と順26との相互非依存、および入力集合の追加・除外を固定検査する。分割後の二本文は現行の説明粒度
検査に合格し、外部入力では集合と代数構造の記号、複素数の定義、混在したサイト作用素の記号定義に
分割が残る。順26には抽象線型写像の記述が残るため、本文粒度は未解決である。remote default の
同時更新でトレースの基本性質の根拠配置が行末へ統一された変更は、意味と依存が不変であることを照合して
本文fingerprintを同期した。次は章内依存順26の全スピン反転行列の固有空間を本文と照合し、
章内依存順27の全スピン反転行列から作る二つの行列の性質との入力集合・相互依存を確認して次の節境界を判定する。

## 2026-08-31: Jordan–Wigner 行列の線型独立性を一項節として確定

2次元イジングモデル章の章内依存順23を「Jordan–Wigner 行列の線型独立性」として一項の節へ閉じた。
対象本文は、二次の Pauli 行列を成分比較で基底と確認し、`Z_m,Y_m` をクロネッカー積基底の相異なる
多重添字へ対応させ、基底表示の一意性から線型独立性へ閉じる。直後の章内依存順24は `V_1,V_2` を
Jordan–Wigner 行列で表すが、この線型独立性を使わない。共通入力を残しつつ、クロネッカー積基底を
入力から外し、Pauli 行列の積とクロネッカー積の多重線型性を追加するため、
外部入力集合も切り替わる。生成時に対象と全外部入力の本文fingerprint、章内順、
節末出力の一意性、順24の直接依存・本文fingerprint、二項間の相互非依存、および入力集合の
追加・除外を固定検査する。別エージェントのレビューで、順24が明示的に不使用とする指数関数の積公式を
前提入力へ誤算入していたことと、2×2行列積の成分計算が別内容の「行列の分解」を誤参照していたことを
検出した。前者を「不使用を明記する非前提参照」として前提から除外し、後者は直後に全成分を展開済みなので誤参照を削除した。
remote default の同時更新で分配関数の転送行列表示の参照が数式行末へ移った際は、指数積公式への
意味的依存を保持したまま本文fingerprintを同期した。さらに、臨界条件に使う双曲線正弦積の定義で
二本の等号の根拠が行末へ移った変更も意味と依存が不変であることを照合し、本文fingerprintを同期した。
対象本文は現行の説明粒度検査に合格し、外部入力では集合と代数構造の
記号、複素数の定義、混在したサイト作用素の記号定義の粒度が未解決である。次は章内依存順24の
`V_1,V_2` の Jordan–Wigner 行列表示を本文と照合し、章内依存順25の全スピン反転行列の固有空間との
入力集合・相互依存を確認して次の節境界を判定する。

## 2026-08-31: 転送行列による分配関数の表式の行末根拠を統一

「転送行列による分配関数の表式」の証明で、指数の積公式と分配関数の定義への後置参照を、対応する等号の行末根拠へ移した。内容・式変形・参照は変えていない。

## 2026-08-31: 対称化転送行列の全成分正値性を一項節として確定

2次元イジングモデル章の章内依存順22を「対称化転送行列の全成分正値性」として一項の節へ閉じた。
この主張は、スピン配置と標準基底の対応、サイトごとのσzの対角作用、対角行列の指数関数、実指数関数の正値性、V2の正の
成分表示、V1の平方根と対称化転送行列の定義を入力に、Wの成分を有限行列積として展開して全成分の
正値性へ閉じる。章内依存順23の `Z_m,Y_m` の線型独立性は、サイト作用素の記号とPauli行列から作る
クロネッカー積基底を入力とし、順22との相互依存も共通の直接入力もないため、順22の後を節境界とした。
生成時に対象と全外部入力の本文fingerprint、章内順、節末出力の一意性、順23の直接依存・本文fingerprint、
二項間の相互非依存と直接入力集合の分離を固定検査する。本文では正値性の既存主張を明示参照し、対象と
外部入力が現行の説明粒度検査に合格することを確認した。部分和記号 `E_K` を一般の体の記号 `K` と
誤認していた粒度検査を修正し、対角行列の指数関数に対する誤検出も除いた。棚卸し再生成時に
既存tickが一行一根拠へ整えたクロネッカー積の反交換公式を本文照合し、当該節のfingerprintも同期した。
別エージェントのレビューで正値性証明の周期端 `\mu(M+1)` がブロック内では未定義だったことを検出し、
Step 1 冒頭へ `\mu(M+1):=\mu(1)` を明記した。修正後の再レビューで指摘なしを確認した。
次は章内依存順23の `Z_m,Y_m` の線型独立性を本文と照合し、章内依存順24の `V_1,V_2` の
Jordan–Wigner行列表示との入力集合・相互依存を確認して次の節境界を判定する。

## 2026-08-31: 転送行列の平方根からトレース公式までを三項節として確定

旧章内依存順19に混在していた `V_1^{1/2}` と対称化転送行列 `W` を独立した定義へ分けた。
分割後は `V_1^{1/2}` が章内依存順19、`W` が順20、トレース公式が順21で、一方向の依存鎖を作るため
「転送行列の平方根・対称化転送行列・トレース公式」の三項節として閉じた。別エージェントのレビューで、
トレース公式が平方根の等式を使うのに新しい平方根定義を直接参照していないことと、直前の双曲線正弦積の
境界証拠が分割前の順序を記したままであることを検出し、いずれも修正した。順22の `W` の成分正値性には
二つの定義への直接参照を追加し、トレース公式には依存せず標準基底上の対角作用と `V_2` の成分表示を
追加で使うことを固定検査した。Leanの対応記録、新ラベル、棚卸しを同期し、既存tickによる双曲線正弦積の
本文展開も照合してfingerprintを更新した。最終再レビューで指摘なしを確認した。次は章内依存順22の
対称化転送行列の成分正値性を本文と照合し、章内依存順23の `Z_m,Y_m` の線型独立性との入力集合・
相互依存を確認して次の節境界を判定する。

## 2026-08-31: 臨界条件用の二つの実数を独立した一項節へ分割

旧章内依存順17に一ブロックで置かれていた `κ := 2K_1-2K_2^*` と
`A := \sinh 2K_1\sinh 2K_2^*` を独立した定義へ分けた。分割後はκが章内依存順17、Aが順18で、
相互依存はない。κは結合定数と双対結合定数の差だけを入力とし、Aはそれらに双曲線正弦の定義と
正値性を加えて入力とするため、外部入力集合が切り替わる各項の後で「臨界条件からの差を表す実数」
「二つの双曲線正弦の積」という一項節をそれぞれ閉じた。後続の対称化転送行列は順19、トレース公式は
順20へ移り、どちらの定義にも依存しない。生成時に二定義と全外部入力の本文fingerprint、章内順、
直接依存、節末定義の一意性、前後項からの非依存を固定する。別エージェントの初回レビューでLean形式化
記録の本文ブロック数が14件のままだった同期漏れを検出し、15件へ直した後の再レビューで指摘なしを
確認した。既存tickが一行一根拠へ展開したexp級数各点収束の本文も照合し、棚卸しのfingerprintを同期した。
次は章内依存順19に混在する、転送行列の平方根として使う行列と対称化転送行列を一ブロック一定義へ分け、
分割後の章内依存順とトレース公式へ閉じる節境界を再判定する。

## 2026-08-31: 全スピン反転行列から定める二つの行列を一項節として確定

2次元イジングモデル章の章内依存順16を「全スピン反転行列から定める二つの行列」として一項の節へ
閉じた。順16は混在した順10から全スピン反転行列だけを受け取り、順17は結合定数・双対結合定数・
双曲線関数の略記だけを受け取って順16へ依存しない。順16では二つの行列を定義するだけで、射影子性と
像が固有空間であることは順24で証明されるため、本節の出力には含めない。別エージェントのレビューで、
順17は二つの実数、順18は転送行列の平方根と対称化転送行列という複数の定義を各一ブロックへ束ねた
本文粒度違反を検出したため、両項の節境界は確定せず、手動粒度判定を未解決へ改めた。順18は混在した
順10から `V_1,V_2,K_1`、サイト作用素、格子幅と周期規約を受け取り、直後のトレース公式へ直接入力を
渡す。生成時に順16の対象・全外部入力の本文fingerprint、章内順、節末出力、順17の直接依存と順16からの
非依存、および順17–19の本文fingerprint・直接依存・粒度状態を固定する。次は順17に混在する臨界条件用の
二つの実数を一ブロック一定義へ分け、分割後の章内依存順と節境界を再判定する。

## 2026-08-31: V2 のパウリ行列表示から分配関数への接続を三項節として確定

2次元イジングモデル章の章内依存順13–15を「V2 のパウリ行列表示と分配関数への接続」として
一つの節へ閉じた。二次転送行列の恒等式からV2の二表示の一致へ進み、確定済みの分配関数の
転送行列表示と暫定境界候補のV1の二表示の一致を合わせて、分配関数のPauli行列表示へ閉じる。
次の射影子定義は全スピン反転行列だけを使い、この三項へ依存しないため、順15の後を節境界とした。
生成時に対象と全外部入力の本文fingerprint、章内順、内部依存辺、順15への一意な閉包、次項の
直接依存・本文・直前節からの非依存を固定検査する。対象三項は現行の説明粒度検査に合格した。
外部入力では混在した記号定義、集合と代数構造の記号、複素数、行列指数関数とその収束・可換積公式、
対角行列の指数関数の粒度が未解決である。順10の分割後は、順13が双対結合定数と双曲線関数の略記、
順14がサイトごとのσxとV2、順15がV1・V2の定義片へ依存することを再判定する。三項の連続性、
順15への閉包、次項からの非依存のいずれかが変われば境界を再確定する。次は章内依存順16–18の
射影子、臨界条件に用いる二つの実数、対称化転送行列を本文と照合し、独立した葉の節境界を判定する。

## 2026-08-31: V1 のパウリ行列表示を三項の境界候補として暫定記録

2次元イジングモデル章の章内依存順10–12は、現行の未分割グラフでは「V1 のパウリ行列表示」へ
閉じるため、順12の後を境界候補とした。ただし順10はV1だけでなくV2とJordan–Wigner変換の記号も
束ね、順13・14が順10を再利用し、順15は順10と順12を受け取る。順10を一ブロック一定義へ分割すると
依存辺と境界が変わりうるため、最終的な節構造は未確定である。生成時には順10–12だけでなく、
章内依存順13–15の章内順・直接依存・本文fingerprintと、順15が候補から順10・12を受け取ることも
固定検査する。順10にはPauli行列、cosh・sinh、その正値性の先行参照を追加した。tanhと実対数には
独立した先行定義がなく、双対関係の証明は順10へ依存する後続主張なので循環参照は追加していない。
順12は周期端を `σ_M^zσ_1^z` と `μ(M)μ(1)` に分け、σz作用公式の添字範囲内で証明した。
対象側は順10の分割、外部入力側は集合と代数構造の記号、複素数、行列指数関数、対角行列の
指数関数、行列と線型写像の対応の説明粒度が未解決である。次は章内依存順13–15を本文と照合し、
順13・14が順10のどの定義を使うかと順15が順10・12を受け取る経路を確認して、次の節境界と
順10分割後の再判定条件を定める。

## 2026-08-31: 分配関数の転送行列表示を一項節として確定

2次元イジングモデル章の章内依存順9を「分配関数の転送行列表示」として一項の節へ閉じた。
この主張は、最初の節で定めた周期境界条件つき分配関数と二つの転送行列を入力に、有限行列の
成分・冪・トレースを展開して分配関数のトレース公式へ閉じる。レビューで既存のトレース定義への
参照が欠けていたことを検出し、証明から明示的に参照して依存へ加えた。章内依存順10の記号の定義と
順11のσzの基底作用はこの主張へ依存せず、順10は別の行列指数関数とクロネッカー積を入力とし、
順11は順10とスピン配置・標準基底の対応を入力とするため、順9の後が次の節境界になる。
生成時に対象と全外部入力の本文 fingerprint、章内順、節末出力の一意性、次の二項の直接依存と
本節からの非依存を固定検査する。対象本文は現行の説明粒度検査に合格し、外部入力の粒度は
未解決として区別した。次は章内依存順10–12の記号の定義、σzの基底作用、V1の成分定義と
パウリ表示の一致を本文と照合し、次の節境界を判定する。

## 2026-08-31: 1次元開鎖のスピン和を四項の節として確定

2次元イジングモデル章の章内依存順5–8を「1次元開鎖のスピン和」として一つの節へ閉じた。
別エージェントとの反復レビューで、転送行列定義の行長 `N` を `M` へ付け替える説明、双曲線関数の定義への
参照、三つの主張の分割、正値性に実際に使う根拠、外部入力の粒度状態の区別、前節境界の回帰検査、下流文書と
SageMath生成物の四項分割への追随が欠けていることを検出し、すべて修正した。
共通記法、端点因子のない和、両端のスピンの積を掛けた和、正値性の四項へ分け、二つの和が共通記法から
並行して導かれ、正値性へ閉じる依存構造にした。章内依存順9–10の二項はこの節へ依存せず、節末を含む
三項の外部入力集合も異なるため、順8の後が次の節境界になる。生成時に章内順、内部依存辺、次の二項からの
非依存、本文と全外部入力本文、節末出力の一意性、対象四項の粒度合格を固定検査し、外部入力の粒度は
未解決として明示し、最終再レビューで指摘なしを確認した。次は章内依存順9–11の転送行列による分配関数の表式、記号の定義、σzの基底作用を
本文と照合し、次の節境界を判定する。

## 2026-08-31: スピン配置と標準基底の対応を一項節として確定

2次元イジングモデル章の章内依存順4を「スピン配置と標準基底の対応」として一項の節へ閉じた。
この定義は、最初の節の転送行列と数学的道具立ての標準基底の多重添字を入力に、スピン配置から
多重添字への全単射と、スピン配置を添え字とする転送行列成分の読み方を出力する。章内依存順4–6は
互いを直接参照せず外部入力集合もそれぞれ異なるため、順4の後が次の節境界になる。
別エージェントの初回レビューで、境界根拠に用いた順5・6の変化を生成器が拒否できないこと、対象定義が
無ラベルの章冒頭にある記号読み替えへ依存していること、全単射の終域と粒度状態を強く言い過ぎている
ことを検出した。順4–6の章内順・直接依存・相互非依存・本文と全外部入力本文を固定検査し、対象定義内へ
転送行列定義の鎖長の記号を読み替えることを明記した。節末は標準基底の多重添字への全単射とし、対象本文の
粒度合格と外部入力の未解決を区別した。remote defaultの同時更新で順6の証明が一行一根拠へ展開された際は、
追加したfingerprint検査が意図どおり再生成を停止し、内容を照合して新しい本文を固定した。二度の再レビューで
指摘なしを確認した。次は章内依存順5–7の1次元開鎖のスピン和、転送行列による分配関数の表式、記号の定義を
本文と照合し、次の節境界を判定する。

## 2026-08-31: 2次元イジングモデル章の最初の節境界を確定

章内依存順1–3の格子サイズ、2次元イジング模型の分配関数、転送行列を「格子と転送行列の定義」
として最初の節へまとめた。本文では分配関数が先行する格子サイズの記号を使っていたが、格子サイズに
ラベルがなく、意味的依存が棚卸しへ保存されていなかった。格子サイズへラベルを付け、分配関数から
明示的に参照して、格子サイズから周期境界条件つき分配関数、さらに転送行列へ進む依存鎖を保存した。
レビューで自然数が0を含むため格子サイズ0では周期添え字が未定義になることと、転送行列の結合定数が
使用前に固定されていないことを検出した。格子サイズを1以上に限定し、結合定数を定義冒頭で正の実数
として固定した。生成時に章内依存順が厳密に1–3であること、三項の説明粒度合格、二本の内部依存辺、
節内本文、二つの外部入力とその本文、節末定義を固定検査する。
次は章内依存順4–6のスピン配置と標準基底の同一視、1次元開鎖のスピン和、転送行列による分配関数の
表式について、最初の節から受け取る入力と三項相互の依存を本文と照合し、次の節境界を判定する。

## 2026-08-31: Pauli 行列道具の末尾を二つの節へ分離

数学的道具立ての末尾について、Pauli 行列の積公式からパウリ行列群を定め、その群を共役で保つ
可逆行列全体へ進む依存鎖を「Pauli 行列と共役で保たれる行列群」とした。一因子だけ反可換で残りの
因子が可換なときのクロネッカー積の反交換公式は、行列群を使わずクロネッカー積の積と多重線型性
だけへ依存する独立した葉なので、別の一項節とした。これにより数学的道具立ては章内依存順108まで
節境界の判定を終えた。事前監査で一ブロックに二つの行列群定義が束ねられ、イジング固有の転送行列
による導入理由が数学的道具の定義へ混入していることを検出したため、パウリ行列群とクリフォード
行列群を別ブロックへ分け、転送行列の記述を道具定義から除いた。生成時に二節それぞれの連続性、
内部依存辺、節内本文、外部入力とその本文、節末出力を固定検査する。次は2次元イジングモデル章の
冒頭にある格子サイズ、分配関数、転送行列について、格子サイズから分配関数への意味的依存を本文と
照合して最初の節境界を判定する。

## 2026-08-30: 可逆行列と共役写像の節境界を確定

数学的道具立ての章内依存順101–104を「可逆行列と共役写像」の連続した節境界とした。可逆元の定義、
共役写像の定義、すべての可逆行列と可換する可逆行列の特徴付け、共役写像の非零スカラー倍を除く
単射性の四項からなる。初回レビューで、後二つが一ブロックに束ねられた1ブロック1主張違反と、
特性多項式・固有値と根の同値・行列式による可逆性判定を未定義のまま使う証明経路を検出した。
特徴付けを既存ラベルを保った独立主張へ分け、未定義の経路は追加の抽象理論を導入せず削除した。
代わりに、クロネッカー積で作る行列単位について、非対角なら I+E の逆を I-E、対角なら I-2E の
逆を自分自身と明示する有限行列計算で、可逆行列全体との可換性から全行列との可換性を導いた。
単射性は、順方向では全行列上の写像の一致を可逆行列へ制限し、逆方向では u=cI が全行列と可換する
ことを直接使うため、制限写像から全行列へ延長する議論を要しない。R^× は T_g を定める g の許容範囲で、
各 T_g の定義域は R であることも明記した。生成時に章内連続性、五本の内部依存辺、四項の本文、六つの
外部入力とその本文、節末出力の一意性を固定検査する。次は章内依存順105–107の Pauli 行列の積、
パウリ群・クリフォード群、一因子だけ反可換なクロネッカー積の三項について節をまとめるか分けるかを判定する。

## 2026-08-30: 行列と線型写像の対応の節境界を確定

数学的道具立ての章内依存順96–99を「行列と線型写像の対応」の連続した節境界とした。
主定理は行列表示から線型写像表示への写像が単位的な複素代数の同型であることで、節末は
クロネッカー積の作用公式と指数関数保存の二出力へ閉じる。別エージェントの初回レビューで、
線型写像の指数関数が現行定義では未定義であることと、主定理に独立した作用公式が混在することを
検出した。指数関数保存を数ベクトル部分和の極限へ書き換え、作用公式を独立ブロックへ分け、後続証明も
指数関数保存を直接参照するよう修正した。再レビューで写像冪の定義と多重線型性への直接参照を補い、
最終レビューで承認された。生成時に章内連続性、内部依存辺、節内本文、全外部入力とその本文、二つの
節末出力を固定検査する。SageMath は代数同型20件と作用公式4件へラベル単位で分離した。本文粒度は
未完成として残す。次は章内依存順101–103の「可逆行列と共役写像」三項の節境界を判定する。

## 2026-08-30: 行列指数関数による共役の節境界を確定

数学的道具立ての章内依存順92–93を「行列指数関数による共役の級数公式」の連続した節境界とした。
入力は複素行列の四則演算・交換子作用と二項展開、行列ノルムと完備性、各種指数級数と可換積公式である。
主定理は行列版の指数関数による共役公式で、後続項目はその右辺を項ごとに明示する系として区別した。
初回レビューで Frobenius 内積の独立した葉を含む非連続な候補を棄却し、再レビューで節末と主定理の
混同を訂正した。生成時に章内連続性、内部依存辺、外部入力集合、本文 fingerprint、節末の系への
一意な閉包を固定検査する。二項とも具体的な行列計算への展開またはブロック分割を要するため、
構造だけを確定し本文完成とは扱わない。次は章内依存順96–98の「行列と線型写像の対応」三項について、
内部依存と外部入力を照合して一つの連続した節境界になるか判定する。

## 2026-08-30: 偶数セクター終結章のトレース計算を一行一根拠へ統一

「$\mathrm{tr}(\varepsilon V^{(+)})$ の直接計算」で、巡回性と
$V_1^{(+)}\varepsilon=\varepsilon V_1^{(+)}$ を一つの等号へ同時適用していた箇所を二段へ開いた。
内容と参照は変えていない。次は同じ章の他の証明に複数の関係を同時適用した行が残っていないかを走査する。

## 2026-08-30: 数学的道具立ての分類境界を確定し、集合記号を追加

後続statement参照18件を全件判定し、残った11件を利用先案内として記録した。行列から線型写像への対応は
定義・代数同型性・指数関数との可換性を分離し、Frobenius内積は既存の複素共役・共役転置・トレースを前提とする一つの定義へ整理した。
冒頭に集合としての太字N・Z・Rと、演算・順序を持つ黒板太字N・Z・Rを区別する定義を追加し、複素数は既存の
実数平面上の定義へ接続した。境界分割後は全274件、数学的道具立て105件、2次元イジングモデル169件となり、11分類が全105件を一意に被覆することを
棚卸し生成時に検査する。構成整理HTMLはKaTeX描画と人間向け分類表示へ変更し、内部ファイル名を表示しない。

## 2026-08-30: 指数関数による共役の縮約後トポロジカル順を確定

Frobenius 内積の定義と性質からなる不可分な依存単位を一頂点へ縮約し、指数関数による共役に
関係する5件を4頂点へまとめた。意味的前提による順序は、Frobenius 内積の不可分単位、交換子の
二項展開、交換子作用・共役作用の定義、行列指数共役公式である。内部辺は前二者から作用の定義へ
向く2本、交換子の二項展開と作用の定義から行列指数共役公式へ向く2本の計4本である。
別エージェントの初回レビューで、順序違反の検査だけでは辺の欠落・同方向追加・本文だけの意味変更を
拒否できないことを検出した。確定辺集合との完全一致と5件すべての本文 fingerprint 一致を生成時に
検査するよう修正し、再レビューで指摘なしを確認した。次は縮約4頂点の外部入力集合の変化点と、
行列指数共役公式へ依存群が閉じる点を照合して節境界候補を確定する。

## 2026-08-30: Frobenius 内積の相互参照を同一節の依存単位へ確定

「行列空間の内積・ノルム・収束」と「Frobenius 内積の性質」の相互参照を本文で再確認した。
前者は内積を定義するが、ノルムが非負実数値として定まることを後者の正定値性に依存し、後者は
前者の内積定義に依存する。したがって二辺とも意味的前提として保持し、二ブロックを同一節の
不可分な依存単位として扱う。棚卸し生成時に raw 相互参照と意味的相互依存の両方を検査し、
同一節では内積の導入、性質と正定値性の証明、ノルム・収束の順に読む必要があることを状態台帳へ
記録した。次はこの依存単位を一頂点へ縮約し、指数関数による共役に関係する5件の意味的な
トポロジカル順を確定する。

## 2026-08-30: 論文構成再編で Frobenius 内積の性質の境界を確定

Frobenius 内積の性質1件は、有限複素行列の成分計算だけを対象としイジング固有語彙を含まない。
参照利用は1件だが、確定済みの数学的道具立てである行列空間の内積・ノルム・収束の意味的前提なので、
本文レビューを優先して数学的道具立てへ置いた。共役対称性・線型性と、内積の自己評価を絶対値平方の
有限和へ書き直す成分恒等式までは有限代数で閉じる。正定値性の零判定・ノルムとの一致、および
Cauchy--Schwarz と三角不等式は複素絶対値、非負実数の平方根、実数順序を使い、平方根の存在が
実数の上限性へ到達するため、ブロック全体は実数解析への脱出を伴う。偏角、同じ参照先に同居する
収束概念・完備性・極限則は本文 fingerprint 付きの意味的除外で遮断した。これにより数学的道具立て
から後章へ向く前提依存は0件になった。次は行列空間の内積・ノルム・収束と Frobenius 内積の性質の
相互参照を一つの依存境界としてレビューする。棚卸し再生成、生成器の型検査、構造化本文の参照検査、
対象分類の局所不変条件検査を通した。

## 2026-08-30: 論文構成再編で指数関数による共役の道具群の境界を確定

行列空間の内積・ノルム・収束、交換子の二項展開、交換子作用・共役作用の定義、行列指数共役公式の
4件をレビューした。前者と行列指数共役公式は実数解析への脱出を伴い、後二者は有限行列の代数だけで
閉じる。4件ともイジング固有語彙を含まず、具体的な成分計算・帰納法・有限和・ノルム評価で書かれて
いるため、依存先から順に読めば高校生が追跡できる。行列空間の定義から不要な極限則・偏角を、
交換子作用の定義から不要な内積・ノルム・収束を過大伝播させない検査付き除外を入れ、行列指数共役
公式が直接使う収束列の有界性・積・有限和・添字変更・はさみうちを保存した。別エージェントレビューで
行列指数共役公式だけが実行列も含む領域不一致と、本文の解析境界の過少申告、および意味的除外の
陳腐化を検出した。公式を複素行列へ具体化して後段の極限則を冒頭へ明記し、意味的除外を持つ2件では
title・statement・proof の fingerprint 一致も生成時に検証するよう修正した。極限一意性はラベル付き
参照先から使うため、直接解析入力には重複計上しない。最終再レビューで移行注記の依存過少記載も
直し、4件の分類・依存境界・二章配置・高校生可読性に残存問題がないことを確認した。棚卸し再生成、構造化本文、証明移行、
SageMath 対応、Lean ビルド、sorry 不在の全検証を通した。次は今回の対象に
含めなかった Frobenius 内積の性質1件を独立に分類し、数学的道具立てから後章へ向く前提依存を
二章制約に従って解消できるかレビューする。

## 2026-08-30: 「V̌′ の固有値」の Step 4 を一行一等号へ統一

Lambda 側 8 回目の tick の並列作業として、Step 4（固有値の言い換え）の散文中の一行三等号（Q̌_ε y = Q̌_ε² x = Q̌_ε x = y）と表示式の一行三等号（V̌′y = V̌′Q̌_ε y = e^{ǧ(ε)}Q̌_ε y = e^{ǧ(ε)}y）を、それぞれ四段・三段の一行一等号・行末根拠つきへ開いた。内容と参照は不変で、対象 SageMath 検算（check_03 PASS）、構造化本文の全検査、PDF 生成（340 ページ）を通した。次は同じ証明の続き（トレースの主張）を見る。

## 2026-08-30: 論文構成再編で行列指数関数道具群の境界を確定

実指数級数、行列指数級数の収束、各点収束、指数関数の定義、可換行列の積公式、零行列の
指数関数に属する6件をレビューした。イジング固有語彙は無く数学的道具立てに置くが、実数の
完備性・極限則・収束行列級数へ到達するため、6件すべてが実数解析への脱出を伴う。
別エージェントレビューで各点収束の直接解析入力漏れと、行列版だけを使う2定理への線型写像版
依存の過大伝播を検出した。直接入力を補い、検査付きの経路単位遮断で線型写像版だけを除外した。
再レビューで依存境界、二章分類、高校生可読性を承認し、将来追加される候補のレビュー漏れも
集合一致検査で拒むようにした。次は指数関数による共役の4件をレビューする。

## 2026-08-30: 「V̌′ の固有値」の Step 3′ を一行一等号へ統一

Lambda 側 7 回目の tick の並列作業として、「Step 2 と同じ帰納法」「Step 3 と同じ極限操作」に畳まれていた右から掛ける形を、冪の帰納法五段・部分和四段・極限五段の一行一等号・行末根拠つきへ開いた。内容と参照は不変で、対象 SageMath 検算、構造化本文の全検査、PDF 生成（340 ページ）を通した。次は同じ証明の Step 4 を見る。

## 2026-08-30: 「V̌′ の固有値」の Step 3 の極限を一行一等号へ統一

Step 3 の極限段落で散文に埋もれていた収束論法を、級数表示・行列積の連続性・部分和の鎖・実指数級数の収束と極限の一意性の四段の一行一等号・行末根拠つきの鎖へ開いた。内容と参照は不変で、対象 SageMath 検算（check_03 PASS）、構造化本文の全検査、PDF 生成（339 ページ）を通した。次は同じ証明の Step 3'（右から掛ける形）を見る。

## 2026-08-30: Codex CLIの同一最終本文二重記録を一意化

Codex CLI は同じ最終本文を通常終了直後と Stop hook 後に再度ログへ出すことがあるため、同じ実行識別子・同じ成果コミットの成功マーカー重複は一つの成功として扱う。異なる成果コミット、不正形式、成功マーカーなしは引き続き失敗とし、停止本文だけでは成功しない。回帰テストに同一重複、異なるコミット混在、正当・不正形式混在を固定した。

## 2026-08-30: 論文構成再編で解析的行列道具群の境界を確定

線型空間一般から、数ベクトル・行列のノルム、三角不等式、劣乗法性、数ベクトル評価、完備性、
行列乗算の連続性に属する6件をレビューした。イジング固有語彙は無く数学的道具立てに置くが、
平方根、実数列の極限則、実数の完備性へ到達するため、6件すべてが実数解析への脱出を伴う。
別エージェントレビューで直接解析入力の記録漏れと、参照先の極限一意性から使っていない極限則が
過大伝播する問題を検出した。直接入力を補い、参照先の直接入力だけを遮断しつつ、その先の前提探索は
続ける検査付き設定を追加した。最終再レビューで依存境界、偏角依存の除外、二章分類を承認した。
次は実指数級数・行列指数級数の収束から零行列の指数関数までの行列指数関数道具群をレビューする。

## 2026-08-30: 「V̌′ の固有値」の部分和計算を一行一等号へ統一

Step 3 の部分和を射影子へ掛ける一行三等号を、部分和の定義・有限和と行列積の分配・Step 2・共通因子のくくり出しの四段へ開いた。内容と参照は不変で、対象 SageMath 検算、構造化本文の全検査、PDF 生成を通した。次は同じ証明の Step 3 の極限と Step 3' を見る。

## 2026-08-30: 論文構成再編で有限複素行列の道具群の境界を確定

線型空間一般から、クロネッカー積・その基底・スカラー行列・中心化に属する6件をレビューした。
クロネッカー積の定義にある後続結果への案内を意味的前提から除外すると、依存は6件の内部だけで閉じ、
イジング固有語彙の混入は無い。6件は数学的道具立てに置き、現行statementが任意の体を使う
スカラー行列の可換性は、複素行列への具体化を本文再配置時に確認する事項として記録した。
別エージェントレビューでクロネッカー積の積公式に残る「各サイト」と語彙検査の漏れを検出し、
数学的意味に合う「各因子」へ直すとともに、サイトをイジング固有語彙の検査対象へ加えた。
再レビューで外部前提0件の不変条件が未検査だったことを検出し、外部依存が加わった場合は
対象ブロック・参照ラベル・所有ブロックを列挙して棚卸し生成を失敗させるようにした。
次は数ベクトル・行列のノルム、完備性、行列乗算の連続性に属する解析的道具群の境界をレビューする。

## 2026-08-30: tickの停止報告を成功分類しない結果契約

Codexが停止報告を出して終了コード0を返した場合に、外側tickが `SUCCESS` と記録する不整合を修正した。
実行固有prefixと40桁成果コミットから成る成功マーカーを正確に1件要求し、そのコミットがtick開始後の
成果でremote defaultへ含まれることを外側で再検証する。マーカー欠落・不正・重複の回帰テストも追加した。

## 2026-08-30: 論文構成tickの未完了成果をCI復旧して統合

計算公式群の実数解析境界を確定した成果のPRで、双曲面プロジェクトが直接読む有限グラフ側の
構造化本文依存をCIが設置していないことを検出した。双曲面検証workflowへ有限グラフ側の
lockfile準拠installを追加し、成果を失わずremote defaultへ統合できる状態へ復旧した。

## 2026-08-29: 論文構成再編で計算公式群の実数解析境界を確定

数学的道具立てへ仮分類した計算公式群30件を、実数解析への脱出を伴う18件と、有限回の複素数・
複素行列・商集合の代数操作だけで閉じる12件へ分けた。棚卸しには直接・推移的な解析入力、
依存境界、イジング固有語彙検査をブロック単位で保存し、レビュー割当の欠落・陳腐化を生成時に検出する。

別エージェントの初回レビューで、参照先ブロックの一部だけを使う辺が解析入力全体を誤伝播する問題を
検出した。辺ごとの解析伝播除外を検査付きで追加し、非負実数の平方根から不要な実指数関数依存を、
絶対値の基本性質から不要な偏角切断・逆三角関数依存を除いた。修正後の再レビューで30件全体を承認した。
次は線型空間一般のうち、クロネッカー積・その基底・スカラー行列・中心化から成る有限複素行列の
道具群について、依存境界とイジング固有語彙をレビューする。

## 2026-08-29: 論文構成tickのremote追随を有限時間化

tick開始前の `git fetch` を120秒で打ち切るようにし、remote default branch は fetch 後の
ローカル `origin/HEAD` から取得するよう変更した。ネットワークへ再接続する `git remote show` は使わない。
fetchの失敗はログへ終了コードを残してエラー終了し、別経路へフォールバックしない。

## 2026-08-29: 論文構成再編の継続基盤と初回棚卸し

本文の全定義・主張・定理を最終二章へ再編する専用 Runbook、状態台帳、tick、機械可読棚卸し生成器を追加した。
初回は全263件をフラット化し、計算公式・複素行列の線型空間・行列指数関数・指数関数による共役だけを
「数学的道具立て」へ仮分類した。次は計算公式群をブロック単位で、実数解析への脱出境界と
イジング固有語彙の混入についてレビューする。

## 2026-08-15: 構造化LaTeXから直接生成する静的HTMLを追加

`structured-latex/tools/build-html.ts` と `build:html` を追加し、本文の正本 `content/` だけから
自己完結HTMLを生成できるようにした。既定UIはシステム側の `renderers/html/` を使い、PCでは
現在位置を示す追従型の章ツリー、モバイルでは最上位章だけの追従型横タブを表示する。
参照用 `notes/` は出版HTMLへ混入しない。

## 2026-08-11: 式変形の書き方の統一

2026-08-17 の ising-lambda tick 386 は、`008_TV1_hatZ_hatY_part1` の
「$H$ と $\hat Z$・$\hat Y$ の交換子の入れ子」の補題 1 の末尾で、散文中の
$\mathrm{ad}_{\alpha X}^{\,n}=(\alpha\,\mathrm{ad}_X)^n=\alpha^n\mathrm{ad}_X^{\,n}$ を
一続き二段（行末根拠つき。$n=0$ の断りも根拠へ）へ開いた。数学的内容は変えていない
（tick 383〜385 は同ファイルの $i^n$ の鎖・交換子の双線型性・補題 1 の三段を同様に開いた）。
次は同ファイルの補題 2 以降の散文中の鎖から続ける。

2026-08-15 の ising-lambda tick 287 は、`014_even_sector_T_action` の
「$\check Z,\check Y$ の $n$ 重交換子」の (h2.z) の基底段階 $E_0$ を、散文中の二等号から
恒等写像と零乗をそれぞれ根拠にした二段の等号鎖へ開いた。数学的内容は変えていない。
次は同じ証明の (h2.y) の基底段階から続ける。

2026-08-15 の ising-lambda tick 283 は、`014_even_sector_T_action` の
「偶セクターの転送行列の共役作用」の最初の証明で、指数行列の積、$V_1^{(+)}$ の定義、
可逆元の積の逆元、共役写像の定義を使う各等号の行末根拠を、人間が内容を認識できる定理名へ
揃えた。対応する実在ラベル参照は各式の直前に保ち、同じ根拠を繰り返す後置説明を除いた。
数学的内容は変えていない。次は同ファイルの後続証明から続ける。

2026-08-15 の ising-lambda tick 272 は、`014_even_sector_T_action` の
「$\check Z,\check Y$ についてのテイラー係数の抽出」の (h1.y)(h2.z)(h2.y) の三鎖を、
(h1.z) と同じ粒度へ開いた。各鎖へ変換補題の場合分け形の行（$n=0$ 項を分けた形）と
「$n$ に依らない因子を和の外へ出す」行を補い、一行一等号・行末根拠にした。内容は変えていない。
次は同ファイルの後続の圧縮鎖から続ける。

2026-08-15 の ising-lambda tick 263 は、`009_eigenvalues_of_V` の「数演算子どうしの可換性」
Step 1 にあった四つの反交換関係を、根拠なしで二式ずつ並記した形から、一行一関係・行末根拠を
持つ六段へ開いた。内容は変えていない。次は同じ固有値章の後続証明から続ける。

2026-08-14 の ising-lambda tick 241 は、`011_max_eigenvalue` の「トレース冪の挟み撃ち」
Step 2 で散文内に圧縮されていた $P=I$ 版の対数凸性を、モーメントの定義、冪の指数法則、
実対称性、半正定値双線型形式の Cauchy--Schwarz、ノルムの定義を行末根拠にした八段の
一続きの鎖へ開いた。内容は変えていない。次は直後の奇数・偶数の場合分けの圧縮から続ける。

2026-08-14 の tick 215 は、`010_transfer_matrix_bridge` の「セクター上での $V_1$ の
置き換え」で、固有空間上の制限から $V_1P^{(\pm)}=V_1^{(\pm)}P^{(\pm)}$ を得る段を整えた。
任意の $x\in\mathcal F$ について行列積の作用・射影の像の所属・制限の等式を一行ずつ適用し、
すべてのベクトルへの作用が等しいことから作用素の等式へ戻す鎖にした。内容は変えていない。
次は同ファイルの次の根拠なしの鎖を機械走査して続ける。

2026-08-14 の tick 213 は、`010_transfer_matrix_bridge` の「$P^{(\pm)}$ の性質」で、
冪等性・直交性・射影の和・像の両包含に現れる各計算の直後へ、行末根拠に対応する
定義・主張のラベル参照を補った。等式、不等式、場合分け、使用する根拠の内容は変えていない。
次は「$\varepsilon$ は $V_1,V_2,V_1^{(\pm)}$ と可換」から続ける。

2026-08-14 の tick 212 は、`010_transfer_matrix_bridge` の「分配関数をパウリ行列表示の
転送行列で書く」を一続きの三段の等号列へ統一した。成分定義の $V_1,V_2$ と
パウリ行列表示の $V_1,V_2$ を別記号で明示し、各置換の根拠を対応するラベルから行末で引く。
数学的内容は変更していない。次は「$P^{(\pm)}$ の性質」から続ける。

2026-08-13 の tick 211 は、`010_transfer_matrix_bridge` の「$V_2$ の成分定義と
パウリ表示の一致」の証明に残っていた等式を、一行一等号と行末根拠へ開いた。
指数の和から有限積への変換、クロネッカー積の成分、スカラーの括り出し、サイト演算子の冪、
可換な行列の指数の積を、それぞれ適用箇所で明示した。内容は変えていない。
次は同ファイルの「分配関数をパウリ行列表示の転送行列で書く」から続ける。

2026-08-13 の tick 210 は、`010_transfer_matrix_bridge` の「$2\times2$ の転送行列の
恒等式」に残っていた根拠なしの表示式三つ（Step 1 の $(2s_2)^{1/2}\exp(K_2^*\sigma^x)$ の
成分表示、Step 2 冒頭の $e^{-2K_2^*}=\tanh K_2$、Step 3 の $(2s_2)^{1/2}$ と $t^{1/2}$ の
平方根の式）を一行一等号と行末根拠へ開き、$t:=\tanh K_2$ の定義を等式の鎖から分離した。
内容は変えていない。このブロックの統一は完了した。次は同ファイルの次の根拠なしの鎖から続ける。

2026-08-13 の tick 209 は、`010_transfer_matrix_bridge` の「$2\times2$ の転送行列の
恒等式」Step 1 にあった、指数行列の級数を偶数項と奇数項へ分け、双曲線関数の
テイラー展開へ書き換える二等号を、一行一等号と行末根拠の二行へ開いた。
内容は変えていない。次は同証明の次の根拠なしの鎖から続ける。

2026-08-13 の tick 208 は、`010_transfer_matrix_bridge` の「$V_1$ の二つの定義の一致」の
証明 Step 1 にあった $D\,f_{\iota(\mu)}$ の二等号の鎖を整えた。定義の代入・行列の有限和と
ベクトルの積の分配・$\sigma_m^z\sigma_{m+1}^z$ の対角作用の全項への同時適用・スカラー倍の
括り出しの四行（一行一等号・行末根拠）へ開いた。内容は変えていない。
次は同ファイルの次の根拠なしの鎖から続ける。

2026-08-13 の tick 207 は、`010_transfer_matrix_bridge` の「分配関数の偶奇セクター分解」を
整えた。トレースのセクター分解、セクター内での $V_1$ の置換、転送行列の対称化、
最後のセクター和を一行一等号と行末根拠の鎖へ開いた。内容は変えていない。
次は同ファイルの次の根拠なしの鎖から続ける。

2026-08-13 の tick 206 は、`010_transfer_matrix_bridge` の
「$(V_1V_2)^{n}P^{(\pm)}=(V_1^{(\pm)}V_2)^{n}P^{(\pm)}$」（$V_1P^{(\pm)}=V_1^{(\pm)}P^{(\pm)}$
の帰結の (2)）の帰納段の鎖を整えた。根拠の無かった冪の定義の二行へ行末根拠を付け、
「$P$ を再び右へ戻し $P^2=P$」と複数操作をまとめていた一行を可換・可換・冪等の三行へ開き、
行番号で指していた説明段落を鎖の行末根拠へ吸収した。内容は変えていない。
次は同ファイルの次の根拠なしの鎖から続ける。

2026-08-13 の tick 205 は、`010_transfer_matrix_bridge` の
「$\varepsilon$ は $V_1,V_2,V_1^{(\pm)}$ と可換」の証明を整えた。サイト演算子との可換・
反可換関係、指数関数の部分和と極限、二つの反可換性による符号相殺、$V_1$ の定義への復帰を、
一行一等号と行末根拠を持つ鎖へ開いた。内容は変えていない。この証明ブロック全体を完了した。
次は同ファイルの次の証明ブロックから続ける。

2026-08-13 の tick 204 は、`010_transfer_matrix_bridge` の「射影の代数」の残り、
$P^{(+)}+P^{(-)}=I$ と像の特徴づけ $\mathrm{im}\,P^{(\pm)}=\mathcal{F}^{(\pm)}$ を整えた。
和の一行複数等号を四段の鎖へ、両包含のうち $(\subseteq)$ は散文中の冪等性の適用と
六等号の鎖をそれぞれ四段・八段の鎖へ、$(\supseteq)$ は四等号の鎖を七段の鎖へ開き、
複号同順の符号の整理は行末根拠の中に明記した。内容は変えていない。この証明ブロック全体を
完了した。次は同ファイルの次の根拠なしの鎖（機械走査で特定する。候補は
「$\varepsilon$ は $V_1,V_2,V_1^{(\pm)}$ と可換」以降）から続ける。

2026-08-13 の tick 203 は、`010_transfer_matrix_bridge` の「射影の代数」のうち、
$P^{(\pm)}$ の冪等性と $P^{(+)}P^{(-)}=P^{(-)}P^{(+)}=0$ の直交性を整えた。
定義の代入、分配法則、単位行列との積、同類項、$\varepsilon^2=I$、スカラー倍の整理を
一行一等号と行末根拠を持つ三本の鎖へ開いた。内容は変えていない。次は同じ証明の
「$P^{(+)}+P^{(-)}=I$」と像の特徴づけから続ける。

2026-08-13 の tick 202 は、前 tick が次と名指した「対角行列の指数関数」を機械走査したところ、
一行複数等号・根拠なしの鎖が無い（計算は散文中で根拠つき）と確認したので飛ばし、
同ファイルで次に鎖が残る `010_transfer_matrix_bridge` の
「$(2s_2)^{1/2}\cosh K_2^*=e^{K_2}$・$(2s_2)^{1/2}\sinh K_2^*=e^{-K_2}$」の証明を整えた。
$\cosh K_2^*$・$\sinh K_2^*$ の $t$ 表示、$1\pm t$ の二本、前因子
$(2s_2)^{1/2}/(2t^{1/2})=\cosh K_2$、結論の二本にあった一行複数等号を、
定義の代入・約分・通分・平方根の積の保存が各行で一つの根拠だけを使う鎖へ開いた。
内容は変えていない。この証明ブロック全体を完了した。次は同ファイルの残りの根拠なしの鎖
（射影 $P^{(\pm)}$ の冪等・直交の計算など）から続ける。

2026-08-13 の tick 201 は、`010_transfer_matrix_bridge` の
「$\sigma_m^z$ の基底 $f_{\iota(\mu)}$ への作用」を整えた。Pauli 行列の直接計算を各一段へ開き、
定義の代入、クロネッカー積の積、恒等作用、多重線型性、二作用の合成が各行で一つの根拠だけを
使う鎖へ分けた。内容は変えていない。この証明ブロック全体を完了した。次は同ファイルの
「対角行列の指数関数」から続ける。

2026-08-13 の tick 201 のレビューで、tick 200 が整えた「$V$ の固有値」に、一つの等号で
係数計算と和の線型性を同時に使う二箇所、および冪の法則と指数法則を同時に使う一箇所が
残っていることを確認した。各操作を別の等号へ分け、一ステップ一定理へ修正した。内容は変えていない。

2026-08-13 の tick 200 は、`009_eigenvalues_of_V` の「$V$ の固有値」の証明を整えた。
(1) の $VQ_\epsilon=\Lambda_\epsilon Q_\epsilon$ の一行三等号を三段の鎖へ、(2) の
$g(1,\dots,1)$・$g(0,\dots,0)$ の代入を各二段の鎖へ開き、散文だけで済まされていた積
$\Lambda_{\max}\Lambda_{\min}=(2s_2)^M$ を四段の鎖として書き下した。内容は変えていない。
これで同証明ブロック全体を完了した。次は同ファイルの次の根拠なしの鎖から続ける。

2026-08-13 の tick 199 は、`009_eigenvalues_of_V` の「$c=(2\sinh 2K_2)^{M/2}$」の残りを
整えた。$V^{-1}$ のトレース、逆行列の一意性、$V$ と $V^{-1}$ のトレース表示、二つのトレース比を
一行一等号と行末根拠を持つ鎖へ開いた。内容は変えていない。これで同ブロック全体を完了した。

2026-08-13 の tick 198 は、`009_eigenvalues_of_V` の「$c=(2\sinh 2K_2)^{M/2}$」を途中まで
整えた。Step 1 の $\mathrm{tr}(V)$ の鎖と Step 2 の $\tau$ の鎖に残っていた根拠なしの行へ
行末根拠を補い、Step 3 の $\left(c^{-1}V'^{-1}\right)V=I$ と $V\left(c^{-1}V'^{-1}\right)=I$ の
一行複数等号を各五段の鎖へ開いた。内容は変えていない。同ブロックの残り（逆行列の一意性の
散文内の等号鎖、トレースの比の二つの一行複数等号）は未了で、次はそこから続ける。

2026-08-13 の tick 197 は、`009_eigenvalues_of_V` の「符号反転共役 $U$」を整えた。
パウリ行列一因子の共役、$U$ による共役、$Z_m,Y_m$ への作用、$H_1^{(\pm)},H_2$ と
$S_1^{(\pm)},S_2$ への作用に含まれていた一行複数等号を、一行一等号と行末根拠を持つ鎖へ
開いた。内容は変えていない。次は同ファイルの「$c=(2\sinh 2K_2)^{M/2}$」から続ける。

2026-08-13 の tick 196 は、`009_eigenvalues_of_V` の「$V$ は正定値、とくに
$\mathrm{tr}(V)>0$」を整えた。Step 1 の散文内の $V_2$ の等号鎖を五段の鎖へ、Step 3 の
根拠なしの二等号を二段の鎖へ開き、Step 4 の「内側から順に打ち消し合って $I$ になる」という
無根拠の主張を $W\,V=I$ の九段の鎖（スカラーの前出し・可換行列の exp 積公式・$\exp(O)=I$
を行末根拠に持つ）へ書き下した。この生成器は blkref を定義していないので、行末根拠には
引いたブロックの題を書き、ラベル参照は式の直後の散文に置いた。内容は変えていない。
これで同証明ブロック全体を完了した。次は同ファイルの次の根拠なしの鎖から続ける。

2026-08-13 の tick 195 は、`009_eigenvalues_of_V` の「$iK_1H_1^{(\pm)}$ と $iK_2^*H_2$ は
実対称」に残っていた境界項 $Y_MZ_1$ の等式列について、始点に $Y_M,Z_1$ の定義、終点に $G$ の
定義を行末根拠として補った。内容は変えていない。これで同証明ブロック全体を完了した。
次は同ファイルの「$V$ は正定値、とくに $\mathrm{tr}(V)>0$」から続ける。

2026-08-13 の tick 194 は、`009_eigenvalues_of_V` の「$iK_1H_1^{(\pm)}$ と $iK_2^*H_2$ は
実対称」を整えた。Step 0 の Pauli 行列の積三本（1 行に等号 3 つ）を各三段の鎖へ、Step 1 の
散文内の $H_2$・$S_2$ の等号鎖を三段と四段の鎖へ、Step 2 の $S_1^{(\pm)}$ の代入を五段の鎖へ
開き、各行末へ根拠を付けた。内容は変えていない。次は同ファイルの次の根拠なしの鎖から続ける。

2026-08-13 の tick 193 は、`009_eigenvalues_of_V` の「エルミート行列の $\exp$ は正定値」の
(2)〜(4) を一行一等号と行末根拠へ整えた。合同変換後のエルミート性と正定値性、正の実数倍、
対角成分からトレースの正値性までをそれぞれ連続した鎖にし、内容は変えていない。これで同証明
ブロック全体を完了した。次は同ファイルの「$iH$ は実対称」から続ける。

2026-08-13 の tick 171 は、`008_TV1_hatZ_hatY_part2` の主張
「$T_{(V')}$ の $\psi$ への作用」の Step 4 の有限和の等式三つを一行一等号の鎖へ開き、
各項への右作用・Step 3・有限和への分配則を各行末へ明示した。内容は変えていない。
次は同じ証明の Step 5。

2026-08-13 の tick 170 は、`008_TV1_hatZ_hatY_part2` の主張
「$T_{(V')}$ の $\psi$ への作用」の Step 3 の帰納法を整えた。出発点（1 行に等号 2 つ・
根拠なし）を四段の鎖へ、帰納法の一歩を冪の定義・結合則・帰納法の仮定・Step 2 を
一行ずつ使う七段の鎖へ開いた。内容は変えていない。次は同じ証明の Step 4。

2026-08-13 の tick 169 は、`008_TV1_hatZ_hatY_part2` の主張
「$T_{(V')}$ の $\psi$ への作用」の Step 2 の結論を、交換子の定義・スカラーの交換・
分配則の三段の鎖へ開いた。内容は変えていない。次は同じ証明の Step 3。

2026-08-13 の tick 168 は、`008_TV1_hatZ_hatY_part2` の主張
「$T_{(V')}$ の $\psi$ への作用」の Step 2 を整えた。冒頭の交換子の和（1 表示に等号 2 つ）を
一行一等号の二段へ、場合 b) の $\gamma_2$ の周期性の二本（1 行に等号 3 つ・根拠なし）を
代入を明示した四段の鎖二本へ開き、各行末へ根拠を付けた。内容は変えていない。
次は Step 2 の残り（場合分け a〜c の散文中の等式）か Step 3 から続ける。

2026-08-13 の tick 167 は、`008_TV1_hatZ_hatY_part2` の主張「$\gamma_2$ の周期性」を整えた。
$\theta_M=2\pi$ と $\theta_{-M}=-2\pi$ における指数関数・余弦・正弦の値を明示し、
$\gamma_2(\theta_M)=\gamma_2(\theta_{-M})$ と
$\gamma_2(-\theta_M)=\gamma_2(-\theta_{-M})$ をそれぞれ定義から結論まで連続した等号列へ開いた。
内容は変えていない。次は同じファイルの別の証明から対象を選ぶ。

2026-08-12 の tick 166 は、`008_TV1_hatZ_hatY_part2` の主張
「$T_{(V)}$ と $T_{(V')}$ は $\hat Z^{(-)},\hat Y$ 上で一致する」の場合 2
（$\gamma_2(\theta_\mu)=0$）の二つの等号を三段の鎖へ開き、各行末へ根拠を付けた。
内容は変えていない。これでこの証明の両場合が一続きになった。次は別の証明から対象を選ぶ。

2026-08-12 の tick 165 は、`008_TV1_hatZ_hatY_part2` の主張
「$T_{(V)}$ と $T_{(V')}$ は $\hat Z^{(-)},\hat Y$ 上で一致する」で、$\hat Y_\mu$ の作用を
復元式・二つの線型性・生成消滅演算子上の作用の一致からなる五段の鎖へ開いた。
次は同じ証明の $\gamma_2(\theta_\mu)=0$ の場合から続ける。

2026-08-12 の tick 164 は、`008_TV1_hatZ_hatY_part2` の主張
「$T_{(V)}$ と $T_{(V')}$ は $\hat Z^{(-)},\hat Y$ 上で一致する」の復元後の作用を整えた。
$T_{(V)}$ の生成・消滅演算子への作用を固有値の作用と指数表示の代入へ分け、$T_{(V')}$ との一致を
二つの鎖へ開いた。$\hat Z^{(-)}$ の作用の鎖には復元式を使う始点と終点の根拠を補った。
内容は変えていない。次は同じ証明の $\hat Y$ の作用から続ける。

2026-08-12 の tick 160 は、`008_TV1_hatZ_hatY_part2` の主張
「$T_{(V')}$ の $\psi$ への作用」の Step 4 を整えた。生成部分代数から全行列環へ至る包含、
集合の相等、各点での二写像の値の相等、写像の外延性を一行一関係と行末根拠へ開いた。
内容は変えていない。この証明ブロックの式変形統一は完了した。

2026-08-12 の tick 154 は、`008_TV1_hatZ_hatY_part2` の主張
「$\gamma_1(\theta_\mu)\ge1$」について、二乗の下界と正値性をそれぞれ一続きの鎖へ開き、
全行へ根拠を付けた。内容は変えていない。次は同じファイルの次の証明から続ける。

自動ループの tick 136 で、主張「$a(\theta_\mu)$」の Part B、Steps 9–11 を、独立していた
3 つの表示から一続きの 3 段の鎖へ整え、$\gamma_2$ の定義の代入・三角関数の偶奇性・
非零な共通因子 $i s_2^*$ の約分を各行末の根拠として付けた。内容は変えていない。
次は同じ主張の Step 12 の 2 本の計算から続ける。

自動ループの tick 135 で、主張「$a(\theta_\mu)$」の Part A、Step 8 を、根拠のない 4 つの
独立した表示から、準備の等式（Step 7 の両辺へ $\gamma_2(-\theta_\mu)$ を掛ける 2 段）と
本体の一続きの鎖（5 段。恒等式の根拠・Step 6 の代入・共通細分での重ね合わせ・
$(\pm1)^{-1}$ の計算・符号の積と区間の合併）へ整えた。内容は変えていない。
これで Part A の根拠の粗い行は尽きた。次は Part B 以降を見てから次の証明へ移る。

自動ループの tick 134 で、主張「$a(\theta_\mu)$」の Part A、Step 6 にある根号の積の
2 段を、根号と積の交換条件・Step 5 の場合分け・非零な共通因子の約分の 3 段へ分け、
各行末に根拠を付けた。内容は変えていない。次は同じ主張の Step 8 の組み合わせから続ける。

自動ループの tick 132 で、主張「$a(\theta_\mu)$」の Part A、Step 4 にある 2 段の等号へ
行ごとの根拠を付けた。内容は変えていない。次は同じ主張の Step 5 から続ける。

自動ループの tick 130 で、主張「$A(\theta_\mu)$ の固有値と固有ベクトル」の
固有ベクトルを求める行基本変形以降 9 段すべてへ、行の定数倍・約分・平方根の積・
符号整理・複素平方根の逆数・虚数単位という根拠を行末に付けた。内容は変えていない。
`npm run check`、検証と証明の対応、PDF 292 ページの生成は通過した。
これでこの主張の式変形の点検は済んだ。次は次の主張から続ける。

自動ループの tick 128 で、主張「$A(\theta_\mu)$ の固有値と固有ベクトル」の先頭にある
固有方程式の左辺を、行列の成分表示・$2\times2$ 行列式・負号の整理・平方の展開を
1 行ずつ適用する 4 段の鎖へ整えた。内容は変えていない。`npm run check` と PDF 生成は通過した。
次は同じ証明の二次方程式の解の公式の鎖である。

自動ループの tick 109 で、主張「gamma1 の偏角」の符号判定 3 式を、1 行 1 同値かつ
各行末に根拠を置く形へ書き換えた。内容は変えていない。`npm run check` と PDF 生成は通過した。

自動ループの tick 111 で、同じ主張の極座標表示の 3 場合を整えた。正・負の場合は
極座標表示の定義を当てる段と平方根・逆正接を評価する段を分け、零の場合も定義上の根拠を付けた。
内容は変えていない。

> **旧パスの読み替え（2026-08-01 追記）**: 以下の作業ログには、リポジトリ直下にあった独立アプリ
> `realtime-web-preview/`（ビューア）への言及が多数ある。**当時の記録なので消していない**が、
> 現在そのディレクトリは存在しない。リアルタイムプレビューは structured-latex システムの
> モジュール `structured-latex/live-preview/` へ吸収された。ビューア固有の言語定義・解決
> （`realtime-web-preview/domain-model/src/`）は廃止され、システムの
> `structured-latex/domain-model/`（入力言語・`resolveTolerantly`・配信契約）に一本化されている。
> 起動手順はリポジトリ直下 CLAUDE.md と `structured-latex/live-preview/README.md` を見る。

## 完了（2026-08-03）: **一括検査が落ちていたのを、生成物の再生成だけで緑に戻した**

`structured-latex` の `npm run check` が main の状態で落ちていた。落ちていたのは**生成物の鮮度を
見る段だけ**で、型検査・実行時検証・移行漏れ検出・ノート非混入・負テスト・実行時検証テストは
すべて通っていた（実測で確認）。

原因は、共通ツール（リポジトリ直下 `structured-latex`）の生成器が**翻訳ロケール対応で拡張された**のに、
このプロジェクトの生成物が再生成されていなかったこと。`npm run gen` で作り直しただけで解消した。

- 生成物に増えたのは、翻訳ロケールにしか無いラベルの入れ物（このプロジェクトでは**空**）と、
  それが原文のラベルと交わらないことを主張する型だけ。**翻訳ロケールの内容は導入していない**。
- `content/` は 1 文字も変わっていない（差分は生成物 2 ファイルのみ）。
- 併せて、数値検証と証明の対応（116 件）と PDF 生成（259 ページ・未解決参照 0・組めない文字 0）も通した。

## 完了（2026-08-02）: **PR #70 を一次情報で再検証し、前回の「不要」判定を 2 点訂正して統合・クローズ**

救済 PR #70（ブランチ `salvage/uncovered-sage-checks`）が open のまま残っていたので再検証した。
**前回（下の 2026-08-01 の項）で「main に同等以上のものがあるから不要」と切った 4 件のうち、
2 件は実際には main に無い検証内容を含んでいた。** 判定を訂正して統合した。

- **行列ノルムの検証（試験行列の集合）**: ブランチ側は 58 個・185 件、main の
  `129_def_matrix_norm/` は 33 個・110 件だった。差は (a) **重根をもつ 3x3 Jordan 塊**
  （特異値経路は固有値でなく特異値を使うので、固有値が重根で退化していても他経路と一致すべき）、
  (b) **`i K_1 H_1^{(−)}` と `i K_2^* H_2`**（指数関数の収束を論じるときに実際にノルムを取る対象そのもの）。
  → この 2 種の試験行列だけを main 側の check へ追加。再実行して 58 個・185 件（ブランチ側の実行ログと一致）。
  ブランチ側の `146_def_matrix_norm/` ディレクトリと `_prelude.sage` は**採らない**
  （同じ対象ラベルを宣言するディレクトリが 2 つできる。`_prelude.sage` は同一ファイルを
  各 check ディレクトリへ複製し続ける構成で main は採っていない）。
- **hatZ の (+)/(−) 分解**: main の `191_hatZ_hatY_M_periodicity/check_01` は**差**
  `hatZ^(-)_μ − hatZ^(+)_μ = 2 Z_1 e^{−i2πμ/M}` を **μ = 1..M** についてしか見ていない。
  ブランチ側はこれに加えて**和** `hatZ^(+)_μ + hatZ^(-)_μ = 2 Σ_{j≥2} Z_j e^{−i2πjμ/M}`
  （差の式だけでは「j≥2 の項が両符号で共通」は出てこない。j≥2 が両方で同じだけずれても差は合う）、
  **負の μ を含む μ ∈ 𝓜 全体**、**(+) ≠ (−) の非退化性**を見ていた。
  → `191_hatZ_hatY_M_periodicity/check_02_plus_minus_decomposition.sage` として追加。
  実行結果は **112 件 PASS・最大相対誤差 0.000e+00**。
  置き場所を 201 でなく 191 にしたのは、`201_def_hatZ_hatY/overview.md` が
  「(+)/(−) の差は 191 が担当」と明記しているため。負テスト済み（和の右辺を j≥1 から組むと FAIL）。
- **訂正なし**: `255_def_T_g/` `260_def_T_V/` はブランチ側が古い（ヘッダが旧採番 253/254 を指す）。採らない。
- ブランチの分岐点が古いので、**マージせずブランチ自身が加えた差分だけを現在の main の上へ運んだ。**
- PR #70 は判定をコメントしたうえで**クローズ済み**。詳細は
  [docs/salvage-audit-2026-08-01.md](../docs/salvage-audit-2026-08-01.md) の末尾「追記（2026-08-02）」。
- **教訓**: 「main に同等のものがある」を**対象ラベルとファイル名の一致だけで判定しない。**
  今回の 2 件はどちらも同じラベル・似た名前で、**中で何を検査しているかが違った**。
  CLAUDE.md の「ブロック数や参照解決だけを見て移行完了と判断しない」と同型の失敗。
- **未実施**: `lake build`（今回の差分に Lean ファイルが 1 件も含まれないため）。
- **今回見つけた既存の不具合（未修正・別件）**: `structured-latex` の `npm run check` の
  最初のステップ `check:generated` が main で既に落ちる。原因はシステム側の生成器が
  翻訳ロケール対応（`TRANSLATION_ONLY_LABELS` / `AnyLocaleLabel`）で拡張されたのに、
  このプロジェクトの `labels.generated.ts` / `document.generated.ts` が再生成されていないこと。
  **今回の差分とは無関係**（差分は `sagemath/` と `docs/` のみ）。`npm run gen` 相当の再生成で直るが、
  翻訳ロケール機能の移行判断を含むので本ゴールの範囲外として手を付けていない。
  残る `typecheck` / `validate` / `verify:proofs` / `verify:no-notes` / `test:types` / `test:runtime` は全て PASS。

## 完了（2026-08-01）: **未検証だった定義 `def_hatZ_hatY` の数値検証を追加**

main 未統合成果の全ブランチ・全 PR トリアージ（記録は
[docs/salvage-audit-2026-08-01.md](../docs/salvage-audit-2026-08-01.md)）の結果、
このプロジェクトで **main へ入れる価値が残っていたのは 1 件だけ**だった。

- 追加: `sagemath/check/201_def_hatZ_hatY/check_01_two_forms_of_definition.sage` と `overview.md`。
- **なぜ穴だったか**: 本文 `structured-latex/content/004_transfer_matrix.ts` のブロック
  `transfer_matrix_010_definition_hatZ_hatY` は hatZ^{(±)}_μ を 2 通りの式（cases 記法と、
  j=1 の項を和の外へ出した形）で書いて等号で結んでいる。この等号は定義の well-defined 性に直結するが、
  対象ラベル `def_hatZ_hatY` を宣言する check が 1 件も無かった。
  `191_hatZ_hatY_M_periodicity` は周期性と (+)/(−) の差を見ており、この等号は見ていない。
- 実行結果（自分で SageMath を回して取得）: `checks: 116, max relative error: 3.708e-17, tol: 1.0e-09, PASS`。
- 救済元は `salvage/uncovered-sage-checks`（PR #70）。同ブランチの他のファイル
  （`146_def_matrix_norm/`・`255_def_T_g/`・`260_def_T_V/`・`check_02_plus_minus_differ_only_at_j1`）は
  main 側に同等以上のものが既にあり、不要と判定した（根拠は上記の記録）。
- **未実施**: `lake build`（今回の差分に Lean ファイルが 1 件も含まれないため）。

## 完了（2026-08-01）: **リアルタイム Web プレビューをシステムへ吸収し、旧実装を撤去**

このプロジェクト単体の作業ではないが、本プロジェクトの構造化テキストが**既定の入力ソース**なので記録する。

- リポジトリ直下の独立アプリ `realtime-web-preview/` を、structured-latex システムのモジュール
  `structured-latex/live-preview/`（`backend/` + `frontend/` の 2 パッケージ）へ移設し、
  旧ディレクトリを submodule ごと削除した。
- ビューアが自前で持っていた入力言語の定義（「言語の 3 度目の定義」）と解決（ラベル解決・ノート配置）を
  廃止し、システムの `domain-model/` へ一本化した。解決の実装は
  `structured-latex/domain-model/resolved/resolve.ts` 1 つだけになり、出版物向けの厳格な `resolve` と
  プレビュー向けの寛容な `resolveTolerantly` が同じ実装を通る。
- 配信契約は `structured-latex/domain-model/api-contract/live-preview.ts` へ。
  共有コンパイラ設定は `structured-latex/tsconfig.base.json`（本プロジェクトの
  `structured-latex/tsconfig.json` もこれを継承する）。
- **本プロジェクトへの影響**: 上記「入力言語の定義をシステムへ集約」の末尾にあった未解決
  （プレビューが `sourcePath` / `sourceOrdinal` 必須のためこのプロジェクトを読めない）は**解消**。
  移行後の content を 300 ブロック・38 ノートで読めることを疎通で確認済み。
- 起動: リポジトリ直下 CLAUDE.md の手順、または `structured-latex/live-preview/README.md`。
  入力ソース既定は `exact-solution-of-2d-ising-model/structured-latex/content`（と同 `notes`）。

## 完了（2026-07-31）: **入力言語の定義をシステムへ集約（`schema.ts` を薄い入口にした）**

同じ入力言語（構造化テキストの語彙）が 3 箇所で定義されている状態
（このプロジェクトの `structured-latex/schema.ts` / `integrable-lattice/structured-latex/schema.ts` /
`realtime-web-preview/domain-model/src/block.ts`。3 つ目は当時のパスで、現在は廃止。
プレビュー自体は `structured-latex/live-preview/` へ移った）のうち、**このプロジェクト分を解消した。**
言語の正本はリポジトリ直下の `structured-latex/`（システム）に 1 つだけ置き、こちらは使う側になる。

**やったこと**

- `structured-latex/schema.ts` は 549 行 → 約 150 行。中身は
  「生成された `Label` を受け取る」「`conversion` を宣言する」「システムのファクトリを具体化する」
  「ノード構築子と型を再エクスポートする」だけ。**言語の定義は 1 行も持たない。**
- ブロックの `sourcePath` / `sourceOrdinal` → システムの `origin: { path, ordinal }`（任意）へ移行。
  **コードモッド `tools/codemod-source-to-origin.ts` で機械的に適用**（冪等。既定 dry-run、`--apply` で書き込み）。
  ブロック 300 件・ノート 33 件を変換。ノートの `ordinal` はファイル内の位置を割り当てた
  （システムの `Origin` は `ordinal` 必須。パスを捨てるより位置を与える方を採った）。
- **見出し 22 件の `conversion` は落とした。** システムの `HeadingBlock` はメタデータ `M` を受け取らない。
  落とす前に「`status` が `origin.path` から一意に決まる（不一致 0 件）」「`notes` を持たない（0 件）」を
  実データで確認する検査をコードモッドに組み込んである（破れていたら変換を中止する）。
- `tools/validate-content.ts` はシステムの `createRuntimeSchema`（**throw せず Result を返す**）へ移行。
  このプロジェクト固有の検査（未変換 Typst 記法・抽象テンソル積 `\otimes` の混入）はそのまま残した。
- 生成物（`labels.generated.ts` / `document.generated.ts`）はシステムの生成器で作る。
  `tools/generate-index.ts` は削除し、`npm run gen` / `npm run check:generated` を差し替えた。
- `tools/negative-type-test.ts` は 18 → 7 ケース、`tools/schema-runtime-test.ts` は 10 → 7 ケース。
  **システム側の負テストと重複する分（入力言語そのものの検査）を削り、
  このプロジェクトでしか確かめられないもの**（実在ラベルへの束縛・`conversion` の値域とフィールド名・
  見出しにメタデータを書けないこと）だけを残した。
- `tools/build-latex.ts` は動作を変えていない（型の import 元だけ追随）。
  ただし語彙にあって未対応の `figure` ブロック・`image` ノードは、**黙って落とさず明示的にエラー**にした。

**検証**: `npm run check` exit 0。移行前後で**ブロック 300 件 / 見出し 22 件 / ラベル 252 件 /
相互参照 1853 件 / ノート 38 件 / targets 48 件**が一致し、
`statement` / `proof` / `title` / `labels` / `level` / ノート `body` の JSON は**バイト単位で同一**
（SHA-256 一致。証明の中身は 1 文字も動いていない）。

**移行で失われた検査（型 → 実行時）**: `origin.ordinal` の正の整数性。移行前はテンプレートリテラル型で
コンパイル時に落としていたが、システムの `Origin` は `ordinal: number` である。取り戻すには
`defineBlocks` の引数型をプロジェクト側で書き直すことになり、移行の目的に反するので手放した。
**型へ戻すならシステム側に置くのが正しい**（詳細は `docs/type-coverage.md` §2.4）。

**当時の未解決 → 解消済み（2026-08-01）**: 記載当時、`realtime-web-preview`（当時のトップレベルアプリ）の
Zod スキーマは全ブロックに `sourcePath` / `sourceOrdinal` を**必須**で要求しており、移行後の content を
読めなかった。その後、プレビューをシステムのモジュール `structured-latex/live-preview/` へ吸収し、
ビューア固有の言語定義（「言語の 3 度目の定義」）を廃止したことで**解消した**。
現在のプレビューはシステムの入力言語をそのまま使い、`origin` は任意である
（`structured-latex/domain-model/structured-text/block.ts`）。移行後の本プロジェクトの content を
300 ブロック・38 ノートで読めることを疎通で確認済み
（`structured-latex/live-preview/docs/requirements.md` §11）。

## 完了（2026-07-31）: **「抽象版」を「必要十分版」へ改名し、要件を README に厳密化。違反 2 件を修正**

「抽象版」という呼び名が **「抽象的な概念を持ち込んで同じ主張を証明し直すこと」** と誤解される、
という指摘を受けて点検した。**実際に事故が起きていた。**

- **違反 1（同セッションで私が書いたもの）**: `<tensor_basis>` の「抽象版」が
  mathlib の `Basis.piTensorProduct` / `Matrix.stdBasis` / `Basis.map` への**別名定義だけ**で、
  証明が 1 行も無かった。→ **人手証明と同じ成分比較の論法**
  （`A = Σ A_{IJ} E_{IJ}` と「係数は成分そのもの」）で書き直した。
  その結果、**本文が `<tensor_basis>` を引いている根拠は必要以上に強い**ことが分かった
  （テンソル積は 1 度も現れず、任意の可換環・任意の有限添字型で成り立つ）。
- **違反 2（既存の具体版）**: `<conjugation_is_ring_homomorphism>` の**具体版**が、
  人手証明の結合律の計算ではなく mathlib の群作用（`ConjAct` / `MulSemiringAction`）から
  乗法性を出していた（「具体版は人手証明と 1 対 1」に反する）。→ 原文どおりの計算へ直した。
- **違反ではなかったもの**: `<Z_Y_generate_algebra>` と `<conjugation_is_ring_homomorphism>` の
  必要十分版は、具体版と同じ手順のまま仮定だけを削った形で、意図どおりだった。
  既存の必要十分版 40 ファイルを走査した結果、ファイル全体が既製定理の言い直しなのは
  `NecSuf/ExpDiagonal.lean`（`NormedSpace.map_exp` への丸投げ）**1 件だけ**で、
  ファイル冒頭に「要件を満たしていない・書き直しが残作業」と明記した。

**呼称と配置（正本は README 4 節）**: 名前空間 `Ising2D.NecSuf`、ディレクトリ `lean/Ising2D/NecSuf/`、
導出ファイルは `*FromNecSuf.lean`、記録は `lean/docs/necsuf-*.md`。
`AbstractTensorPow`（抽象テンソル冪という別概念）は改名していない。

**README 4 節に「必要十分版の要件」を明文化した**（満たさないものは必要十分版と認めない）:
①証明手順が具体版と同じ ②仮定は具体版が実際に使う性質だけ
③**既製定理への丸投げ・別名定義を禁止**（一致確認は自前証明を書いたうえで補題 1 本）
④具体版を系として導出 ⑤Lean の中だけに置く ⑥①〜③は具体版にも対称に適用。

**検証**: `lake build` 成功（2994 jobs）、`check-no-sorry.sh` exit 0（**1302 宣言**が標準 3 公理のみ）、
`structured-latex` の `npm run check` exit 0。

## 完了（2026-07-31）: **Lean の「具体版＋抽象版」2 本立てで抽象版が無かった 3 主張を解消**

過去の MEMORY が「残り（抽象版が無い）」として挙げていた 3 主張——
**Z,Y が全行列環を生成 / テンソル冪の基底 / 共役写像が環準同型**——に抽象版を追加し、
具体版を抽象版の系として導出した（README 4 節の規約どおり、**既存の具体版ファイルは一切編集していない**）。
これで当該リストは空になった。

| 人手証明のラベル | 追加した抽象版 | 具体版の導出 | 抽象版で分かった「効いているもの」 |
|---|---|---|---|
| `<Z_Y_generate_algebra>` | `Abstract/GeneratedByBasis.lean` | `Part004/Claim014_ZYGenerateAlgebraAbstract.lean`（`Z_Y_generate_algebra_of_abstract`） | Step 3 は「部分多元環が基底を全部含めば全体」＋「有限添字の直積モノイドからの**モノイド準同型**」だけ（`Subalgebra` ですらなく部分モノイドで足りる）。Step 2 の Jordan–Wigner 帰納法に効くのは**漸化式と「局所元 = 文字列 × 生成元」という分解の形だけ**で、`P_m P_m = I`（対合性）も係数 `-√-1` の値も反交換関係も使わない。複素 2×2 が本質的なのは 1 サイトの基底分解と行列単位のテンソル分解の 2 箇所のみ |
| `<tensor_basis>` | `Abstract/TensorPowerBasis.lean` | `Part002/Theorem000_TensorBasisAbstract.lean` | **因子が全部同じである必要が無い**（テンソル冪は特殊化）。係数は任意の可換半環でよく、体であること・有限次元であること・基底の添字集合が有限であることは効かない。**本文が実際に使う「`E_{IJ}` の族が基底」にはテンソル積が要らない**（「行列単位が基底」＋「基底は線型同型で移せる」の 2 つで足り、`matrixUnitBasis = Abstract.matrixUnitBasis ℂ (Conf M)` は `rfl`） |
| `<conjugation_is_ring_homomorphism>` | `Abstract/Conjugation.lean` | `Part000/Claim045_ConjugationIsRingHomAbstract.lean` | (1) 乗法性・(2) 単位性・(3) 合成則に**環は要らずモノイドで足りる**。分配法則が要るのは加法性だけで、しかも加法性は**可逆性を一切使わない**。合成則は群準同型 `Mˣ →* MulAut M`（半環版 `Rˣ →* RingAut R`）の `map_mul` 1 本に集約。**乗法性は左逆元 `u*b=1` だけ、単位性は右逆元 `b*u=1` だけ**しか使っておらず、片側では足りないことを `Function.End ℕ` の反例で Lean 上で証明した（行列環では片側逆元が両側になるため、行列を離れて初めて見える分離） |

**いずれも具体版が過剰な構造を要求している箇所は見つからなかった。**

記録: `lean/docs/necsuf-zy-generate.md` / `lean/docs/necsuf-tensor-basis.md` /
`lean/docs/necsuf-conjugation.md`。

**検証（統合後の最終状態で実行）**: `lake build` 成功（2994 jobs）、
`bash lean/scripts/check-no-sorry.sh` exit 0（**1301 宣言**がすべて mathlib 標準の 3 公理
`propext` / `Classical.choice` / `Quot.sound` のみに依存、`sorry`/`admit` ゼロ）、
`(cd structured-latex && npm run check)` exit 0。
なお `npm run check` は Node 22.18 以降が必要（このマシンの既定 `v22.8.0` では TypeScript を
直接実行できず落ちる。`~/.nvm/versions/node/v22.22.3/bin` を PATH 前置して実行した）。

**残作業**: README 8 節の「Lean の 2 本立てに整える」観点で、抽象版が無い主張は他にも残りうる。
本セッションで解消したのは MEMORY に明示されていた上記 3 件である。

## 完了（2026-07-31）: 救済PR #24 の残余を数値検証へ統合（行列ノルム 12x/13x 帯）

放棄ブランチ `worktree-indexed-singing-blum`（PR #24）から、main に無い検証だけを抜き出して統合した。
ブランチの採番は main より 1 つずれていた（`131_` = main の `130_` 等）ので、
ディレクトリ構成をそのまま持ち込まず check ファイル単位で main の現行番号へ移してある。

- **新規 `sagemath/check/129_def_matrix_norm/`** — `def_matrix_norm` を対象ラベルに宣言する check は
  main に無かった。ノルム値を 4 経路（定義の二重ループ / numpy / √tr(A*A) / 特異値）で突き合わせ、
  「ノルム収束 ⟺ 成分収束」（d_N ≤ ‖·‖ ≤ n·d_N）も検査する。
- **`130_matrix_norm_triangle_inequality/check_02_limit_uniqueness.sage`** —
  同 overview.md が「(4) 極限の一意性は数値では直接確認できないため含めていない」と
  **明示的に穴を認めていた箇所を埋めた**。証明の骨格 ‖A−A'‖ ≤ ‖A_N−A‖+‖A_N−A'‖ を検査する。
- **`132_.../check_02_proof_path_W.sage`** — 本文の証明が使う行列 W（第 1 列が w、他が 0）を
  実際に構成して ‖AW‖ = ‖Aw‖・‖W‖ = ‖w‖ を確認（証明ステップの書き写しミス検出）。
- **`133_.../check_02_cauchy_completeness.sage`** — 既存は絶対収束側のみだったので完備性側を追加。
- **`135_.../check_02_step2_bound.sage`** — 証明 Step 2 の上界 C = E_{m₀−1}(a) + 2a^{m₀}/m₀! の
  構成そのものを直接検査。

**捨てたもの**: 全ディレクトリに同一内容でコピーされていた `_prelude.sage` 17 個
（main の 12x/13x は prelude を持たない書き方なので、必要な補助は各 check 内に書いた）、
prelude だけで check の無い 10 ディレクトリ（`137_`〜`146_`）、
main の既存 check と同じ主張を見ているだけの 6 ファイル、プリパーサ生成物 `.sage.py` 2 個。

**注意**: 救済元の check は**一度も実行された形跡がなく（ログが無い）、閾値が実際には通らなかった**。
`130_` の「‖A_N−A'‖ → ‖δ‖」を許容誤差 1e-9 の `close` で見ていた点（有限 N では ‖C‖/N の残差が残る）と、
`133_` の「N₀=80 で sup < 1e-6」（r=0.9 では実測 1.2e-2）を、成り立つ評価へ直してから統合した。

**検証**: `structured-latex` の `npm run check` exit 0、`verify-check-linkage.ts` exit 0
（救済 3 件をすべて統合した最終状態で 115 check）、
`run-all-checks.sh 129 130 132 133 135` は 10 本すべて PASS。

## 完了（2026-07-31）: 救済PR #22 の残余を数値検証へ統合（`def_T_g` / `def_T_V` の検証を新設）

`docs/salvage-audit-2026-07-31.md` の「PR #22」節に従い、放置ブランチ
`origin/worktree-foamy-foraging-map` から**価値のある検証だけ**を取り出して統合した。

- **新設 `sagemath/check/255_def_T_g/`** — `T_g : h ↦ g h g^{-1}` の合成則を、Pauli 基底での
  4^M × 4^M 行列表示として 2 経路（基底の像の展開係数／vec 公式 `vec(AXB) = (A ⊗ B^T)vec(X)`）で
  作って突き合わせる。作用素レベルだけだと結合律の言い換えにしかならないための措置。114 判定 PASS。
- **新設 `sagemath/check/260_def_T_V/`** — 「3 段の共役の合成 = 行列 `V` による 1 回の共役」。720 判定 PASS。
- `250_def_partition_function_2d_ising/check_02_symmetries_and_pbc.sage` — 全スピン反転不変性・
  巡回シフト不変性に加え、**周期境界を外した自由境界版と値が一致しないことの否定コントロール**。91 判定 PASS。
- `251_def_transfer_matrix/check_02_V2_as_kronecker_power.sage` — `V_2 = t^(⊠N)`（2×2 転送行列の
  クロネッカー積）による独立構成。60 判定 PASS。

**ディレクトリ番号の注意**: `def_T_g` は文書順では既存 `253_injectivity_of_T_up_to_scalar` の直前だが
`250`〜`254` が埋まっているため `255`、`def_T_V` は `260` を使った（両者の相対順序は保持）。
25x 帯の既存番号（`253` = injectivity、`254` = V2_not_in_clifford、`257` = def_pauli_group）は
もともと文書順に沿っていない。

**捨てたもの**: ブランチの `250_.../check_01_Z_closed_form_1d.sage`、`252_.../check_01〜03`（いずれも
main の既存 check と同内容）、`.sage.py` 8 個（プリパーサ生成物）、ブランチ側の `252_.../_prelude.sage`
（main と関数シグネチャが逆で非互換。main 側 `_prelude.sage` は一切変更していない）。

## 完了（2026-07-31）: 救済PR #21 の唯一の残余（K₂* の二分法による独立求解）を統合

- `sagemath/check/231_duality_c2_star_eq_s2_star_c2/check_02_K2star_by_bisection.sage` を追加。
  閉じた式 K₂* = −(1/2)log(tanh K₂) を使わずに sinh(2K₂)sinh(2x) = 1 を二分法で解き、
  閉じた式の値と一致することを確かめる（既存の 01 は閉じた式を前提にしているので、02 は独立経路）。
- 救済元ブランチ `worktree-eventual-cuddling-deer` の残り 27 ファイル（`_prelude.sage` 15 個、
  `.sage.py` 5 個、prelude だけで check の無い 11 ディレクトリ、main に被覆済みの check 5 本）は
  意図的に捨てた。判定根拠は `docs/salvage-audit-2026-07-31.md` §2-3 と PR #21 のコメント。
- 救済元の `_prelude.sage` には依存させず、必要な定義は check ファイル内に書いて
  231 ディレクトリ既存の書き方（`_shared/operators.sage` を load するだけ）へ揃えた。
- 判定 65 件・最大相対誤差 5.311e-16 で PASS（既定の許容誤差 1.0e-09 のまま）。

## 完了（2026-07-27）: **本文の全 20 章に機械証明が付いた**（章 009〜020 を一気に形式化）

このセッションの前は、Lean の形式化は**章 008 まで**しか無かった。**章 009〜020 の 12 章を
並列で形式化し、すべて main へ入れた。機械証明が無い章は無くなった。**

**Lean 側に立った結論**:

- `Ising2D.onsager_exact_solution` — Onsager の厳密解（章 018）
- `Ising2D.onsager_exact_solution_unconditional` — 章 014〜017 由来の仮定をすべて消した版
- `Ising2D.specific_heat_log_divergence` — 臨界点での比熱の対数発散（章 020）。
  **仮定は「臨界点の近傍にあること」と `K ≠ K_c` の 2 つだけで、これは人手証明の
  `0 < |K−K_c| ≤ 1/10` そのもの。追加の前提はゼロ。**

**検証（このセッションの最終状態）**: `lake build` 成功（2984 jobs）、
`scripts/check-no-sorry.sh` exit 0、**1238 定理**がすべて mathlib 標準の 3 公理
（`propext` / `Classical.choice` / `Quot.sound`）のみに依存。`sorry` / `admit` はゼロ。

**章ごとの詳細は `lean/docs/ch0NN-formalization.md`（12 ファイル）が正本**。
`lean/README.md` に索引と要約を統合した。

### 2 本立てが出した最大の答え

**整数運動量版（章 004〜009）と半整数運動量版（章 013〜017）は、同じ抽象版の別の特殊化である。**
`e^{-iθ~}` は 1 の原始 `2M` 乗根 `ξ` の**奇数周波数**、整数運動量は `ζ = ξ^2` の偶数周波数。
本文が「仕組みは 1 つの等式 `e^{-iMθ~} = -1` に集約される」と書く等式の正体は `ξ^M = -1` で、
証明は「`(ξ^M)^2 = 1` かつ原始性から `≠ 1`、体だから `-1`」の 3 行。指数関数も円周率も効いていない。
対の添字が `μ+ν ≡ 0` から `≡ 1` へずれる理由も `(2μ-1)+(2ν-1) = 2(μ+ν-1)` の `-1` の 1 点だけ。

**半整数運動量では例外処理が消える**: `γ_2(θ~_μ) ≠ 0` が常に成り立つので、整数運動量にあった
臨界点の例外処理（`μ = M` の除外、`m = M-1`）が不要。章 008 の**平方根の分枝の一致という原文の穴**も、
半整数運動量では係数が非負実数 `|γ_2(θ~_μ)|` になるため**そもそも生じない**。

### mathlib について確定したこと

- **`lean/README.md` の「mathlib に `Real.arccosh` は無い」は誤りだった**。現行 mathlib（v4.32.1）に
  `Real.arcosh`（綴りが違う）が同じ定義式で存在する。README を訂正済み。
- **本当に無かったもの**: 等分割リーマン和から積分への収束（章 012 で自前証明）、
  連続性だけを仮定した積分記号下の微分（章 020 の (R5)）、トレースが閉じた道の総和であること（章 010）、
  `sinh t ≤ t cosh t`（章 020）。

### 人手証明に見つけた問題（**本文は一切編集していない**。修正は別セッションの担当）

`docs/tasks/2026-07_lean-ch009-013/` に 14 件を一次情報つきで記録した。
**結論を覆す誤りは 1 件も見つかっていない。** 内訳:

- **添字指定の誤り**: 章 011 `trace_power_sandwich` Step 2。本文の `(a,b) = (k-1,k+1)` を代入しても
  目的の不等式にならない（正しくは `k` の偶奇で `((k-1)/2,(k+1)/2)` / `(k/2-1,k/2)`）。結論は正しい。
- **根拠の欠落**: 章 011 の `c_±(M)` の `sup` が定義できること（セクター内に単位ベクトルが
  存在することが本文に無い）。章 019 が `𝓕^{(-)}` 側を埋めた。
- **記述の不正確さ**: 章 012 の「外部から持ち込む実数解析の事実は (R1)(R2) の 2 つだけ」。
  `γ` の連続性が `cos` / `√` / `log` の連続性も使っている。
- **過剰な仮定・冗長な手順**: 章 011・014・017・018・019・020 に計 10 件。

### 検証ハーネスの実バグを 1 件修正

`lean/scripts/check-no-sorry.sh` の一時ファイルが固定パスだったため、**複数 worktree で
同時に実行すると互いに上書きし、別ブランチの定理一覧を検査して誤検出**していた（実際に踏んだ）。
`mktemp` 化済み。**並列で Lean 作業をするならこの修正が入っていることを確認すること。**

### 残作業（各章ドキュメントの「形式化できなかった主張」節が正本）

1. 同時固有空間分解の `DirectSum.IsInternal` 形と「対角化可能」の主張（章 009・017）。
   原文に無い `Submodule` 言語への翻訳が必要。後段が使う固有値と重複度は形式化済み。
2. `tr(εV^{(+)}) > 0`（章 018 の `closing_004`–`006`、配置基底の 1 次元開鎖スピン和）。
   `onsager_exact_solution_unconditional` が残す仮定 `htr` の正体。
3. 章 011 (2)（`W P^{(+)} = V^{(+)} P^{(+)}`）→ 章 004 `V1_restriction_to_eigenspaces` の未形式化連鎖。
   章 010 の `Claim011` も同じものを `hres` として仮定している。**ここを埋めると
   `onsager_exact_solution_unconditional` の仮定がさらに減る。**

---

## 完了（2026-07-27）: **章 018 の仮定を章 014–017 の形式化で埋めた**（Onsager が無条件版へ）

章 018 は着手時点で章 014–017 が Lean 未形式化だったため、それらの結果を
`Ising2D.CheckFermi` / `Ising2D.VPlusData` の**仮定**として受け取っていた。
014・015・016・017 がすべて main に入ったので、**実際にインスタンスを構成して
仮定を定理に置き換えた**。章 018 以外の `.lean` と `structured-latex/` は編集していない。

追加した 3 ファイル（`lean/Ising2D/Part018/`）:

- `Claim011_CheckFermiFromPart016.lean` — `Ising2D.checkFermiOf`（`CheckFermi` のインスタンス）。
  `hstar`（`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`）は章 016 に対応定理が無かったので
  `Ising2D.checkPsiDag_conjTranspose` として**新規に証明**した（章 008 の
  `gamma2_neg_eq_neg_conj` と章 018 の `checkZ_conjTranspose` だけを使う）。
- `Claim012_VPlusDataFromPart017.lean` — `Ising2D.vPlusDataOf`（`VPlusData` のインスタンス）。
  章 017 の `CheckFermiSetup`（添字型 `CheckIdx M`）と章 018 の `CheckFermi`（`Fin M`）の
  ずれを `Ising2D.finCheckIdxEquiv` で噛み合わせ、`V^{(+)} = (2 sinh 2K_2)^{M/2} V̌'` を得た。
- `Theorem013_OnsagerUnconditional.lean` — `Ising2D.onsager_exact_solution_unconditional`。

**消せた仮定**: `ψ̌` の CAR、`(ψ̌_μ^†)^* = ψ̌_{M+1-μ}`、`V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`、
`C = (2 sinh 2K_2)^{M/2} > 0`、`γ(θ̃_μ) > 0`、章 012 の記法との一致（`hC` / `hgam`）。
つまり**章 014・015・016・017 由来の仮定はゼロになった。**

**残った仮定**（`Ising2D.EvenSectorClosureInput` に束ねた。いずれも 014–017 由来ではない）:
`M ≠ 0`、双対関係 `c_2 s_2^* = c_2^*`（原文の前提）、`EvenSectorBridge`
（章 011 (2) `W P^{(+)} = V^{(+)} P^{(+)}` と `V^{(+)}` の実行列性。004/010 章が未形式化）、
`tr(εV^{(+)}) > 0`（章 018 の `closing_004`–`006` が未形式化）、`W` の成分正値性と `ε` 可換性
（章 010 依存）。`hZ1` / `hZ2` は章 011 の `partition_function_sandwich` で章 018 の仮定ではない。

検証: `lake build` 成功、`./scripts/check-no-sorry.sh` exit 0（新規 28 宣言を targets へ追加）。
記録: `lean/docs/ch018-formalization.md` 6 章、
`docs/tasks/2026-07_lean-ch009-013/017_ch018-connecting-ch014-017.md`。

## 完了（2026-07-27）: **章 020 の Lean 形式化**（臨界点と比熱の対数発散）

`structured-latex/content/020_critical_point.ts` の 11 ブロックを Lean 4 で形式化した
（具体版 `lean/Ising2D/Part020/` の 8 ファイル、抽象版 `lean/Ising2D/Abstract/` の
`HyperbolicBounds` / `MeanValueTwoSided` / `LogDivergentIntegral` / `DiffUnderIntegral`。
合計 169 宣言、`sorry` ゼロ）。到達点は
`Ising2D.second_derivative_log_divergence`（`|G''(κ) - (1/2π)log(1/|κ|)| ≤ 6/5`）。

**この章は本プロジェクトで実数解析へ最も深く踏み込む章である。** 原文が新たに持ち込むと
宣言している (R3)〜(R6) のうち、**(R5)（積分記号下の微分）だけが mathlib に
「連続性だけを仮定した形」で存在しない**。優関数版から `Abstract/DiffUnderIntegral.lean` で導いた。

抽象版で判明した本質:
- 対数発散に **`sin` は効いていない**。分母 `w` について `c₀(aθ) ≤ w ≤ aθ` と
  `aθ - w ≤ Cθ³` の 2 つの各点評価だけで発散の形が決まる。原文の定数
  `B = π²/(12c₀(1+c₀))` は抽象版の一般形に `a=1/2, b=π, C=1/48` を入れたものと厳密に一致。
- `κ(K)` の増分評価に**積分は効いておらず**、凸性＋導関数の両側評価（平均値の定理）で足りる。
- `cosh/sinh/arsinh` の初等評価で mathlib に無いのは `sinh t ≤ t cosh t` の 1 本だけ。

**原文が外から持ち込むと宣言している初等関数の数値評価（`cosh 0.2 ≤ 1.02007` 等）は
一切使わず**、`cosh t ≤ (1-t²/2)⁻¹` と `π` の評価だけから導いた。途中の定数はわずかに
悪くなるが（`κ'∈[3.52,4.74]`、`|κ''|≤9.3` 等）、**結論の `6/5` は原文のまま成立する**。

**未形式化**: `remark_physical_specific_heat`（物理量との辞書で数学的主張ではない）のみ。

## 完了（2026-07-27）: **章 020 の到達点 `specific_heat_log_divergence` の Lean 形式化**

`lean/Ising2D/Part020/Theorem012_SpecificHeatLogDivergence.lean`（新規、`sorry` ゼロ）。

**橋渡しには追加の仮定が要らなかった。** 章 012・018 の自由エネルギーの積分項
`(1/4π)∫_0^{2π} γ_P(θ)dθ` は、等方な場合 `P = isoParam K` に `isotropic_A_equals_one`
（`Ising2D.gammaFn_isoParam`）を展開すると `Ising2D.gammaK θ (kappaK K)` と**定義的に等しく**、
そのまま `Ising2D.Gfun (kappaK K)` になる（`Ising2D.gammaFn_isoParam_eq_gammaK` は `rfl`）。
これで `Ising2D.fFun K := (1/2)log(2 sinh 2K) + Gfun (kappaK K)` が
Onsager の自由エネルギーそのものであることが言える
（`Ising2D.onsager_exact_solution_isoParam`。仮定は `onsager_exact_solution` と同じ 3 つだけ）。

到達点 `Ising2D.specific_heat_log_divergence` が仮定するのは **`K ∈ Dnbhd`（`= [K_c-1/10,
K_c+1/10]`）と `K ≠ K_c` の 2 つだけ**で、原文の `0 < |K-K_c| ≤ 1/10` そのもの。
`d²f/dK²` は `deriv (deriv fFun)`。`K_c` では `κ = 0` で `G` の微分が使えないため、
`K ≠ K_c` の近傍で `deriv fFun = fFirst` を示してから 2 階微分へ渡している
（`Ising2D.eventually_hasDerivAt_fFun` → `hasDerivAt_deriv_fFun`）。

原文 Step 7（`|d²f/dK² - (8/π)log(1/|K-K_c|)| ≤ 49`）と Step 8
（`lim_{K→K_c} (d²f/dK²)/log(1/|K-K_c|) = 8/π`）も形式化した
（`specific_heat_log_divergence_dist` / `specific_heat_ratio_tendsto`）。
ここでも外部の数値は持ち込まず、`log 4.74 ≤ 1.5636` を `log 2` と `log y ≤ y-1` から導いた。
各段の定数は原文よりわずかに悪い（合計 `43.34`、原文 `42.94`）が、
**結論の `45` と `49` は原文のまま成立する**。

**人手証明に数学的な誤りは見つからなかった。** 記録は
`lean/docs/ch020-formalization.md` と
`docs/tasks/2026-07_lean-ch009-013/016_ch020-formalization-findings.md`。
## 完了（2026-07-27）: **章 016 の Lean 形式化**（偶セクターのフェルミオンと `V^{(+)} = c V̌'`）

`structured-latex/content/016_even_sector_fermions.ts`（9 主張）を Lean 4 で形式化した。
新規: 具体版 `lean/Ising2D/Part016/`（9 ファイル）、抽象版
`lean/Ising2D/Abstract/FermionLadder.lean`・`lean/Ising2D/Abstract/ExpEigenvector.lean`。
定理一覧・2 本立ての対応・残る仮定は **`lean/docs/ch016-formalization.md`** に記載
（`lean/README.md` への統合は未了）。`lake build` 成功、`scripts/check-no-sorry.sh` exit 0。

要点:

- **008 章の抽象版 CAR（`Ising2D.Abstract.car_of_coeffs`）は半整数運動量でもそのまま使えた。**
  対の条件が `μ+ν ≡ 0` から `ν = M+1-μ` へ変わっても、抽象版の仮定
  （反交換子がスカラー倍の `1`／係数のスカラー恒等式 2 本）は変わらない。
- **章の結論 `V_plus_eq_c_check_Vprime` まで到達**（`Ising2D.VPlus_eq_smul_checkVprime`）。
  `T_V_plus_eq_T_check_Vprime` / `V_plus_eq_c_check_Vprime` は `V^{(+)}` の定義に依存せず、
  「`Ž, Y̌` 上で一致する共役は全体で一致」「共役が一致する可逆元はスカラー倍を除いて等しい」
  として無条件に証明した。
- **原文に穴は無かった。** 008 章で問題になった「平方根の分枝の一致」は、半整数運動量では
  係数が `r_μ = |γ_2(θ̃_μ)|`（非負実数）なので生じない。原文 Step 1 の主張どおりであることを
  機械的に確認し `docs/tasks/2026-07_lean-ch009-013/010_ch016_no_sqrt_branch_gap.md` に記録した。
- **015 章由来の仮定はすべて解消済み。** 015 章がマージされたので
  `Part016/Claim010_UnconditionalViaPart015.lean` で `γ_2(θ̃_μ) ≠ 0`・`λ_± = e^{±γ}`・
  重み `γ(θ̃_μ)` とその共役不変性を代入し、無条件版
  `Ising2D.VPlus_eq_smul_checkVprime'` まで到達した。
  併せて、`ψ̌^†, ψ̌` の定義（原文が「すなわち」で与える明示式を採用）が
  015 章の `P̌_μ` の列と一致することを `checkPsiDag_eq_checkPmat_col` /
  `checkPsi_eq_checkPmat_col` で確認した。
- **014 章由来の仮定 `hT` も解消済み**（014 章もマージされたため）。
  `Ising2D.TVPlus_actsBy_checkZY` で埋め、完全な無条件版
  `Ising2D.VPlus_eq_smul_checkVprime_of_dual` に到達した。
- **残る仮定は双対関係 `c_2 s_2^* = c_2^*` の 1 つだけ**
  （008 章以来 `det A(θ) = 1` に数学的に必要な前提で、穴ではない）。
- 付随修正: `lean/scripts/check-no-sorry.sh` が固定パス `/tmp/ising2d_axiom_check.lean` を
  使っていたため、**複数 worktree で同時実行すると互いに上書きし、別ブランチの定理一覧を
  検査して誤検出していた**（実際に踏んだ）。`mktemp` へ変更済み。

## 完了（2026-07-27）: **章 018 の Lean 形式化**（偶セクターの完結 = Onsager の厳密解）

`structured-latex/content/018_even_sector_closing.ts`（12 ブロック）を Lean 4 で形式化した
（具体版 `lean/Ising2D/Part018/` 8 ファイル、抽象版 `lean/Ising2D/Abstract/ParityFermion.lean`）。
**本プロジェクトの結論 `Ising2D.onsager_exact_solution` が Lean 側に立った。**

主な定理（人手証明のラベル → Lean）:

- `epsilon_anticommutes_with_check_Z_Y` → `epsilon_anticomm_checkZ` / `checkY` /
  `epsilon_anticomm_of_isCheckMode` / `CheckFermi.commute_epsilon_nOp` / `commute_epsilon_Qproj`
- `epsilon_eigenvalue_on_check_Q` → `CheckFermi.eta` / `eta_insert` / `eta_eq_eta_univ_mul` /
  `epsilon_eq_parityProd`
- `trace_of_epsilon_V_plus_via_check_eigenvalues` → `VPlusData.trace_epsilon_mul_V`
- `check_number_operator_is_hermitian` → `checkZ_conjTranspose` / `CheckFermi.Qproj_conjTranspose`
- `max_eigenvector_in_even_sector` → `VPlusData.mem_evenSector_of_mem_range_univ`
- `c_plus_equals_Lambda_half_integer` → `EvenSectorBridge.c_plus_equals_lamMax`
- **`onsager_exact_solution` → `Ising2D.onsager_exact_solution`**

仮定として受け取ったもの（Lean 側に該当章が無いため。人手証明の穴ではない）:

- 章 016 の `ψ̌` の CAR とエルミート性 → 構造 `Ising2D.CheckFermi`
- 章 015・017 の `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε` → 構造 `Ising2D.VPlusData`
- 章 011・017 の `W P^{(+)} = V^{(+)} P^{(+)}` → 構造 `Ising2D.EvenSectorBridge`
- `tr(εV^{(+)}) > 0`（`closing_006`。配置基底での直接計算 `closing_004`/`005` を要する独立の枝）

**人手証明に誤りは見つからなかった。** 抽象版で判明したのは「符号の反転則 (2) に
`im Q̌_ε` の 1 次元性は要らない（要るのは `η_ε` の存在 (1) だけ）」など、
仮定が必要以上に強い箇所のみ。`structured-latex/` は編集していない。

Onsager の最終定理は、人手証明の粗い挟み撃ち（Step 2・3）を使わず、章 019 の
`c_equals_c_plus`（無条件）経由で `c(M) = c_+(M) = Λ^{(1/2)}_M` を直接出している（結論は同じ）。

記録: `lean/docs/ch018-formalization.md`（定理一覧・2 本立て対応表・未形式化の理由）、
`docs/tasks/2026-07_lean-ch009-013/015_ch018-formalization-findings.md`。
検証: `lake build` 成功、`./scripts/check-no-sorry.sh` exit 0（106 定理を追加）。
## 完了（2026-07-27）: **章 017 の Lean 形式化**（定数 `c` の決定と `V^{(+)}` の固有値）

`structured-latex/content/017_even_sector_eigenvalues.ts`（11 主張）を Lean 4 で形式化した
（具体版 `lean/Ising2D/Part017/`、抽象版 `lean/Ising2D/Abstract/` の
`PairedFermion.lean` / `ConstantC.lean` / `SimpleEigenvalue.lean`。
`sorry` ゼロ、`lake build` 成功、`scripts/check-no-sorry.sh` exit 0）。

**11 主張すべて形式化済み。結論を覆す誤りは見つからなかった。**

到達点: **最大固有値 `Λ̌_max = Λ^{(1/2)}_M` の単純性**（`Ising2D.checkBigLambda_univ_eq_LambdaM`,
`checkBigLambda_lt_max_of_gammaFn`, `eq_Qproj_univ_mulVec_of_eigen`,
`finrank_range_Qproj_univ`）と **`c = (2 sinh 2K_2)^{M/2}`**
（`Ising2D.constant_c_value_even_sector`）。

抽象版で判明した本質:
- **章 009（整数運動量）と章 017（半整数運動量）は同じ抽象版の別の特殊化**で、違いは
  対をなす添字を与える写像 `σ` だけ（009 は `σ(μ)=-μ`、017 は `σ(μ)=M+1-μ`）。
  しかも効いているのは **`σ` の単射性だけ**（`Abstract.acomm_cre_ann_comp`）。
- **`c` の決定に行列もトレースも指数関数も効いていない**。ℂ の 4 つの等式と正値性だけ
  （`Abstract.const_eq_of_trace_ratio`）。章 009 の `constant_c_value` も同じ補題の特殊化。
- **単純性 (3) に直和分解 (5) は不要**。`∑_ε Q̌_ε = 1` と左からの固有関係だけで足りる
  （`Abstract.eq_proj_of_eigen`）。
- 単純性を可能にしているのは `γ(θ~_μ) > 0`（狭義）1 点で、これは
  `0 < θ~_μ < 2π` ⇒ `cos θ~_μ < 1` から**無条件に**出る（`Ising2D.gammaFn_thetaTilde_pos`）。
  章 009 は `γ(θ_μ) ≥ 0` しか持てず単純性を言えない。
- 半整数運動量では添字集合が `𝓜̌ = {1,…,M}` に確定するため、章 009 の `FermiSetup` が
  仮定として受け取っていた添字集合（`I`, `hIlow`, `hIhigh`, `hgam`）が `CheckFermiSetup` から消え、
  `tr(Q̌_ε) = 1`・`tr(V̌')` の前因子 `2^{M-m}` の消滅が従う。

未形式化: 章 015 の `anticommutator_of_check_psi` と章 016 の `V_plus_eq_c_check_Vprime` は
仮定として受け取っている（並行して形式化中のため）。「対角化可能」の
`DirectSum.IsInternal` 形は章 009 と同じ理由で未形式化（固有値と重複度そのものは形式化済み）。

記録: `lean/docs/ch017-formalization.md`（定理一覧・2 本立て対応表・未形式化の理由）、
`docs/tasks/2026-07_lean-ch009-013/004_ch017_冗長な手順と暗黙の前提.md`（本文への指摘 3 件）。

なお章 015 側にも `Ising2D.one_lt_gamma1R_thetaTilde` があり名前が衝突したため、
章 017 側は `one_lt_gamma1R_thetaTilde_checkIndex` へ改名した（仮定が異なる別定理:
章 015 版は双対関係 `hdual` を要求し全 `μ` で成立、章 017 版は `hdual` 不要で `μ ∈ 𝓜̌` に限る）。
`V^{(+)}` は章 014 の `Ising2D.VPlus`（`Part014/Definition001_VPlus.lean`）を再利用し、
章 009 の `Vmat M K1 (-1) s2 K2star` と `rfl` で一致することを `Ising2D.VPlus_eq_Vmat` で明示した。

## 完了（2026-07-27）: **章 014 の Lean 形式化**（偶セクターでの `T` の作用）

`structured-latex/content/014_even_sector_T_action.ts`（10 主張）を Lean 4 で形式化した
（具体版 `lean/Ising2D/Part014/` の 8 ファイル、抽象版 `lean/Ising2D/Abstract/TVActionSandwich.lean`。
`sorry` ゼロ、`lake build` 成功、`scripts/check-no-sorry.sh` exit 0）。

到達点: **章の結論 `Ising2D.TVPlus_checkZ_checkY`**
（`(T_{(V^{(+)})}(Ž_μ), T_{(V^{(+)})}(Y̌_μ)) = (Ž_μ, Y̌_μ) A(θ~_μ)`）。
未形式化の主張は無い。残る仮定は 008 章と同じ 2 つ（`IsingConst` の 5 成分が双曲線関数であること、
双対関係の帰結 `s_2^* c_2 = c_2^*`）で、いずれも数学的に必要な前提。

抽象版で判明した本質: **008 章（整数運動量）と本章（半整数運動量）は同じ抽象版の別の特殊化**であり、
違いは `ad X` が `span{z, y}` に及ぼす係数の位相因子だけ。`αβ = s^2` の検証に使うのは
`e^{-iθ}e^{iθ} = 1` と `i^2 = -1` の 2 つだけで、`θ` が `2πμ/M` か `2π(μ-1/2)/M` かは効いていない。
`Ising2D.TV_hatZ_hatY_via_sandwich` で 008 章の結論を本章の抽象版から導き直して確認した。
新規の抽象版は `Abstract.actsBy_sandwich` 1 本だけ（原文が線型性と `calc_of_TxT` の 4 段往復で
行っている合成は「線型写像の合成 ↔ 行列の積」の 1 点に集約され、ℂ 上の任意の加群で成り立つ）。

人手証明の誤り・穴: **無し**（係数まで原文どおりに形式化できた）。むしろ 008 章で欠けていた
双対関係の明示と `(V_1^{(±)})^{1/2}` の定義が、本章では補われている。

記録: `lean/docs/ch014-formalization.md`（定理一覧・2 本立て対応表・本質・仮定）、
`docs/tasks/2026-07_lean-ch009-013/015_ch014-formalization-findings.md`（本文への指摘。
`μ ∈ 𝓜̌` の仮定が必要以上に強いこと、008 章の既知の 2 つの穴が本章では埋まっていること）。

## 完了（2026-07-27）: **章 015 の Lean 形式化**（半整数運動量における `A(θ~)` の対角化）

`structured-latex/content/015_A_theta_tilde_diagonalization.ts`（9 主張）を Lean 4 で形式化した
（具体版 `lean/Ising2D/Part015/`、抽象版 `lean/Ising2D/Abstract/` の
`OddModePhase.lean` / `NegConjPair.lean` / `TwoByTwoSkew.lean` / `GammaDetIdentity.lean` /
`ArcoshExp.lean`。`sorry` ゼロ、`lake build` 成功、`scripts/check-no-sorry.sh` exit 0）。

**9 主張すべて形式化済み。人手証明の誤り・穴は見つからなかった。**

到達点（本章の最大の価値）: **`Ising2D.gamma2_thetaTilde_ne_zero`（`γ_2(θ~_μ) ≠ 0`）を無条件で証明**した。
これにより整数運動量にあった臨界点の例外処理（`μ = ±M` の除外）が偶セクターでは不要になることが
機械的に確定し、`γ_1(θ~_μ) > 1`（狭義）→ `γ(θ~_μ) > 0` → `λ_+ > 1 > λ_- > 0`（固有値は必ず分離）
まで一本道で閉じた（`Ising2D.one_lt_gamma1R_thetaTilde` / `gammaTilde_pos` / `lambda_separation`）。

`A(θ)` は `θ ∈ ℝ` の主張なので、固有ベクトル・対角化・行列式は
008 章の既存定理（`AMat_mulVec_eigen` / `AMat_mul_Pmat` / `det_AMat_eq_one`）に
`θ := θ~_μ` を代入するだけで得られ、再証明していない。

抽象版で判明した本質:
- 例外が消える理由は **`M θ~_μ = (2μ-1)π` が `π` の奇数倍**という 1 点に還元される
  （整数運動量は `2μ·π` で偶数倍）。
- `relation_of_gamma_2_theta_tilde` の (1)〜(5) に効いているのは `w = -conj z` の 1 本だけ。
  人手証明の `arg^{[0,2π)}` 分岐つき複素平方根は、「2 乗が何か」だけを述べれば完全に消える。
- 固有値・対角化に効いているのは「対角成分が等しい `!![g,a;-b,g]` の形」と
  「`s^2 = -(ab)` の `s` が取れること」だけで、**係数は任意の可換環でよい**。
- `det A = 1` は可換環の多項式恒等式（4 本の関係式だけ）。008 章と同じく双対関係
  `c_2 s_2^* = c_2^*` が必須で、`hdual` として明示（数学的に必要な仮定であり形式化の穴ではない）。

記録: `lean/docs/ch015-formalization.md`（定理一覧・2 本立て対応表・形式化の形が人手証明と異なる 2 点）。
なお `gamma_2_theta_tilde_nonzero` は本文が `μ ∈ 𝓜̌` に限って述べているが、
Lean の証明は `μ ∈ ℤ` 全体で通る（仮定が必要以上に強いだけで、誤りではない）。

## 完了（2026-07-27）: **章 019 の Lean 形式化**（最大固有値が偶セクターから来ることの確定）

`structured-latex/content/019_max_eigenvalue_sector.ts`（6 ブロック）を Lean 4 で形式化した
（具体版 `lean/Ising2D/Part019/`、抽象版 `lean/Ising2D/Abstract/PermSector.lean`。
`sorry` ゼロ、`lake build` 成功、`scripts/check-no-sorry.sh` exit 0）。

到達点: **`Ising2D.c_equals_c_plus`（`c(M) = c_+(M)`）を無条件で証明**した。
経路は `Ising2D.c_minus_le_c_plus`（`c_-(M) ≤ c_+(M)`）＋章 011 の
`sector_decomposition_of_rayleigh_sup`。ε を実行列 `Ising2D.epsilonR M`（符号反転の置換行列）
として置き、複素の `Ising2D.epsilon M` と成分が一致することを `epsilon_eq_ofReal_epsilonR` で証明。
Perron–Frobenius 系の補題・スペクトル定理は使わず、成分ごとの三角不等式だけで書いた。

未形式化（仮定として受け取った）:
- `c_+(M) = Λ^{(1/2)}_M`（章 018 の `c_plus_equals_Lambda_half_integer`。Lean 側に無い）
  → `c_equals_c_plus` の Step 2・Step 3 は条件つきの定理にした。
- `ε W = W ε`（複素 `V_1,V_2` と章 011 の実行列 `W` を結ぶ橋渡しが未形式化。章 011 と同じ扱い）。

抽象版で判明した本質: 効いているのは「`ε` が対合 `π` の置換行列であること」
「`W` の成分が**非負**であること」「`W` が実対称半正定値であること」の 3 つだけ。
**本文 `epsilon_is_sign_flip_permutation` (2) の「`π` は不動点をもたない」は
`c_- ≤ c_+` には効いていない**（効くのは `𝓡_- ≠ ∅` の部分だけ）。
また本文が引く `W_{kl} > 0` の狭義正値性も不要（`0 ≤ W_{kl}` で足りる）。

記録: `lean/docs/ch019-formalization.md`（定理一覧・2 本立て対応表）、
`docs/tasks/2026-07_lean-ch009-013/013_ch019-formalization-findings.md`（本文への指摘）。
なお本章の (4) は、章 011 の既知の穴（`002_ch011-sector-sup-nonempty-gap.md` の
「`𝓕^{(±)}` に単位ベクトルがあることが本文に無い」）の `𝓕^{(-)}` 側を埋めている。

## 完了（2026-07-27）: **章 009 の Lean 形式化**（V の固有値・定数 c の決定）

`structured-latex/content/009_eigenvalues_of_V.ts`（19 ブロック）を Lean 4 で形式化した
（`lean/Ising2D/Part009/` に具体版、`lean/Ising2D/Abstract/{NumberOperator,JointEigenspace}.lean`
に抽象版。`sorry` ゼロ、`scripts/check-no-sorry.sh` exit 0）。

到達点: `Ising2D.constant_c_value`（`c = (2 sinh 2K_2)^{M/2}`）と
`Ising2D.Vmat_mul_Qproj`（`V Q_ε = Λ_ε Q_ε`）まで到達。

- 一覧・2 本立ての対応・抽象版で判明した本質は `lean/docs/ch009-formalization.md`
  （`lean/README.md` への統合は未了）。
- **仮定として受け取ったもの**（いずれも他章の内容、または既知の原文の穴）:
  008 章 `V_eq_Vprime`（`V = cV'`）、`γ(θ_μ) = arccosh(γ_1(θ_μ))`（mathlib に `Real.arccosh`
  が無い。非負実数の族として受け取る）、`𝓘` の同定、`ψ` の平方根の分枝の整合。
  すべて `Ising2D.FermiSetup` と `constant_c_value` の仮定に明示。
- **原文の穴 3 件**を `docs/tasks/2026-07_lean-ch009-013/003_ch009_未定義記号と暗黙の仮定.md`
  に記録（未定義記号 `𝓜` の使用 / 分枝の整合への未言及 / 逆元の一意性への未言及）。
  いずれも結論を覆さない。
- **形式化して分かった冗長**: `sign_flip_conjugation` の `M` の偶奇による場合分けと `G` への
  書き換えは不要（`U Z_m U^{-1} = -Z_m`, `U Y_m U^{-1} = +Y_m` が `m` によらず成り立つ）。
  `joint_eigenspace_decomposition` (4) の二項定理も不要。
- 抽象版で判明した本質: 個数演算子の冪等性・可換性に効いているのは
  **環・CAR・2-捩れの無さの 3 つだけ**。同時固有空間分解 (1)(2)(3) は
  **可換な冪等元の族**だけで従い CAR すら要らない。トレースの計算に効いているのは
  **「加法的かつ巡回的な汎関数」1 つだけ**（値域は任意の可換群でよい）。

## 完了（2026-07-27）: **章 010 の Lean 形式化**（分配関数 → Pauli 表示 → 偶奇セクター分解）

`structured-latex/content/010_transfer_matrix_bridge.ts` の主張をすべて Lean 4 で形式化した
（`lean/Ising2D/Part010/` に具体版、`lean/Ising2D/Abstract/` に抽象版。`sorry` ゼロ）。
あわせて **001 章の分配関数 `Z(J,J')` の定義と `Z = tr((V_1V_2)^{N_row})`** も新規に形式化した
（Lean 側にこれまで分配関数そのものが無かった）。

到達点: `Ising2D.partition_function_in_pauli_form` により、
分配関数から Pauli 表示の転送行列のトレースまでが**無条件に**つながった。

- 一覧・2 本立ての対応・抽象版で判明した本質は `lean/docs/ch010-formalization.md`
  （`lean/README.md` への統合は未了）。
- **条件つき**: `sector_replacement_of_V1` と偶奇セクター分解の最終式は、
  004 章 `V1_restriction_to_eigenspaces`（Lean 未形式化）を仮定 `RestrictsOnSector` として
  受け取る形。次にこれを形式化すれば無条件になる。
  詳細は `docs/tasks/2026-07_lean-ch009-013/001_*.md`。
- 抽象版の新規ファイル: `Abstract/SiteDiagonal.lean`, `Abstract/ExpDiagonal.lean`,
  `Abstract/Projector.lean`, `Abstract/TracePathSum.lean`
  （最後のものは「`tr(A^{n+1})` は閉じた道の重みの総和」。mathlib に無いので自前で証明した）。

## 完了（2026-07-27）: **章 E — 臨界点で比熱が対数発散することを本文で証明**

`structured-latex/content/020_critical_point.ts`（14 ブロック）で、018 章の
`onsager_exact_solution` を出発点に、等方な場合 `K_1 = K_2 = K` の比熱の対数発散を
**定数を具体的に与えた両側評価**として証明した（`specific_heat_log_divergence`）。

```
| f''(K) − (8/π) log(1/|K − K_c|) | ≤ 49   (0 < |K − K_c| ≤ 1/10),  sinh 2K_c = 1
lim_{K→K_c} f''(K) / log(1/|K−K_c|) = 8/π,   C = k_B K² f''(K)
```

鍵は 1 つの恒等式 `sinh²(γ(θ)/2) = sinh²(κ/2) + A sin²(θ/2)`（`κ := 2K_1 − 2K_2^*`、
`A := sinh 2K_1 sinh 2K_2^*`、`gamma_kappa_identity`）と、**等方なら `A = 1`**
（`isotropic_A_equals_one`）という事実。臨界条件は `κ = 0` と同値
（`critical_point_iff_kappa_zero`、008 章の `c_1 = s_1c_2` とも同値）。

- 実数解析への追加の移行は `remark_real_analysis_escape_chapter_E` に (R3)〜(R6) として列挙
  （積分の線型性・単調性 / 微分積分学の基本定理 / Leibniz / 置換積分）。
  012 章の「本証明で唯一」という表現 2 箇所を「表式を得るまでに唯一」へ直し、章 E への案内を
  1 段落追記した（**既存章への変更はこの 3 箇所だけ**）。
- 数値検証は `sagemath/check/055_claim_critical_point/`（5 チェック全 PASS、`mpmath` dps=40）。
  **本文の誤り 1 件（`cosh κ − 1` を `2 sinh²(κ/4)` と誤評価）をこの検証が検出した。**
- **非等方な場合への一般化は未了**（等方を確実に閉じる方を優先）。詳細と残作業は
  `docs/tasks/free-energy-roadmap/task-dependency-graph.md` の「章 E」節。

## 完了（2026-07-27）: `c(M) = c_+(M)` を本文で確定させた（019 章、6 ブロック）

`structured-latex/content/019_max_eigenvalue_sector.ts` で

```
c_−(M) ≤ c_+(M),   したがって   c(M) = c_+(M) = Λ^{(1/2)}_M
```

を本文の定理にした。**自由エネルギーの表式には不要**（018 章の粗い挟み撃ちで足りる）だが、
「`W` の最大固有値は偶セクター `F^{(+)}` から来る」という描像を本文で確定させる。

### 証明の要（1 行で言える）

`x ∈ F^{(-)} ∩ R^{2^M}` は `εx = −x`。`ε` は**全スピン反転に対応する `0/1` の置換行列**で、
その置換 `π` は不動点をもたない対合だから、成分では `x_{π(k)} = −x_k`。したがって
`u_k := |x_k|` は `u_{π(k)} = |−x_k| = u_k`、すなわち **`εu = u` で偶セクターへ移る**。
`W` の成分がすべて正（011 章 `W_has_positive_entries`）なので三角不等式から
`u^T W u = Σ|x_k x_l W_{kl}| ≥ |Σ x_k x_l W_{kl}| = |x^T W x| ≥ x^T W x`。
よって `c_+(M) ≥ u^T W u ≥ x^T W x`、上限を取って `c_+(M) ≥ c_−(M)`。

Perron–Frobenius の「最大固有ベクトルは符号をそろえて取れる」の部分だけを**上限（sup）の言葉で**
取り出した形になっている。対角化可能性・スペクトル定理・コンパクト性は使っていない（011 章と同じ方針）。

### 懸念だった「上限の達成」は問題にならなかった

過去の MEMORY は「上限の達成（コンパクト性）を初等的にどう扱うかを先に決める必要がある」と
していたが、**不要だった**。`c(M) = max(c_+, c_−) = c_+` を出すのに上限の達成は要らず、
達成が言いたければ `c_plus_equals_Lambda_half_integer` の証明が既に構成している
実固有ベクトル `x_0 ∈ F^{(+)} ∩ R^{2^M}` をそのまま使えばよい。

### 018 章は意図的に触っていない

`onsager_exact_solution` の Step 3 は `c(M) ≤ 2Λ^{(1/2)}_M` の粗い評価のままにしてある。
`onsager_exact_solution` は文書順で 019 章より**前**なので、そこで `c_equals_c_plus` を引くと
参照の逆流（章の粒度では循環）になるため。係数 `2` は `(log 2)/M → 0` で消えるので表式に影響しない。
この判断は 019 章の `sector_005_remark_sandwich_becomes_equality` に本文として書いてある。

### `c_−(M)` の値には立ち入らない（一次情報で確認済み）

`c_−(M) = Λ^{(0)}_M` は一般には成り立たない。高温側 `(K_1,K_2) = (0.05, 0.1)` では
`M = 2,3,4,5` のすべてで `c_−(M)/Λ^{(0)}_M = 0.1101501691`。019 章が示すのは不等号だけで、
それには `c_−(M)` の値は要らない。

### 新設ラベル（019 章）

`epsilon_is_sign_flip_permutation` / `abs_vector_moves_to_even_sector` /
`c_minus_le_c_plus` / `c_equals_c_plus`

### 数値検証

`sagemath/check/054_claim_max_eigenvalue_sector/`（4 チェック、全 PASS、`M = 2,3,4,5`、
臨界点・臨界点近傍・高温側を含む 6 組の `(K_1,K_2)`）。`c(M) = c_+(M) = Λ^{(1/2)}_M` の
相対差 `≤ 2.0e-15`。24 ケースすべてで真の不等号 `c_−(M) < c_+(M)`（比 `0.110`〜`0.991`）。
`&=` 19 ステップに対し `∵` 24 件。

## 完了（2026-07-27）: 012 章「自由エネルギーと熱力学極限」を Lean で形式化した

`lean/Ising2D/Part012/`（具体版 5 ファイル）と `lean/Ising2D/Abstract/`（抽象版 4 ファイル）を
新規に追加し、012 章の 5 つの主張（`gamma1_lower_bound_all_theta`, `gamma_is_continuous`,
`limit_of_log_Z_in_N_row`, `riemann_sum_to_integral`, `onsager_free_energy_expression`）を
`sorry` ゼロで形式化した。`lake build` 成功、`scripts/check-no-sorry.sh` は exit 0。
一覧表・2 本立ての対応・「抽象版で判明した本質」は **`lean/docs/ch012-formalization.md`**
（`lean/README.md` への統合は未実施）。

要点:

- **★実数解析への移行点 `riemann_sum_to_integral` は mathlib に無いので自前で証明した。**
  `Riemann sum` 系の定理は mathlib に存在しない（grep で確認）。人手証明が (R1)(R2) として
  挙げた外部事実（Heine–Cantor・連続関数の可積分性/区間加法性/評価/定数の積分）は
  すべて mathlib にあり、新たな公理は要らなかった。
- **`Real.arcosh` は mathlib にある。** `lean/README.md` の「mathlib に無い（自前定義が必要）」は
  現行 mathlib（`v4.32.1`）では誤り。綴りが `arccosh` ではなく `arcosh`。
  定義も人手証明 Step 2 の明示式と同一で、`Real.cosh_arcosh` / `Real.continuousOn_arcosh` もある。
- **抽象版で判明: `riemann_sum_to_integral` に `g` の周期性はまったく効いていない。**
  区間も `[0,2π]` である必要がなく任意の `[a,b]` でよい。`δ ∈ [0,1)` の右端も閉じてよい
  （`δ ∈ [0,1]`）。したがって「整数運動量と半整数運動量で極限が同じ」は
  「代表点が小区間の中なら何でもよい」というより強い事実の特殊例である。
- **抽象版で判明: `limit_of_log_Z_in_N_row` に Ising 模型の構造は何も効いていない。**
  効くのは `c^N ≤ Z ≤ B c^N`（`c>0`, `B≥1`）と `log` の単調性・乗法から加法への変換だけ。
  `B = 2^M` という具体形すら効いていない。
- 011 章の入力（`partition_function_sandwich`, `def_rayleigh_sup`）は、別セッションが
  並行して 011 章を形式化中のため **import せず仮定として受け取った**。

**本文（`structured-latex/`）で見つかった点は
`docs/tasks/2026-07_lean-ch009-013/012_ch012-formalization-findings.md` に記録した**
（本文は編集していない）。要点は次の 3 つ:

1. `remark_real_analysis_escape_point` の「外部から持ち込む事実は (R1)(R2) の 2 つだけ」は
   不正確。`gamma_is_continuous` が `cos` / `√` / `log` の連続性という別の実数解析の事実を使う。
2. `onsager_free_energy_expression` は `Λ` を**集合** `Θ^{(δ)}_M` 上の和で定義しているのに、
   proof は断りなく添字つきの和 `Σ_{μ=1}^M` へ移っている（単射性の一行が無い。主張自体は正しい）。
3. `riemann_sum_to_integral` の周期性の仮定と `δ < 1` は不要（上記）。
## 完了（2026-07-27）: 章 011「最大固有値」の Lean 形式化（具体版＋抽象版の 2 本立て）

`lean/Ising2D/Part011/`（具体版 7 ファイル）と `lean/Ising2D/Abstract/PsdCauchySchwarz.lean`
`lean/Ising2D/Abstract/RayleighMoments.lean`（抽象版）を新設。`lake build` と
`./scripts/check-no-sorry.sh` はいずれも exit 0（`sorry` ゼロ）。

- 形式化した主張: `psd_cauchy_schwarz` / `def_rayleigh_sup` / `rayleigh_bounds_operator_norm` /
  `trace_power_sandwich` / `Z_equals_trace_of_W` / `def_symmetrized_transfer_matrix` /
  `W_is_real_symmetric_positive_definite` / `W_has_positive_entries` /
  `partition_function_sandwich` / `sector_decomposition_of_rayleigh_sup` の (1)(3)。
- **未形式化**: `sector_decomposition_of_rayleigh_sup` の (2)（`V^{(±)}` に依存し章 004/010 が必要）。
- 章 009/010 への依存（`Z = tr((V₁V₂)^{N_row})`、`V₂` の正値性・正定値性など）は
  import せず**仮定として受け取る**形にした。接続用の一般補題 `Ising2D.matExp_posDef`
  （実対称行列の `exp` は正定値）は用意済み。
- 一覧・2 本立ての対応表・「抽象版で判明した本質」は
  [lean/docs/ch011-formalization.md](lean/docs/ch011-formalization.md)。
- **人手証明に見つけた問題**（本文は未修正。修正は別セッション担当）:
  - `docs/tasks/2026-07_lean-ch009-013/001_ch011-moment-log-convexity-index-error.md`
    — Step 2 の対数凸性を導く `(a,b)` の指定が誤り（結論は正しい）。
  - `docs/tasks/2026-07_lean-ch009-013/002_ch011-sector-sup-nonempty-gap.md`
    — `c_±(M)` の `sup` が定義できること（`F^{(±)}` に単位ベクトルがあること）の根拠が本文に無い。

## 完了（2026-07-27）: **2 次元 Ising 模型の厳密解が本文で閉じた**（018 章、章 C′-16）

`structured-latex/content/018_even_sector_closing.ts`（11 ブロック）で `c_+(M) = Λ^{(1/2)}_M` を
証明し、`onsager_exact_solution` として

```
lim_{M→∞} lim_{N_row→∞} (1/(M N_row)) log Z = (1/2)log(2 sinh 2K_2) + (1/4π)∫_0^{2π} γ(θ)dθ
```

を本文の定理にした。012 章の `remark_remaining_input_even_sector` が挙げていた
「残っている入力」は解消済みで、同ブロックの「以降の証明の根拠として使ってはならない」の一文も
差し替えてある（最小限の書き換え。他の既存ブロックの記法は触っていない）。

### 難所は「上限」ではなく「下限」だった

`x ∈ F^{(+)}` なら `WP^{(+)} = V^{(+)}P^{(+)}` から `x^⊤Wx ≤ Λ̌_max` は容易。逆向きには
**`Λ̌_max` の固有ベクトルが `F^{(-)}` ではなく `F^{(+)}` に属すること**を示さねばならない。
`V^{(+)}` は `Mat(2^M,ℂ)` 全体の行列で、その `2^M` 個の固有値の**半分は `F^{(-)}` 側**の
固有ベクトルに対応するので、これは固有値 `Λ̌_ε` の値からは読み取れない。

### 証明の要（一次情報で確認した「本質」）

1. **`ε` は `ψ̌` と反可換、`ň_μ` とは可換**。`ε` が `Z_j, Y_j` と反可換であることは
   010 章 `epsilon_commutes_with_transfer_matrices` の Step 1（`εσ^x_k = σ^x_kε`、
   `εσ^{y,z}_k = −σ^{y,z}_kε`）から直ちに従う。`im Q̌_ε` が 1 次元なので `εQ̌_ε = η_ε Q̌_ε`
   （`η_ε = ±1`）で、`ψ̌_μ^†` が `ε_μ` を `0→1` に動かしつつ符号を反転させるので
   **`η_ε = η_{(1,…,1)}(−1)^{M−|ε|}`。未知の符号は 1 つだけに縮む。**
2. **その 1 つの符号は `tr(εV^{(+)})` の符号として読める**。
   `tr(εV^{(+)}) = η_{(1,…,1)}(2 sinh 2K_2)^{M/2} Π_μ 2 sinh(γ(θ~_μ)/2)` で、
   `γ(θ~_μ) > 0`（**半整数運動量に固有**。整数運動量では臨界点で `γ = 0` になりうるので
   この論法は使えない）より `η` 以外は正。
3. **`tr(εV^{(+)})` はフェルミオン化を経由せずに初等的に計算できる**。
   `iH_1^{(+)} = D_0 + εG`（`D_0 = Σ_{m<M}σ^z_mσ^z_{m+1}`、`G = σ^z_Mσ^z_1`）と
   `(εG)² = I` から `εV_1^{(+)} = exp(K_1D_0)(cosh K_1·ε + sinh K_1·G)` と分解でき、
   2 項がそれぞれ 1 次元開鎖の分配関数 `2(2cosh K_1)^{M−1}` と境界相関 `2(2 sinh K_1)^{M−1}` に
   対応する（`K_1 > 0` でどちらも正）。結果は
   **`tr(εV^{(+)}) = (2e^{−K_2}cosh K_1)^M + (2e^{K_2}sinh K_1)^M > 0`**。
4. したがって `η_{(1,…,1)} = +1`、**`ε = (−1)^M Π_μ(I − 2ň_μ)`**、
   `im Q̌_{(1,…,1)} ⊆ F^{(+)}`。`(−1)^M` が付くのは `ň_μ = ψ̌_μ^†ψ̌_{M+1−μ}` が
   同じモードの `ψ^†ψ` ではないため（真空側のパリティが `(−1)^M`）で、
   **最大固有ベクトル側は `M` の偶奇によらず `+1`**。

### 採らなかった経路（再検討する人向け）

`A_μ := I − 2ň_μ` を `Ž, Y̌` で書き下して直接 `ε` と突き合わせる経路も検討した。
`A_μ A_{M+1−μ}` は `(K_1,K_2)` に依存せず（数値で確認、残差 1e-15）、自己共役添字
（`M` 奇数、`μ = (M+1)/2`）では `A_μ = (−i/M)Ž_μY̌_μ` と閉じた形になる。しかし対の積を
`ε = i^M Z_1Y_1⋯Z_MY_M` と突き合わせるには実質「クリフォード代数のカイラリティが基底変換の
行列式で変わる」という一般論が要り、README のゴール設定に反するので採らなかった。

### `c_-(M)` に依存しない形にした（重要・一次情報で確認済み）

**`c_-(M) = Λ^{(0)}_M` は一般には成り立たない。** 数値では多くのパラメータで比が 1 だが、
**高温側 `(K_1,K_2) = (0.05,0.1)`（`sinh2K_1 sinh2K_2 ≈ 0.020`）では `c_-(M)/Λ^{(0)}_M = 0.1102`**
（`M = 2,3,4,5` すべて同じ比）。`V^{(-)}` の最大固有ベクトルが `F^{(+)}` 側に落ちる場合があるためで、
偶セクターで解いたのと同じ問題が奇セクターでは**別の答え**になりうる。
そこで `onsager_exact_solution` は `c_-(M)` に一切依存しない：`W` の成分の正値性だけから
`c(M) ≤ 2c_+(M)` を出す（`u := |x|` の成分絶対値、`v := u + εu ∈ F^{(+)}`）。
係数 2 は最良でない（数値では `c(M) = c_+(M)`、相対差 ≤ 1.9e-15）が `(1/M)log2 → 0` で消える。

### 新設ラベル（018章、ラベル付き13ブロック）

`epsilon_anticommutes_with_check_Z_Y` / `epsilon_eigenvalue_on_check_Q` /
`trace_of_epsilon_V_plus_via_check_eigenvalues` / `H1_plus_in_sigma_z_form` /
`def_open_chain_spin_energy` / `open_chain_partition_sum` / `open_chain_endpoint_product_sum` / `open_chain_spin_sums_positive` / `trace_of_epsilon_V_plus` / `max_eigenvector_in_even_sector` /
`check_number_operator_is_hermitian` / `c_plus_equals_Lambda_half_integer` /
`onsager_exact_solution`

### `&=` / `\because`

018: **102 / 103**（`\because` 注記が式変形ステップ数を上回る＝全ステップに注記あり）。

### 数値検証

新規 `sagemath/check/053_claim_even_sector_closing/`（5 チェック、全 PASS、`M = 2,3,4,5`、
`{0,1}^M` を全列挙、厳密な臨界点 2 組を含む 6 組の `(K_1,K_2)`）。
`c_+(M)` は `Λ̌_ε` を経由せず、`W` を `F^{(+)} ∩ ℝ^{2^M}` の実正規直交基底 `(e_k + e_{k̄})/√2` へ
制限した実対称行列の最大固有値として**直接**求めて比較している（相対差 ≤ 1.7e-15）。
熱力学極限は `M = 4,16,64,256,1024,4096` で対数のまま計算し、Onsager 積分と比較
（臨界点でも `M = 4096` で差 1.6e-8）。

### 次にやること

1. **章 E（臨界点）** — 自由エネルギーの `K` 依存性の特異性（比熱の対数発散）。
   `critical_condition_c1_eq_s1_c2` が土台。README 5 節の「読み物」素材でもある。
2. ~~**`c(M) = c_+(M)` の本文化**~~ — **完了（019 章。下記の節を参照）**。
3. **Lean の 2 本立て整備**（README 8 節）と**クロネッカー積記法への統一**（別セッション進行中）。
   013〜019 章の Lean 形式化は未着手。

## 完了（2026-07-27）: 章 C′（013〜017 章）の添字の量化範囲を `𝓜̌ = {1,…,M}` へ絞った

013〜017 章は `μ ∈ ℤ` で量化していた箇所が 37 個あった。008 章が
`𝓜 = {−M,…,−1,1,…,M}` という名前付きの有限集合で量化しているのに倣い、
**半整数運動量に必要な最小の有限集合** `𝓜̌ := {1,…,M}` を 013 章に定義して、
章 C′ のすべての主張をそこへ絞った。**主張の内容は変えていない**（弱くなった主張は無い）。

### 新設した 2 ブロック（013 章）

- `def_check_index_set`: `𝓜̌ := {1,…,M}` と 5 性質。(1) `θ~_μ` は相異なり `0 < θ~_μ < 2π`、
  (2) **共役の閉性** `μ ∈ 𝓜̌ ⟹ M+1−μ ∈ 𝓜̌`、(3) `1−μ ≡ M+1−μ (mod M)`、
  (4) **自己共役点**は `M` が奇数のときの `μ = (M+1)/2`（`θ~_μ = π`）だけ、
  (5) **対の判定** `μ+ν ≡ 1 (mod M) ⟺ ν = M+1−μ`、ゆえに `δ^M_{(μ+ν,1)} = δ_{ν,M+1−μ}`
- `conjugate_index_of_check_Z_Y`: `θ~_{M+1−μ} = 2π − θ~_μ`、
  `e^{−ijθ~_{M+1−μ}} = e^{ijθ~_μ}`、`Ž_{M+1−μ} = Ž_{1−μ}`。
  **共役添字を `1−μ` から `M+1−μ` へ書き換える正当性がここに集約されている。**

### 一次情報で確認した「本質」

- **`𝓜̌` はこれ以上減らせない。** `θ~_μ`（`μ = 1..M`）は `(0,2π)` 内の相異なる `M` 個で、
  `𝓜̌` から 1 点でも除くと `M` 個を尽くせない（数値では `M = 2..40` の全探索で確認）。
- **範囲を絞ると合同式が消える。** `μ,ν ∈ 𝓜̌` では `2 ≤ μ+ν ≤ 2M` なので `μ+ν−1` が `M` の
  倍数になるのは `μ+ν−1 = M` の場合だけである。これが `δ^M` を通常のクロネッカーのデルタへ
  落とせる理由であり、016 章の「`ν = (1−μ)+kM` なる `k` を取る」段・017 章の
  「2 つの合同式の書き換え」が消えた理由でもある。
- **`periodicity_of_check_fermi` から `ψ̌` が消えた。** 共役添字を `M+1−μ` にしたことで
  `𝓜̌` の外で `ψ̌` を評価する箇所が本文から無くなり、`ψ̌_{μ+kM} = ψ̌_μ` が不要になった。
  いまの内容は (1) `γ_1, γ_2` の `2π` 周期性（`θ ∈ ℝ`）、(2) 添字の `M` 周期性
  （`γ_1, γ_2` の値のみ）、(3) 共役添字 `M+1−μ` での関係。
- **`μ ∈ ℤ` で量化したまま残した主張は 2 つだけ**：`def_half_integer_modes` (2) と
  `periodicity_of_check_fermi` (2)。前者は `Ž_{M+1−μ} = Ž_{1−μ}` を導く橋渡し、
  後者は `γ_1, γ_2` が `θ ∈ ℝ` の関数であることで意味をもつ。
  `γ(θ~_μ)` と `ψ̌_μ` は **`𝓜̌` 上でしか定義していない**（ここが設計の要点。定義域を `ℤ` に
  してしまうと、その well-defined 性を `ℤ` 全体で述べる必要が生じて絞り込みが破れる）。

### `&=` / `\because`

013: 149/116 (78%)、014: 164/128 (78%)、015: 84/78 (93%)、016: 101/88 (87%)、
017: **56/54 (96%)**（作業前 49/30 = 61%）。017 章は注記が 6 割しか付いていなかったので補った。

### 数値検証

- 新規 `sagemath/check/052_def_check_index_set/`（2 チェック、全 PASS）。
- 既存 `046`〜`051` は範囲の変更に追随させて**再実行し `run-log.txt` を更新**（全 PASS）。
  `051` の段数は 013 章 92 → 105、016 章 58 → 62。

### 次にやること（2026-07-27 時点では解消済み）

当時の残作業は `c_+(M) = Λ̌_max` の接続だった。**018 章（章 C′-16）で完了している**
（このファイルの先頭の節を参照）。

## 完了（2026-07-26）: 章 C′（013〜016 章）を「1 ステップ 1 定理」の規約へ適合させた

### やったこと

`.claude/skills/math-prover/SKILL.md` の**「1 ステップ 1 定理の原則」と「定理適用の明示」**を
structured-latex の記法へ移して、013〜016 章の**証明の書き方**を直した。
**数学的内容は変えていない**（statement の内容・ラベル・ブロック id は 1 つも変えていない）。
やったのは 3 つだけ: (a) 潰れていたステップの分割、(b) 欠けていた定理参照の追加、(c) 暗黙の前提の明示。

`&=` の式変形ステップ数 / `\because` 注記数:

| 章 | 作業前 | 作業後 |
|---|---|---|
| 013 | 18 / 1 | 136 / 103 |
| 014 | 129 / 43 | 164 / 128 |
| 015 | 16 / **0** | 84 / 78 |
| 016 | 32 / 17 | 93 / 80 |

### structured-latex での規約（以後もこれに従う）

- 複数行の式変形は `displayMath` の `\begin{aligned} ... \\ ... \end{aligned}` で縦に並べ、
  **各行末に `\quad(\because \text{...})`**。本文の主張を適用した行はその**ラベル名**を書く
  （例: `\text{def\_half\_integer\_modes (3)}`。アンダースコアは `\_` でエスケープする）。
- **`\because` の中は素の文字列なので型検査に掛からない。** 同じ displayMath の直前か直後の段落に
  `ref("...")` を**必ず**張ること。両方やって初めて参照が機械検証される。
- 自明な操作（四則・分配法則・移項・有限和の添字の付け替え）は省略してよいが、
  **本文中の主張の適用は同じ証明に何度出てきても省略しない。**

### とくに直した箇所（他章を直すときの参考になる型）

1. **015 の `relation_of_gamma_2_theta_tilde`**（作業前の 015 章は `\because` が 0 件だった）。
   `conj(γ_2(θ))` の計算が 1 行に 5 つ以上の操作を潰していた。8 段に分割し、
   **`conj(e^{iθ}) = e^{−iθ}` が `θ ∈ R` を使っていること**を本文で明示した。
   「暗黙の前提の明示」が一番効いた例。
2. **013 の `H1_H2_via_check_Z_Y`**。定義の代入と `θ~_{1−μ} = −θ~_μ` の適用が同一行、
   「積を二重和へ分配」と「有限和の順序交換」も同一行で無注記だった。
3. **016 の `anticommutator_of_check_psi`**。反交換子の双線型性（本文中の主張）の適用が無注記。
4. **複素指数の指数法則 `e^{z}e^{w} = e^{z+w}` が全章で暗黙に使われていた。**
   `theorem_exp_product` は `Mat(n,K)`（`n ≥ 1`）で述べられているので、
   `n = 1`（`Mat(1,C) = C`）に適用したものだと明示して参照を張った。この形は今後も使える。

**新しい補題が要ると判明した箇所は無かった。** 分割の過程で本文に無い性質を暗黙に使っている箇所は
見つからず、既存のラベル付き主張だけで根拠を書き切れた。

### 数値検証（新規）

`sagemath/check/051_stepwise_identities_of_chapter_Cprime/`（4 チェック、全 PASS）。
**046〜049 が各ブロックの statement（結論）を検証するのに対し、050 は分割で本文に現れるように
なった中間式を 1 段ずつ検証する。** 013: 92 段 / 015: 66 段 / 014: 100 段 / 016: 58 段、合計 316 種類。
`Steps` クラスの `name` に本文の `\because` の中身をそのまま入れてあるので、
出力を読めば「どの段がどの定理に対応し、残差がいくつか」が 1 対 1 で追える。

数値的な注意: `check_03` の `(gh)^{-1} = h^{-1}g^{-1}` は `inverse()` の直接比較だと残差 4e-8 で
閾値を割る（`V_2` の前因子 `(2 s_2)^{M/2}` と `exp((i/2)K_1H_1)` で条件数が悪い）。
主張の内容そのもの、すなわち `(gh)(h^{-1}g^{-1}) = I` を検証する形に直してある。
**逆行列の等式は `inverse()` の比較でなく積が `I` になることで検証する**のが安全。

### 検証状況

`(cd structured-latex && npm run check)` / `npm run build:pdf`（209 ページ、未解決参照 0、
組めない文字 0、版面外 0）/ `node sagemath/tools/verify-check-linkage.ts`（107 check）すべて通過。

## 進行中（2026-07-26）: 章 C′ の C′-13・C′-14 完了 — `V^{(+)} = c·checkV'` まで到達

## 完了（2026-07-26）: 章 C′ の C′-15 完了 — `V^{(+)} の固有値`と `Λ̌_max = Λ^{(1/2)}_M` の単純性

### 到達点

`structured-latex/content/017_even_sector_eigenvalues.ts`（11 ブロック）で、009 章と同じ道筋を
半整数運動量で辿り、次まで到達した。**これで章 C′（C′-1〜C′-15）はすべて完了。**

- `def_check_number_operator`: `ň_μ := ψ̌_μ^† ψ̌_{1−μ}`（**全 `μ ∈ ℤ` で定義可能**）、`M` 周期性
- `check_number_operator_idempotent` / `check_number_operators_commute` /
  `trace_of_check_number_operator_product`（`tr(ň_{μ_1}⋯ň_{μ_k}) = 2^{M−k}`、`k` は `M` まで走れる）
- `check_joint_eigenspace_decomposition`: `Q̌_ε`（`ε ∈ {0,1}^{1..M}`）は `2^M` 個で
  **各同時固有空間は 1 次元**（`tr(Q̌_ε) = 1`）
- `eigenvalues_of_check_Vprime`: `V̌' Q̌_ε = e^{ǧ(ε)} Q̌_ε`、`ǧ(ε) = Σ_μ γ(θ~_μ)(ε_μ − 1/2)`
- `trace_of_check_Vprime`: `tr(V̌') = tr((V̌')^{−1}) = Π_μ 2cosh(γ(θ~_μ)/2) > 0`
- `V_plus_is_positive_definite`: `V^{(+)} = (2s_2)^{M/2} exp(S_1^{(+)}/2) exp(S_2) exp(S_1^{(+)}/2)` は正定値
- **`constant_c_value_even_sector`: `c = (2 sinh 2K_2)^{M/2}`**（016 章で未決定だった `c` を決定）
- **`eigenvalues_of_V_plus`: `Λ̌_ε = (2 sinh 2K_2)^{M/2} exp(ǧ(ε))` が `V^{(+)}` の固有値を尽くす**
- **`max_eigenvalue_of_V_plus_simple`: `Λ̌_max = Λ^{(1/2)}_M` かつ単純固有値**

### 次にやること（残っている一手）

**`c_+(M) = Λ̌_max`**、すなわち `sector_decomposition_of_rayleigh_sup` の `c_+(M)`（`ε` の固有値
`+1` の固有空間上での Rayleigh 上限）が `V^{(+)}` の最大固有値に等しいことを本文で示す。
これが済めば `remark_remaining_input_even_sector` が解消され、Onsager の自由エネルギーが本文で閉じる。
手がかりと注意は `docs/tasks/free-energy-roadmap/task-dependency-graph.md` の
章 C′「接続（残っている一手）」に書いた。
**`V^{(+)}` は `Mat(2^M,ℂ)` 全体に作用する行列であって `ε = +1` の固有空間への制限ではないので、
両者を同一視してはならない**（この点はまだ本文に無い）。

### 一次情報で確認した重要な事実

1. **`iH_is_real_symmetric` と `sign_flip_conjugation` は `S_1^{(±)}` について複号同順で
   述べられているので、(+) 側にそのまま使える。** `H_1^{(+)}` 用に書き直す必要はなかった
   （数値でも実対称性と `U S_1^{(+)} U^{−1} = −S_1^{(+)}` の残差は `0.0`）。
   一方 009 章の `V_is_positive_definite` は `V_eq_Vprime` の `V`（実質 `(−)` 専用）に
   結びついているので、`V_plus_is_positive_definite` として改めて述べた（証明の内容は同一）。
2. **`V^{(+)}` の固有値が「すべて相異なる」ことは成り立たない。**
   `periodicity_of_check_fermi` (1)(3) から `γ(θ~_μ) = γ(θ~_{M+1−μ})` なので、`ε` の成分を
   `μ ↔ M+1−μ` で入れ替えても `Λ̌_ε` は変わらない。数値でも縮退ペアが 144 件現れる
   （`050_.../check_03`）。**単純性を主張してよいのは最大固有値だけ**である。
   この点を取り違えると 011 章との接続で誤った補題を立てることになる。
3. 009 章の臨界点の例外処理（`m = |I| = M−1`、同時固有空間が 2 次元、前因子 `2^{M−m}`）は
   `gamma_2_theta_tilde_nonzero` により偶セクターでは一つも要らない（`m = M`、次元 1、前因子 1）。

### 数値検証

`sagemath/check/050_claim_even_sector_eigenvalues/`（6 チェック、全 PASS）。
`M = 2,3,4,5`、`{0,1}^M` を**全列挙**、厳密な臨界点 2 組を含む 6 組の `(K_1,K_2)`。

- `V^{(+)}` の `2^M` 個の固有値全体が `{Λ̌_ε}` と**相対誤差 9.0e-12 以下**で一致（check_06）
- `c = (2 sinh 2K_2)^{M/2}` の相対差 ≤ 4.3e-15、`Λ̌_max = Λ^{(1/2)}_M` の相対差 `0.0`（check_05, 06）
- 最大固有値と 2 番目の固有値の相対差の最小 `4.17e-1`（＝単純性）、`min γ(θ~_μ) = 5.4e-1`
- 対照: 対を `−μ` に取り違えると `ň_μ² = ň_μ` が残差 `2.59` で破れる（check_01）

## 完了（2026-07-26）: 章 C′ の C′-13・C′-14 — `V^{(+)} = c·checkV'` まで到達

### 到達点

`structured-latex/content/016_even_sector_fermions.ts`（10 ブロック）で、半整数運動量のフェルミオンを
導入し、ある `c ∈ C^×` について

```
V^{(+)} = c · checkV',
checkV' = exp( Σ_{μ=1}^{M} γ(θ~_μ)( checkψ^†_μ checkψ_{1-μ} - I/2 ) )
```

まで到達した。**`c` の値（`= (2 sinh 2K_2)^{M/2}` と予想される）の決定は C′-15 の仕事**であり、
`remark_remaining_input_even_sector` もまだ解消されていない（固有値は C′-15）。

| ラベル | 内容 |
|---|---|
| `def_check_fermi` | `(checkψ^†_μ, checkψ_μ) := (Ž_μ, Y̌_μ) P̌_μ`。**すべての `μ ∈ Z` で定義可能** |
| `periodicity_of_check_fermi` | `γ_1, γ_2(±), γ` の `M` 周期性、`checkψ_{μ+kM} = checkψ_μ`、共役添字 `1−μ` の関係 |
| `anticommutator_of_check_psi` | `[ψ̌^†_μ, ψ̌_ν]_+ = δ^M_{(μ+ν,1)} I` ほか。**対は `μ+ν ≡ 1 (mod M)`** |
| `commutation_V_plus_check_psi` | `T_{(V^{(+)})}(ψ̌^†_μ) = e^{+γ(θ~_μ)} ψ̌^†_μ` ほか |
| `def_check_Vprime` | `checkV' = exp(X̌)`。**和の範囲 `μ = 1..M` に例外が要らない**。可逆性も証明 |
| `action_of_T_check_Vprime_on_check_psi` | `T_{(checkV')}(ψ̌^†_μ) = e^{+γ} ψ̌^†_μ` ほか |
| `T_V_plus_eq_T_check_Vprime_on_check_Z_Y` / `T_V_plus_eq_T_check_Vprime` | `T_{(V^{(+)})} = T_{(checkV')}`（`Mat(2^M,C)` 全体） |
| `V_plus_eq_c_check_Vprime` | `V^{(+)} = c checkV'`（`centralizer_is_scalar` による。クリフォード群に依存しない） |

### 008 章から消えた 3 種類の場合分け（次に着手する人へ）

いずれも**一次情報（008 章の該当ブロックの本文）を読んで、`γ_2 = 0` のみに起因することを確認**したうえで
落とした。C′-15 でも同じ観点で 009 章を読むこと。

1. **臨界点の場合分け**。008 章の `def_fermi` の定義域限定、`def_Vprime` の和の範囲限定、
   `A_theta_is_identity_when_gamma2_zero`、`T_Vprime_fixes_hatZ_hatY_when_gamma2_zero`、
   `T_V_eq_T_Vprime_on_hatZ_hatY` の「場合 2」は、すべて `γ_2(θ_μ) = 0` になりうることだけに由来する。
   `gamma_2_theta_tilde_nonzero`（015 章）により偶セクターでは起こらない。
2. **複素平方根の分枝の議論**。`relation_of_gamma_2_theta_tilde` (4)(5) で根号が `|γ_2|` と `i|γ_2|` に
   確定しているので、`P̌_μ` の成分は最初から実の絶対値で書かれ、分枝の一致（008 章 `anticommutator_of_psi`
   の Step 0）を示す必要がない。
3. **`μ` の符号による場合分け**。008 章は添字集合が `calM = {−M,…,−1,1,…,M}` なので
   `action_of_T_Vprime_on_psi` を `μ` の符号で 3 通りに分けていた。016 章は `μ ∈ Z` で扱い、
   `periodicity_of_check_fermi` を先に立てて場合分けを消した。

### 数値検証

`sagemath/check/049_claim_even_sector_fermions/`（6 チェック、全 PASS）。`M = 2,3,4,5`、
`(K_1,K_2)` は**厳密な臨界点 2 組**（非等方・等方）＋近傍 1 組＋一般 2 組＋高温 1 組。
`V^{(+)}` も `checkV'` も行列指数関数から直接構成しており、証明が使う交換子の級数展開とは独立。
- 対を `μ+ν ≡ 0 (mod M)` と誤ると反交換関係が残差 1.0 で壊れることを対照として記録（check_02）。
- `checkV'` の和の範囲を `{1..M−1}` / `{1..M+1}` に変えると `[X̌, ψ̌^†_μ] = γψ̌^†_μ` が壊れることを
  記録（check_04）— 和の範囲 `μ = 1..M` に数え落としも重複も無いことの裏づけ。
- `T_{(V^{(+)})} = T_{(checkV')}` は行列単位 `e_{ij}`（`2^M × 2^M` 個）すべてで直接確認（check_05）。
- `c = (2 sinh 2K_2)^{M/2}` は全ケースで一致（相対差 ≤ 2.3e-13）。**ただし証明は C′-15**（check_06）。

## 完了（2026-07-26）: 章 C′ の C′-8〜C′-11 — `T_{(V^{(+)})}` の作用まで到達

### 到達点

`structured-latex/content/014_even_sector_T_action.ts`（11 ブロック）で、013 章の (A)〜(D) から

```
(T_{(V^{(+)})}(checkZ_μ), T_{(V^{(+)})}(checkY_μ)) = (checkZ_μ, checkY_μ) A(θ~_μ)
A(θ~_μ) = B_1(θ~_μ) B_2 B_1(θ~_μ)          （V^{(+)} = (V_1^{(+)})^{1/2}V_2(V_1^{(+)})^{1/2}）
```

まで到達した。**`remark_remaining_input_even_sector` はまだ解消されていない**（固有値は C′-12〜C′-15）。

| ラベル | 内容 |
|---|---|
| `def_H1_plus` / `def_V1_plus_square_root` / `V1_plus_square_root_property` / `def_V_plus` / `V_plus_factors_invertible` / `def_T_V_plus` / `T_V_plus_is_conjugation` | `V^{(+)}`, `(V_1^{(+)})^{1/2} := exp((i/2)K_1H_1^{(+)})`, `T_{(V^{(+)})}`。可逆性・平方根であること・**合成 = 積による共役**を証明 |
| `nesting_of_commutator_of_H_and_check_Z` | (h1.z)(h1.y)(h2.z)(h2.y) の n 重交換子（帰納法） |
| `cosh_sinh_coefficient_conversion_for_check` | 生成子を `(i/2)K_1H_1^{(+)}`, `iK_2^*H_2` にスケール |
| `extract_taylor_coefficient_of_check_Z_Y` | `cosh/sinh` への抽出 |
| `T_actions_on_check_Z_Y` / `linearity_of_T_on_check_Z_Y` / `def_B1_theta_B2` / `calc_of_TxT_check_Z_Y` | `T_{(V_1^{(+)})^{1/2}}, T_{V_2}` の作用と `B_1(θ~_μ), B_2` による右乗 |
| `factorization_of_A_theta_general` | **`θ ∈ R` 一般**での `B_1(θ)B_2B_1(θ) = A(θ)` |
| `T_V_plus_check_Z_Y` | 上の到達点 |

### 008 章がそのまま流用できた理由（一次情報で確認済み。次に着手する人へ）

008 章の `nesting_of_commutator_of_H_and_Z` 〜 `T_V_hatZ_hatY` の各証明は、1 重の交換子 (A)〜(D)、
交換子の双線型性、exp 共役の級数展開、`e^{iθ}e^{-iθ}=1` **しか使っていない**。`θ_μ` 固有の性質
（`e^{-iMθ_μ}=+1`、添字集合 `calM`、`hatZ_hatY_M_periodicity`）が効いていたのは
`commutator_of_H_and_Z_Y` の段だけで、そこは 013 章が半整数運動量について独立に済ませている。
**C′-12 以降も同じ観点で既存証明を読んでから流用の可否を判断すること。**

一方、**既存ブロックをそのまま `ref` で使えないケースが 2 種類ある**（C′-11 で実際に踏んだ）:
1. `μ ∈ calM` で量化されている主張（例 `factorization_of_A_theta`）は `θ~_μ` に適用できない。
   `θ ∈ R` 一般の主張として立て直す。
2. 008 章の `V` / `def_T_V` は `why_008_applies_only_to_minus_sector` により実質 `(−)` 専用。
   偶セクターでは `V^{(+)} / T_{(V^{(+)})}` を別記号で定義し直す。

### 数値検証

`sagemath/check/047_claim_even_sector_T_action/`（4 チェック、全 PASS）。
`M = 2,3,4,5`、`μ = 1..M`、`(K1,K2)` は**臨界点上 (0.4407,0.4407) と臨界点近傍 (0.44,0.45) を含む 5 組**。
`T_g` は行列指数関数を明示構成した直接計算で評価しており、級数展開に依存しない独立経路。
`γ_2(θ~_μ) ≠ 0`（最小 0.56）も確認済み — C′-12 で臨界点の例外処理が不要になる根拠。

## 完了（2026-07-26・追補6）: 最終成果物（PDF）の生成器を作った

**README 7 節が定める「content だけから最終成果物を生成する」を、実行可能にした。**
それまで生成器が存在せず、証明が論文として出せる状態か誰も確認できていなかった。

- `structured-latex/tools/build-latex.ts` — content のみを入力に LaTeX を組み、
  tectonic（XeTeX 系・日本語は xeCJK ＋ ヒラギノ）で PDF まで作る。
  `npm run build:tex` / `npm run build:pdf`。出力は `build/`（git 管理外）。
- **実測: 173 ページ、ブロック 217（見出し 15・証明 141）、ラベル 183、相互参照 945 件すべて解決、
  未解決参照 0、LaTeX エラー 0、組めない文字 0、版面外へ出た行 0。** 目次（14 章＋部 I）・
  定理番号（章.通し番号）・証明環境・相互参照リンク・数式と日本語の混植・★ の描画を
  PDF の目視で確認済み（1/2/5/34/164 ページ）。
- 変換規則: 文書順は配列順のまま、`level` 1 → `\part` / 2 → `\section` / 3 以降は下位の節。
  定義・主張・定理・注意・ノートは amsthm の各環境、`proof` は proof 環境、
  `ref()` は `\cref`（cleveref）。
  素直に level 1 → section にすると章より前のブロックが「定義 0.4」になるため part を使う（実測で選択）。
- **ノート非混入を 3 重で検査**（`tools/verify-no-notes-in-output.ts`、`npm run check` に組み込み）:
  生成器のコードが notes を参照しないこと／生成物にノート id が無いこと／ノート地の文の
  特徴的な文字列 107 件が生成物に無いこと。検査が効くことは注入実験で確認済み。
- **数式は 6,683 ノード・366,329 文字・マクロ 151 種すべてが LaTeX でそのまま組めた**（組めないもの 0）。
  必要なパッケージは amsmath / amssymb のみ（mathtools は外してもビルドできることを実測で確認して外した）。
  詳細は [docs/publication-output.md](docs/publication-output.md)。

**レビューで見つかった実害と対処（いずれも修正済み）**:
1. **22 箇所の数式が紙の外へ出て内容が切れていた**（最大 212pt）。ビルドは成功扱いだった。
   幅を測って自動で縮める `\fitdisplay` を入れ、右余白を超える overfull があればビルドを失敗させる。
2. **★（実数解析への移行点の印）と ′ が PDF から無言で消えていた**。欧文フォントに無いため。
   `xeCJKDeclareCharClass` で和文フォントへ回し、`Missing character` があればビルドを失敗させる。
3. **未解決参照の検査が発火しない死んだコードだった**。tectonic は LaTeX の警告を標準出力に出さず、
   ログファイルにしか書かない。検査対象を `document.log` へ変え、ラベル重複の検査も足した。
4. 地の文エスケープのバックスラッシュ置換順序の不具合、別行立て数式直後の不要な字下げ、
   ノート混入検査のサンプル打ち切り（5 件 → 全 177 件、エスケープ後も照合）も修正。

次にやるなら: 出版形態（article → book / 章割り）の検討、参考文献・索引、
図（現在 0 件）の扱い。本文の記法・内容の変更は別セッションの担当。
## 完了（2026-07-26）: ゴール3件（欠陥5件の確認・記法検査の追加・Lean 2本立て）

### (1) Lean 形式化が検出した本文の欠陥5件 — 全件解消済みを一次情報で確認

着手前に現状を確認し、**すべて解消済みだったため重複作業を回避した**。内容も検証した。

- 平方根の分枝: 単一値の平方根であることを明示（原文が偽なのではなく主張に分枝指定が無い穴）。Lean 側も追認済み。
- det A = 1: 双対関係の帰結 `c_2 s_2^* = c_2^*` を明示し、定義から直接6ステップで計算する形に。
- γ_2 = 0 の条件: `s_2^* ≠ 0`（K_2 > 0 から従う）を statement に明記。
- 偶数 M の見落とし: `sin θ_μ = 0 ⟺ μ = ±M` は**偽**であることを明記し、
  `M | 2μ` の偶奇での正しい場合分けを Step 3' として独立させた。
  `μ = ±M/2` の排除は `c_2 s_1 = -c_1 < 0` と正値性の矛盾として Step 4 で行う。
- P_μ の可逆性: `det P_μ` を計算し、複素数体に零因子が無いことから非零を導出（Step 3〜5）。

### (2) 記法の揺り戻しを機械検査にした

記法置換の完了後、**後から書かれた章（011・013）で `\otimes` が4箇所揺り戻る事故**が起きた。
`validate-content.ts` に `assertNoAbstractTensorNotation` を追加し、本文ブロックの数式・タイトルに
`\otimes` があればエラーで落とすようにした（誤り時は正しい記法を案内する）。
検査対象は `content/` のみ（`notes/` は採用しなかった抽象的な見方を記録する場所なので除外）。
負テストで検出を確認済み。

### (3) Lean の「具体版＋抽象版」2本立て — 対象を一巡

`Ising2D/Abstract/` が11ファイルに増えた。カバー済み:
交換子と反交換子 / H1,H2 と hatZ,hatY の交換関係 / ad の二項定理・指数関数の共役 /
フェルミオンの定義と反交換関係 / 中心=スカラー / T_(V) の作用 /
Z,Y の線型独立性（`CliffordIndependence`）/ 指数和の直交性（`RootOfUnitySum`）/
hatZ,hatY の反交換関係（`FourierClifford`）/ **Z,Y の反交換関係**（`SiteLocalAnticomm`）/
**hat の周期性・離散Fourier逆変換**（`DiscreteFourier`）。

**抽象版で判明した「何が本質か」**（＝具体版が過剰な構造を要求していないかの検査結果）:

- **Z,Y の反交換関係**: 効いているのは「サイトごとの族から1元を作る写像が単位的・乗法的・多重線型」
  であることと「食い違うサイトがちょうど1つ」であることの2点**だけ**。クロネッカー積の具体形も、
  成分が 2×2 であることも、複素数であることも、Pauli 行列の成分計算も効いていない。
  Jordan–Wigner 文字列に要るのは「サイト添字に線型順序があること」だけで、
  文字列に使う元が σ^x である必要すらない。
- **hat の M 周期性**: `ζ^M = 1` の一点のみ。**原始根であることすら不要**。
  重みも周波数も任意の族で通るので、hat(Z)^(±) の符号も指数の符号の取り方も無関係。
- **離散Fourier逆変換**: 1 の原始 M 乗根の直交性と、対象が係数体上の加群であることだけ。
  積も反交換関係も不要。副産物として、**原文が hat(Z)^(+) で復元を述べていない理由が説明できた**
  ——抽象版の仮定が「重みが一様」であり、(+) は j=1 の重みだけが −1 だから。
- **線型独立性**: Clifford 関係 `[e_a,e_b]₊ = 2δ_ab·1` だけから従う（3行）。
  既存の生成定理も行列単位基底も不要だった。
- **指数和の直交性**: 1 の原始 M 乗根であることだけ。

いずれも**具体版は過剰な構造を要求していなかった**ことが確認できた。

`lake build` 成功（2510 jobs）、`check-no-sorry.sh` exit 0、**344定理が未証明公理に非依存**。

**残り**（抽象版が無い）: Z,Y が全行列環を生成 / テンソル冪の基底 / 共役写像が環準同型。

### 現状の規模

本文217ブロック・ラベル183・参照1019件すべて解決、抽象テンソル積記法0件、
参照用ノート38件、数値検証との対応103件、負テスト18件・実行時検証10件すべて期待どおり。

## 完了（2026-07-26・追補6）: Lean の 2 本立てを 3 主張ぶん追加（線型独立・指数和・hat の反交換関係）

README 4 節の方針にしたがい、**具体版しか無かった 3 主張**に抽象版を足し、
具体版を抽象版の系として導出した（既存の具体版はそのまま残してある）。

| 主張（人手証明のラベル） | 追加した抽象版 | 抽象版で分かった「効いているもの」 |
|---|---|---|
| `Z_Y_linearly_independent` | `Abstract/CliffordIndependence.lean` | Clifford 関係 `[e_a,e_b]₊ = 2δ_{ab}·1`、スカラーの忠実性 `s·1 = 0 ⇒ s = 0`、`2` が零因子でないこと。**この 3 つだけ**。行列・テンソル冪・Jordan–Wigner の具体形・有限次元性・係数が体であることは不要（係数は任意の可換環、台は任意の環） |
| `exp_sum` | `Abstract/RootOfUnitySum.lean` | 「1 の原始 `M` 乗根であること」と「割り算ができること」だけ。指数関数・円周率・複素数であることは不要（任意の体で成立）。**`M ≠ 0` も証明には不要**（`M = 0` なら両辺 `0`）だったので、引数は `_hM` として残し理由を明記 |
| `anticommutator_of_hat_Z_and_hat_Y` | `Abstract/FourierClifford.lean` | Clifford 関係＋原始根の直交性だけ。さらに **`(±)` の重みは「両側の積 `u_j v_j`」しか結論に現れない**ので、原文の複号同順／複号逆は「積が全サイト `1`」と「`j = 1` でだけ `-1`」に整理できる。原文の `η^2 = 1` は積が `1` になる十分条件にすぎない |

具体版の導出（人手証明と 1 対 1 対応する主張は別に立ててある）:
`Part004/Claim001_ZYLinearlyIndependentAbstract.lean`（`ZY_linearIndependent_of_abstract`）、
`Part004/Claim008_ExpSumAbstract.lean`（`expPhase_sum_of_abstract`）、
`Part007/Claim000_AnticommutatorHatZHatYAbstract.lean`
（`acomm_hatZ_hatZ_same_of_abstract` / `acomm_hatY_hatY_of_abstract` /
`acomm_hatZPlus_hatZMinus_of_abstract`）。

実装メモ: `if (M:ℤ) ∣ k then …` の中を `dvd_neg` で `rw` すると Decidable インスタンス依存で
motive が型付かない。`congr 1` の後に `simp only [dvd_neg]` で通す。

`lake build` 成功、`check-no-sorry.sh` は exit 0（新規 22 件を targets に追加）。

---

## 完了（2026-07-26・追補7）: Lean の 2 本立てをさらに 3 主張ぶん追加（Z,Y の反交換関係・hat の周期性・離散 Fourier 逆変換）

README 4 節の方針にしたがい、**具体版しか無かった 3 主張**に抽象版を足し、
具体版を抽象版の系として導出した（既存の具体版はそのまま残してある）。

| 主張（人手証明のラベル） | 追加した抽象版 | 抽象版で分かった「効いているもの」 |
|---|---|---|
| `anticommutator_of_Z_and_Y`（`Z_μ, Y_ν` の反交換関係 3 式） | `Abstract/SiteLocalAnticomm.lean` | 「サイトごとの族から 1 元を作る写像 `P` が**単位的・乗法的・多重線型**であること」と「食い違うサイトがちょうど 1 つであること」**だけ**。テンソル積／クロネッカー積の具体形も、2×2 であることも、複素数であることも、Pauli 行列の成分計算も効いていない（使うのは `A σ^x = -σ^x A` 型の関係式のみ）。Jordan–Wigner 文字列を書くのに要るのは「サイトの添字に線型順序があること」だけで、文字列に使う元が `σ^x` である必要もない |
| `hatZ_hatY_M_periodicity` | `Abstract/DiscreteFourier.lean`（`transform_periodic`） | **`ζ^M = 1` の一点のみ**。原始根であることすら不要で、`Z_j, Y_j` の代数的性質も `hat(Z)^{(±)}` の重みも指数の符号の取り方も効かない（重み・周波数を任意の族にしたまま証明できる） |
| `recover_Z_Y_from_hatZ_hatY`（離散 Fourier 逆変換） | `Abstract/DiscreteFourier.lean`（`inverse_dft_abstract`） | **1 の原始 `M` 乗根の直交性**と**対象が係数体上の加群であること**だけ。行列であること・積があること・`Z,Y` の反交換関係は不要。原文が `hat(Z)^{(+)}` で復元を述べていない理由も抽象版から一意に説明できる（抽象版の仮定は「重みが一様」で、`(+)` は `j = 1` の重みだけ `-1`） |

具体版の導出（人手証明と 1 対 1 対応する主張は別に立ててある）:
`Part006/Claim000_AnticommutatorZYAbstract.lean`（`anticomm_Z_Z_of_abstract` /
`anticomm_Z_Y_of_abstract` / `anticomm_Y_Y_of_abstract`）、
`Part004/Claim012_HatPeriodicityAbstract.lean`（`hatZ_periodic_of_abstract` ほか）、
`Part004/Claim013_RecoverZYAbstract.lean`（`inverse_dft_of_abstract` /
`recover_Y_of_abstract` / `recover_Z_of_abstract`）。

実装メモ:
- `omit [Inst] in` はドキュメンテーションコメントより**前**に置く（後ろだと構文エラー）。
- `Z μ` は `def` なので `rw` の対象にならない。`have h : acomm (Z μ) (Z ν) = 0 := ...` と
  定義展開に任せて term-mode で受ける。

`lake build` 成功、`check-no-sorry.sh` は exit 0（新規 24 件を targets に追加）。
**残作業**: 抽象版が無い主張はまだある（`Part004` の `Z,Y` が全行列環を生成、
`Part002` のテンソル冪の基底、`Part000` の共役写像が環準同型）。

---

## 完了（2026-07-26・追補5）: 型で落とせる範囲を拡張（実行時検査からの移管）

**新たにコンパイル時に落ちるようになったもの**（負テスト 16 件で実証。`npm run test:types`）:

- **ブロック id・ラベル・ノート id の重複**。同一ファイル内は `defineBlocks` / `defineNotes` の
  `const` 型引数＋重複検出型で、**ファイル跨ぎ**は生成した集約モジュール
  `document.generated.ts`（全ファイルを import して 1 本のタプル型へ連結）で落とす。
  診断には重複した値そのものが出る。
- ノート id とブロック id の衝突、`labels.generated.ts` と content のズレ（両方向）。
- 見出し `level` の範囲（1〜6 のリテラル union）、タイトルが `text` も `tex` も無い場合、
  `conversion.status` の綴り違い（`"converted" | "added"`）。
- 既存分（存在しないラベルへの参照・ノートの紐づけ、見出しへの本文混入、定理型への `level`、
  フィールド名の打ち間違い）も維持。

**実装で踏んだ罠（同じ轍を踏まないこと）**:
1. `const` 型引数だけにすると**余剰プロパティ検査が消える**。`T & readonly ConvertedBlock[]` と
   具体型との交差にすると両立する（実測）。
2. 重複検出の再帰型を素朴に書くと 173 ブロック規模で TS2589 になり、**検査が黙って無効化される**。
   末尾再帰（累積引数）で書き直した。
3. 生成した集約モジュールを `tsconfig.json` の `include` に入れ忘れており、
   一時的に検査が完全に無効だった。**負テストを書いて初めて気づいた。**

**型では表現できないと実測で確認したもの**（実行時検査として維持。根拠は
[docs/type-coverage.md](docs/type-coverage.md)）: 未変換 Typst 記法の混入（テンプレートリテラル型で
制約自体は書けるが、content が使う `String.raw` がリテラル型を返さないため効かない）、
`sourceOrdinal` の整数性（TS に整数型・数値範囲型が無い）、`sourcePath` の実在（FS 参照）、
SageMath の overview.md との対応（Markdown 解析）、生成物とディレクトリ一覧の一致（FS 列挙）。

生成ツールは `tools/generate-index.ts`（旧 generate-labels.ts）に統合。
**レビュー指摘で追加・訂正した点**:
- `sourceOrdinal` の整数性は「型で不可能」と書いていたが**誤り**。数値リテラル型を
  テンプレートリテラル型で文字列化すれば判定でき、型へ移した（2.5 / -3 / 0 が落ちる）。
- `document.generated.ts` が tsconfig の include から落ちると検査が無音で全滅する穴を二重に封鎖
  （型テストからの型 import ＋ generate-index による include 検査）。
- 制約の無い `A extends B ? true : never` は何も検査しない（`Assert<T extends true>` へ修正）。
- 実行時側の非対称（status の値域・タイトルの text|tex・ノートのタイトルの Typst 記法）も解消。

検査は `npm run check`（生成物の鮮度 → 型検査 → 実行時検証 → 移行漏れ検出 → 負テスト18 → 実行時テスト10。約 2.5 分）。
## 完了（2026-07-26）: 章 C′ の C′-12 — 半整数運動量における `A(θ~)` の対角化

`structured-latex/content/015_A_theta_tilde_diagonalization.ts`（9 ブロック）を新規に書いた。
`θ~_μ = 2π(μ−½)/M` における `A(θ~_μ)` の対角化を、**場合分けなしで**確立した。

### 確定した最重要事項: `γ_2(θ~_μ) ≠ 0` は常に成り立つ（`gamma_2_theta_tilde_nonzero`）

`γ_2(θ) = 0` は `sin θ = 0` かつ `c_1 cos θ = s_1 c_2` を要する。半整数運動量では
`sin θ~_μ = 0` ⟺ `2μ−1 = kM` で、**左辺が奇数なので `k` は奇数**、したがって
`cos θ~_μ = cos(kπ) = −1`。すると `s_1c_2 = −c_1 < 0` となり `c_1, s_1, c_2 > 0` に矛盾する。
整数運動量（`gamma_2_theta_is_0`）では `cos θ_μ = +1`（`μ = ±M`）の場合が残り、
そこが臨界点 `sinh 2K_1 sinh 2K_2 = 1` で零点になっていた。
**この違いにより、008・009 章にあった臨界点の例外処理が偶セクターでは不要になる。**

### そこから従うこと

- `sqrt(−γ_2(θ~)γ_2(−θ~)) = |γ_2(θ~)| > 0`、`sqrt(γ_2(θ~)γ_2(−θ~)) = i|γ_2(θ~)|`
  （根号の中身が正/負の実数に確定するので、008 章の固有ベクトル導出にあった複素平方根の
  分枝の議論を追い出せた。固有ベクトルは代入して確かめるだけで済む）
- `λ_{±,μ} = γ_1 ± |γ_2| ∈ R`、`A(θ~_μ) = P̌_μ Ď_μ P̌_μ^{-1}`、`det P̌_μ ≠ 0`
- `det A(θ~_μ) = 1`、`γ_1² = 1 + |γ_2|²`、よって **`γ_1(θ~_μ) > 1`（狭義）**
- `γ(θ~_μ) := arccosh(γ_1) > 0`、`λ_± = e^{±γ}`、**`λ_+ > 1 > λ_- > 0`（固有値は常に分離）**

`γ > 0` と固有値の分離が C′-15（最大固有値の一意性）への引き継ぎ物である。

### 記法上の判断（次に触る人へ）

008 章の `γ_1(θ_μ), γ_2(θ_μ)` の定義ブロック（`TV1_hatZ_hatY_020_definition_gamma1_gamma2`）には
**ラベルが無く参照できない**。既存ブロックを書き換えない方針だったので、015 章で
`def_gamma1_gamma2_of_theta` として `θ ∈ R` の関数の形で定義し直した（式は 008 章と文字どおり同一。
`A(θ)` 自体は `def_A_theta` を再定義していない）。C′-13 以降でもこのラベルをそのまま使える。

### 数値検証

`sagemath/check/048_claim_A_theta_tilde/`（5 チェック、全 PASS）。`M = 2..8` の全 `μ`、
厳密な臨界点（`K_2 = arcsinh(1/sinh 2K_1)/2` で構成）とその近傍を含む 16 組の `(K_1,K_2)`。
半整数運動量側の `min |γ_2(θ~_μ)| = 1.6e-1`、`min(γ_1 − 1) ≥ 1.3e-2`、`min γ(θ~_μ) ≥ 3.0e-1`。
同じ `K` の臨界点で整数運動量 `θ = 2π` は `|γ_2| ~ 1e-16`、`γ = 0` になることも対比で記録した。

**踏んだ罠**: 本プロジェクト定義の `sqrt`（偏角を `[0,2π)` で取り半分にする）は**正の実軸で不連続**。
数学的には正の実数である `−γ_2(θ~)γ_2(−θ~) = |γ_2|²` が倍精度で虚部 `−0` を持つと `arg` が `2π` 側に
落ちて符号が反転する。`_prelude.sage` の `clean_real()` でその丸めを除いてから `sqrt` に渡している。

## 進行中（2026-07-26）: 章 C′（偶セクターの半整数運動量モード）— **土台と C′-12 が完了、固有値はまだ**

### 到達点と未到達点をはっきりさせる

**ゴールだったこと**: `V^{(+)}` の固有値が半整数運動量で与えられることを証明し、
`remark_remaining_input_even_sector` を解消して厳密解を本文で閉じる。

**やったこと**: `structured-latex/content/013_even_sector_modes.ts`（8 ブロック）で
**土台（008 章冒頭までに相当する部分）を完成させた**。

**やっていないこと**: `V^{(+)}` の固有値そのもの。008 章後半に相当する C′-8〜C′-11 は
その後 014 章で完了した（上の節）。残っているのは C′-12〜C′-15。

### 完了した 8 ブロック

| ラベル | 内容 |
|---|---|
| `why_008_applies_only_to_minus_sector` | `[H_2, hatZ^{(+)}_μ] = −2 hatY_μ + 4e^{−iθ_μ}Y_1 ≠ −2 hatY_μ`。008 章が `(−)` 専用である理由を**等式として**確定 |
| `antiperiodic_exp_sum` | `Σ_{μ=1}^{M} e^{ikθ~_μ} = M(−1)^l`（`k=lM`）/ `0`（それ以外） |
| `def_half_integer_modes` | `checkZ_μ = Σ_j Z_j e^{−ijθ~_μ}`、`θ~_μ = 2π(μ−½)/M`。反周期性 `e^{−iMθ~_μ} = −1`、共役添字 `1−μ` |
| `commutator_of_H_and_check_Z_Y` | (A)〜(D) が `H_1^{(+)}, H_2` に対して 008 章と**同じ形**で閉じる |
| `anticommutator_of_check_Z_Y` | 対は `μ+ν ≡ 1 (mod M)`（整数運動量の `μ+ν ≡ 0` と違う） |
| `recover_Z_Y_from_check_Z_Y` | 復元公式と生成性 |
| `H1_H2_via_check_Z_Y` | `H_1^{(+)} = (1/M)Σ_μ checkY_μ checkZ_{1−μ} e^{−iθ~_μ}`、`H_2 = (1/M)Σ_μ checkZ_{1−μ} checkY_μ` |

**仕組みは 1 つの等式に集約される**: `e^{−iMθ~_μ} = −1`（反周期性）。`hatZ^{(±)}` が境界の符号を
**第 1 項**に置いていたのに対し、`checkZ` では位相が `j=M` から `j=0` へ回るときに自動的に符号が出る。
整数運動量では `e^{−iMθ_μ} = +1` なので同じ計算が閉じない。`H_1^{(+)}` の境界項 `−Y_MZ_1` の符号も
`antiperiodic_exp_sum` の `l=1` の因子 `(−1)^1` として自動的に現れる。

### 残っている作業（C′-12〜C′-15）

`docs/tasks/free-energy-roadmap/task-dependency-graph.md` の章 C′ に、
**対応する既存ブロックを 1 対 1 で対応づけた表**を書いた。要点だけ再掲する。

- C′-8〜C′-10: n 重交換子 → テイラー係数の抽出 → `T_V` の作用（008 章前半の写し）
- C′-11: `B_1B_2B_1 = A(θ~)`。θ についての 2×2 の主張なので既存ブロック（`T_V_hatZ_hatY`）を再利用できる見込み
- C′-12: `A(θ~)` の対角化 → **完了**（015 章。上の「完了（2026-07-26）: 章 C′ の C′-12」を参照）
- C′-13〜C′-15: フェルミオン → `V^{(+)} = c checkV'` → 009 章の写しで固有値

**簡単になる点**: 半整数運動量では `γ_2(θ~_μ) ≠ 0` が**常に**成り立つ
（`sin θ~_μ = 0` は `θ~_μ = π`（`M` 奇数）しかなく、そのとき `−c_1 = s_1c_2 > 0` で矛盾）。
よって 008・009 章にあった臨界点の例外処理（`μ = M` の除外、`m = M−1`）が偶セクターでは**不要**。
数値でも確認済み（`047_.../check_04` の (4)、最小 `|γ_2| = 0.56`）。

### 数値検証

`sagemath/check/046_claim_even_sector_modes/`（3 チェック、全 PASS、`M = 2,3,4,5`）。
`(+)` 側が `−2 hatY` と一致しないことは**全 μ での最小残差 4.00** で確定している。

### 分割について（次に着手する人へ）

このゴールは着手前から「008 章＋009 章の合計に相当」と共有されていた。分割は
C′-8〜C′-11（`T_{(V^{(+)})}` の作用まで。**014 章で完了**）／C′-12（`A(θ~)` の対角化）／
C′-13〜C′-15（フェルミオンと固有値、ほぼ 009 章の写し）に切れる。

## 完了（2026-07-26）: 章 C（最大固有値）と章 D（自由エネルギー・熱力学極限）— 残るは偶セクターの固有値 1 点

### 結果

`structured-latex/content/011_max_eigenvalue.ts`（11 ブロック）と
`012_free_energy.ts`（7 ブロック）を新規に書き、Onsager の自由エネルギーの表式まで到達した。

```
c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}                     （章 C）
(1/(M N_row)) log Z → (1/M) log c(M)                      （章 D、誤差 ≤ log2/N_row）
(1/M) log Λ^{(δ)}_M → ½ log(2 sinh 2K_2) + (1/4π)∫₀^{2π} γ  （章 D、δ に依らない）
γ(θ) = arccosh( cosh2K_1 cosh2K_2* − sinh2K_1 sinh2K_2* cos θ )
```

### 章 C の方針（重要）: スペクトル定理を使わない

`c(M)` を最大固有値ではなく **Rayleigh 商の上限** `sup_{‖x‖=1} x^T W x` として定義した。
`W := V_1^{1/2} V_2 V_1^{1/2}`。上からの評価は半正定値形式の Cauchy–Schwarz から出る
`‖Wx‖ ≤ c‖x‖`、下からの評価はモーメント列 `m_k = x^T W^k x` の対数凸性（`m_k² ≤ m_{k-1}m_{k+1}`）による。
実対称行列の対角化可能性は正しいが本文にまだ無く、挟み撃ちには不要だったので導入しなかった。

`W` の成分がすべて正であることも示した（`V_1^{1/2}` が正の対角行列、`V_2` の成分が正）。
これは Perron–Frobenius により最大が偶セクターにあることを意味する（本文では使っていないが数値で確認済み）。

### 章 D の実数解析への移行点（README 2 節の要求）

**移行するのは `riemann_sum_to_integral` ただ 1 つ**で、持ち込む外部事実は 2 つだけと明記した。

- (R1) Heine–Cantor（有界閉区間上の連続関数は一様連続）
- (R2) 連続関数の Riemann 可積分性（区間加法性・`|∫h| ≤ |I| sup|h|`・定数の積分）

誤差評価 `|(1/M)Σ g(t_μ) − (1/2π)∫g| ≤ ω(2π/M)`（`ω` は連続度）を明示的に出した。
`δ ∈ [0,1)` を許す形にしたので**整数運動量（δ=0）と半整数運動量（δ=1/2）を 1 つの主張で扱え**、
どちらでも極限が同じであることが熱力学極限でセクターの区別が消える理由になっている。
`N_row → ∞` の段は有限の不等式と `log` の単調性だけで、実数解析へは移行していない。

### 発見: 厳密解へ残っている入力は 1 点だけ（章 C′）

**`V^{(+)}` の固有値は半整数運動量 `2π(μ−1/2)/M` で与えられる**が、これは本文で未確立である。
一方 `V^{(-)}` は整数運動量で、009 章が扱っているのはこちらだけ。数値で決定的に分離した
（一致側は相対誤差 1e-14 以下、他方は相対差 0.5〜2.4）。

**本文に無い理由を一次情報で特定した**: `def_hatZ_hatY` の `hatZ_μ^{(±)}` は第 1 項に符号 `∓` を持つ。
`commutator_of_H_and_Z_Y` の (C) `[H_2, hatZ_μ^{(-)}] = −2 hatY_μ` は `[H_2, Z_j] = −2Y_j` を
各項へ適用して係数を比べる形で示されるが、`hatZ_μ^{(+)}` では第 1 項だけ符号が反転するため
右辺が `−2 hatY_μ` にならない（数値でも `(−)` は残差 1e-15、`(+)` は 1e-3 以上で不成立）。
したがって **008 章以降は `(−)` セクター専用**であり、`(+)` にはそのまま使えない。

**最大固有値は `(+)` セクターにある**（数値で M=2,3,4 確認）ので、この入力は
「あれば精度が上がる」類ではなく**厳密解の値そのものを決める必須の入力**である。
進め方の見込み（位相へ繰り込んだ `checkZ_μ = Σ_j Z_j e^{-ijθ~_μ}` を使う。(A)〜(D) と
反交換関係 `μ+ν ≡ 1 (mod M)` は数値で確認済み）は
`docs/tasks/free-energy-roadmap/task-dependency-graph.md` の章 C′ に書いた。分量は 008+009 章相当。

### 数値検証

- `sagemath/check/044_claim_max_eigenvalue/`（3 チェック、全 PASS）
- `sagemath/check/045_claim_free_energy/`（3 チェック、全 PASS。臨界点 `(0.4407,0.4407)` を含む）

**注意（次に触る人へ）**: 045 の check_01/02 は最初 `w^N` や `(2 s_2)^{M/2}` を直接計算して
倍精度の桁溢れで FAIL した。対数空間で計算する形へ直してある。`N_row` や `M` を増やすときは
必ず対数空間で書くこと。臨界点では `γ` の連続度が悪く（`γ(θ) ~ |θ|`）、リーマン和の収束が
目に見えて遅い（M=10000 で 5e-9 程度）。本文の証明は連続性しか使っていないので結論は変わらない。

---

## 完了（2026-07-26・追補5）: **`T_V_hatZ_hatY` を無条件の定理へ閉じた**（未形式化由来の仮定がゼロに）

### 何が変わったか

`Ising2D/Part008/Definition016_TV.lean` の `TV_hatZ_hatY_of_action` と
`Ising2D/Part008/Definition030_Fermi.lean` の `TV_psiDag_of_action` / `TV_psi_of_action` は、
「`T_{(V_1^{(-)})^{1/2}}` と `T_{V_2}` が `(hat(Z)_μ^{(-)}, hat(Y)_μ)` に `B_1(θ_μ)`, `B_2` で
作用する」ことを**明示的な仮定 `ActsBy`** として持っていた。**この仮定を証明して除去した。**

| ファイル | 内容 |
| --- | --- |
| `lean/Ising2D/Abstract/TVAction.lean` | 抽象版。`Abstract.twoDimConjMat`（exp 共役の 2 次元部分空間への作用行列 `!![cosh s, β sinhc s; α sinhc s, cosh s]`）、`Abstract.exp_conj_two_dim_actsBy`、`Abstract.conj_smul_eq`（スカラー因子は共役で打ち消える） |
| `lean/Ising2D/Part008/Claim012_TVActions.lean` | 具体版。`actsBy_TConj_V1half` / `actsBy_TConj_V2`（原文 `012` の 4 式、**証明済み**）、`TV_hatZ_hatY`（原文 `018` の無条件版）、`TV_psiDag` / `TV_psi` / `TV_psiDag_psi`（原文 `031` の無条件版） |

`lake build` 成功、`scripts/check-no-sorry.sh` exit 0（新規定理 20 本を targets へ追記済み）。
構造化テキスト側の検証 3 種（`npm run check` / `verify-no-lost-proofs` /
`verify-check-linkage`）も通っている。

### 証明の骨格

原文が「入れ子交換子を偶奇で場合分け（`002`）→ テイラー係数の抽出（`005`）」の 2 段で
やっていることは、**「`ad X` が `span{Ẑ_μ^{(-)}, Ŷ_μ}` を保つ」という 1 つの事実に集約できる**。
そこから先は既に形式化済みの `matExp_conj_two_dim_z` / `..._y` が閉じた形を返す。

- `X_1 = (1/2) i K_1 H_1^{(-)}`: (1)(3) より `α = i K_1 e^{-iθ_μ}`, `β = -i K_1 e^{iθ_μ}`, `s = K_1`
- `X_2 = i K_2^* H_2`: (4)(6) より `α = -2i K_2^*`, `β = 2i K_2^*`, `s = 2K_2^*`

`<commutator_of_H_and_Z_Y>` のうち**偽と判明している (2)(5) はこの経路で一切使わない**
（原文 `012` 自身が「`±` はいずれも `-` を選ぶ」と明記している）。

### 原文の検算結果: **誤りは無かった**

係数を原文と独立に導出して突き合わせた結果、原文 `005` / `012` / `018` の
`cosh K_1`, `±i e^{∓iθ_μ} sinh K_1`, `cosh 2K_2^*`, `±i sinh 2K_2^*` は**すべて正しい**。
否定的結果の記録として `docs/tasks/2026-07_original-text-gaps/060_TV_action_coefficients_verified.md`
に残した（`B1mat_eq_twoDimConjMat` / `B2mat_eq_twoDimConjMat` が突き合わせそのもの）。

### 残っている仮定（いずれも数学的に必要。未形式化由来ではない）

1. `hdual : s_2^* c_2 = c_2^*`（双対関係の帰結）と、`IsingConst` の成分が `K_1, K_2^*` の
   双曲線関数であること — 原文が明示していない前提（既知。`030_det_A_theta_duality.md`）
2. `ψ` の反交換関係の `hbr`（平方根の分枝の選択） — **原文の穴ではなく形式化方針に由来する**。
   原文の `√` は `def_sqrt_cc` の単一値写像 `ℂ → ℂ` なので分枝の自由度は無い。Lean 側が
   `t` を「`t^2 = γ_2(θ_μ)γ_2(-θ_μ)` を満たす任意の複素数」として受け取っているために生じる仮定。
   （原文に実際にあった飛躍は「`μ+ν ≡ 0 (mod M)` すなわち `θ_ν = -θ_μ`」の 1 行で、
   正しくは `θ_ν = -θ_μ + 2kπ`。本文側は修正済み。詳細は `050_...md`）

**これで「未形式化に由来する仮定」は本リポジトリから無くなった。**

### 次にやること

`lean/README.md`「今後の方針」の 3.（`V_1, V_2` を `Z, Y, ε` で表す表式）と
4.（`ε` の順序つき積の完全形）へ進む。

## 完了（2026-07-26）: 001 章と 004 章の断絶を解消（章 B・章 B2）— 分配関数から固有値までつながった

### ゴールと結果

前セッションで見つけた断絶——**001 章の成分定義の転送行列と 004 章以降のパウリ行列表示の
`V_1, V_2` を同一視する主張が本文に存在せず、004 章以降が 001 章から切り離された島だった**——を解消した。
`structured-latex/content/010_transfer_matrix_bridge.ts`（13 ブロック、新規）。
これで **分配関数の定義 → 転送行列 → フェルミオン → 固有値** の経路が本文でつながった。

### 記号の対応（一次情報で確定させた）

| | 001 章 | 004 章以降 / 010 章 |
|---|---|---|
| 鎖の長さ（転送行列が作用する向き） | `N` | **`M`** |
| 転送の回数 | `M` | **`N_row`**（004 章以降に対応物が無いので新設） |
| 鎖内（行内）の結合定数 | `J'` | **`K_1`** |
| 鎖間（行間）の結合定数 | `J` | **`K_2`** |

**根拠**: 001 章の `V_1` の指数には `J' μ(j)μ(j+1)`（同一の `μ` の隣接成分＝同一の鎖の隣接サイト）が
現れ、004 章の `V_1 = exp(K_1 Σ σ^z_m σ^z_{m+1})` も同じ役割。`V_2` はどちらも隣り合う 2 本の鎖の
同じサイトどうしを結ぶ。役割が一致するのはこの組み合わせだけである。
**どちらかが「誤り」なのではなく、2 つの章が同じ文字を別の意味で使っていた**というのが結論。

数値でも裏を取った: `N_row ≠ M` のとき `K_1` と `K_2` を取り違えると `Z` と相対誤差 0.09〜0.44 で
合わない（`N_row = M` のときは対称性から一致してしまうので判定から除外した）。

### 章 B（橋渡し）で示したこと

- `def_config_basis_iso`: 配置 `μ` と標準基底 `f_I` の全単射 `ι`（`μ(m)=+1 ↦ i_m=1`）。
  001 章が「全単射をひとつ固定して同一視する。取り方に依らない」と述べていた自由度をここで固定した。
- `sigma_z_diagonal_action`: `σ^z_m f_{ι(μ)} = μ(m) f_{ι(μ)}`。
- `exp_of_diagonal_matrix`: 対角行列の exp（成分ごとの収束で示した）。
- `V1_component_equals_pauli`: `V_1` は両定義で一致（**数値では残差 0.00e+00 の厳密一致**）。
- `two_by_two_transfer_identity`: `[[e^{K_2}, e^{-K_2}],[e^{-K_2}, e^{K_2}]] = (2 sinh 2K_2)^{1/2} exp(K_2^* σ^x)`。
  ここで双対関係 `K_2^* = -½ log tanh K_2` が効く。前因子 `(2 sinh 2K_2)^{M/2}` の由来はこれ。
- `V2_component_equals_pauli`: `V_2` も一致（`A` のクロネッカー冪を経由）。
- `partition_function_in_pauli_form`: `Z(J,J') = tr((V_1V_2)^{N_row})` を 004 章の記号で書き直した。

### 章 B2（偶奇セクター分解）で示したこと

- `def_epsilon_projectors` / `epsilon_projector_properties`: `P^{(±)} = (I ± ε)/2`、`im P^{(±)} = F^{(±)}`。
- `epsilon_commutes_with_transfer_matrices`: `ε` は `V_1, V_2, V_1^{(±)}, (V_1^{(±)})^{1/2}` と可換。
- `sector_replacement_of_V1`: `V_1 P^{(±)} = V_1^{(±)} P^{(±)}`。
- `sector_replacement_pow`: 上の置き換えを `(V_1V_2)^n P^{(±)}` の冪へ反復する公式。
- `partition_function_sector_decomposition`:

```
Z(J,J') = tr( P^{(+)} (V^{(+)})^{N_row} ) + tr( P^{(-)} (V^{(-)})^{N_row} )
        = ½( tr((V^{(+)})^n) + tr(ε(V^{(+)})^n) + tr((V^{(-)})^n) − tr(ε(V^{(-)})^n) )
```

**当初ロードマップに書いた「`ε` をフェルミオン数で書く」は、ここまでには不要だった。**
射影子を使えば `ε` を書き直さずに到達できる。ただし章 C で `tr(ε (V^{(±)})^{N_row})` を
固有値で評価する段では要る見込みなので、そのときは符号を数値で先に確定させること。

### 数値検証: `sagemath/check/043_claim_transfer_matrix_bridge/`（5 チェック、全 PASS）

`M = 2,3,4`、`(K1,K2)` 数組。`V_1` の一致は**残差 0.00e+00（厳密）**、他は 3e-14 以下。
**check_04 は分配関数の定義（`2^{N_row·M}` 通りのスピン配置の直接和）から出発している**ので、
001 章の `partition_function_via_transfer_matrix` の独立な再確認にもなっている。
直接和のコストの都合で `N_row·M ≤ 9` に限った（`M=4` は `N_row=2` のみ）。実行ログは `run-log.txt`。

### 次にやること

**章 C（最大固有値）。** `partition_function_sector_decomposition` の右辺へ
`eigenvalues_of_V` の `Λ_ε` を代入するところから始める。詳細は
`docs/tasks/free-energy-roadmap/task-dependency-graph.md`（章 A・B・B2 は完了に更新済み）。

---

## 完了（2026-07-26）: 数値検証（SageMath）のカバレッジを 7 ラベル → 96 ラベルへ拡張

### やったこと

数値検証が紐づいていたラベルは **7 件**しかなかった。これを **97 件**へ広げた
（`sagemath/tools/verify-check-linkage.ts` が確認する check は 9 → 99 件）。
作業中に別セッションが本文を TypeScript 化し、本文のラベル総数も 128 → 146 件へ増えている。

土台として `sagemath/_shared/operators.sage` を新設した。ここが無かったことが、
これまでカバレッジが広がらなかった直接の原因である（`Mat(2,C)^{⊗M}` の元を数値で作る手段が無く、
既存の検証が 2×2 のスカラー式レベルに限られていた）。

- **`_shared/operators.sage`**: Pauli 行列・`σ^a_k`・Jordan–Wigner 文字列 `Z_m, Y_m`・`ε`・
  `V_1, V_2`・`H_1^{(±)}, H_2`・`V_1^{(±)}`・`hatZ^{(±)}_μ, hatY_μ`・`ψ_μ, ψ^†_μ`・
  `A(θ), B_1, B_2`・本プロジェクト定義の `sqrt` と `arg^{[0,2π)}` を、
  **具体的なクロネッカー積**（numpy complex128、行列指数は `scipy.linalg.expm`）で構成する。
  合否レポート `CheckReport` は**相対誤差**で判定する（`c_1 = cosh 2K_1` が 1e8 規模になるため）。
- **`sagemath/README.md`**: ディレクトリ構成、`overview.md` の必須要件、2 つの共有ライブラリの
  使い分け、不一致が出たときは本文を直さず MEMORY.md に記録する方針。
- **`sagemath/tools/run-all-checks.sh`**: 全 check を実行して各ディレクトリの `logs/` へ保存する。
- 各 check は `check_*.sage`（コード）＋ `logs/*.log`（**実際の実行出力**）＋ `overview.md`（README 兼）。
  overview の判定数・最大相対誤差は**ログから機械的に転記**しており、手で書いた数値ではない。

### 検証の設計方針（同語反復を避ける）

定義をそのまま両辺に書いて比べる check は作らない。必ず**独立な経路**を突き合わせる。例:

- `partition_function_via_transfer_matrix`: 全 2^{MN} 配位のブルートフォース vs 転送行列のトレース。
- `matrix_exp_conjugation`: 行列指数による共役 vs m 重交換子の級数 vs `ad_X` を n²×n² 行列表示した指数（3 経路）。
- `V1_in_Z_Y_epsilon` と `V2_in_Z_Y`: `σ^zσ^z / σ^x` による定義 vs `Z, Y, ε` による表示。
- `sqrt_expansion_via_polar`: `pr_1, pr_2, s_{[0,2π)}` 経由の定義式 vs 代表元 `(r,θ)` からの構成。
- 複素数まわりは `_prelude.sage` で `φ_polar, φ_cartesian, pr_1, pr_2, s_{[0,2π)}`、
  さらに非負実数の平方根まで**二分法で自前に組み直して**おり、標準ライブラリに依存しない。

**仮定の必要性**も併せて確認している（可換でないと `exp A exp B = exp(A+B)` が破れる、
反可換サイトが 2 つだとテンソル積が反交換にならない、`J` と `J'` を入れ替えると分配関数が合わない、等）。
**臨界点ちょうど**（`K_1 = arcsinh(1/sinh 2K_2)/2`）のパラメータを明示的に作って踏んでいる
（`γ_2 = 0` はそこでしか起きないため。実際に 24 事例踏んでいる）。

### 見つかった不一致（本文は修正していない）

下の「## 数値検証で見つかった不一致」節に詳細。**本文の編集は別セッションの担当範囲なので触っていない。**

### ついでに塞いだ検証ハーネスの穴（重要）

既存の `_shared/defs.sage` の `numerical_check` は、**`RESULT: FAIL` を出しても終了コード 0 を返していた**。
そのため `run-all-checks.sh` が失敗を PASS と誤認していた（実際 `028_claim_a_theta_mu/check_06` が
FAIL のまま見逃されていた）。次の 2 点で塞いだ。

1. `numerical_check` を**相対誤差**判定に変え、失敗時に `sys.exit(1)` するようにした。
   絶対誤差 1e-10 で判定していたため、値が 6.4e3 規模の式で倍精度の丸め（相対 3e-13）を
   「不一致」と報告していた。相対誤差に変えたことで 028 の check_06 は PASS になった。
2. `run-all-checks.sh` が、終了コードに加えて**ログ本文の `RESULT: FAIL` も失敗として拾う**ようにした。

### 未カバーのラベルとその理由

残りはほぼ**定義ブロック**（`def_*`）で、それ単体では反証できる等式を持たない
（`def_exp`, `def_abs_arg`, `def_transfer_matrix_symbols`, `def_fermi` など）。
これらは、それを使う主張の check の中で実質的に検算されている。
例外的に計算で確かめられる定義（`def_kronecker` の添字写像 ν の全単射性など）は check を立てた。

`exact_sequence_of_aut` ほか群の一般論のラベルに対しては check を書いたが、
**作業中に別セッション（コミット `e181c2c`）が該当ブロックを本文から削除した**ため、
紐づけ先が消えて `verify-check-linkage.mjs` が通らなくなり、その check は取り下げた。
群の一般論は本文から排除する方針（プロジェクト README）なので、これは正しい状態である。

## 数値検証で見つかった不一致

### `commutator_of_H_and_Z_Y`（`008_TV1_hatZ_hatY_part1.mjs`）の 6 式のうち 2 式

`sagemath/check/195_commutator_of_H_and_Z_Y/` に、成り立つ 4 式（`check_01`）と
**成り立たない 2 式**（`check_02`）を分けて置いた。`check_02` は「本文の式が一致しないこと」と
「どの形なら一致するか」の両方を固定しているので、本文を直せばこの check が壊れて気づける。
実行ログは同ディレクトリの `logs/` にある。

**(a) `[H_1^{(±)}, hatZ_μ^{(∓)}] = 2 e^{-i 2πμ/M} hatY_μ` は成り立たない。**

- 本文の式との差は、max ノルムでちょうど **4**（同符号版 `[H_1^{(±)}, hatZ_μ^{(±)}]` は機械精度で一致する）。
- 成り立つ形: `[H_1^{(±)}, hatZ_μ^{(∓)}] = 2 e^{-iθ_μ} hatY_μ − 4 e^{-iθ_μ} Y_M`。
- 由来: `hatZ^{(-)}_μ − hatZ^{(+)}_μ = 2 Z_1 e^{-iθ_μ}` と `[H_1^{(±)}, Z_1] = ∓2 Y_M`。
  後者は `[Y_mZ_{m+1}, Z_1] = 0`（m < M）と `[∓Y_MZ_1, Z_1] = ∓2Y_M` から従う。

**(b) `[H_2, hatZ_μ^{(+)}] = −2 hatY_μ + (1/M)Σ_j(−2 e^{−i(2π/M)(−j+μ)} hatY_j)` は成り立たない。**

- 補正項の係数が **−2 ではなく +4** でなければ合わない。
- 成り立つ形: `[H_2, hatZ_μ^{(+)}] = −2 hatY_μ + (4/M)Σ_j e^{−i(2π/M)(μ−j)} hatY_j = −2 hatY_μ + 4 e^{−iθ_μ} Y_1`。
- 由来: `[H_2, Z_1] = −2 Y_1` と、`Y_1 = (1/M)Σ_j hatY_j e^{i2πj/M}`（`recover_Z_Y_from_hatZ_hatY`）。

どちらも **M = 2,3,4,5 の全 μ、両符号**で、修正形が相対誤差 ~1e-15 で一致することを確認済み。
なお `nesting_of_commutator_of_H_and_Z`（196）は同符号の組み合わせしか使っていないので、
この不一致の影響を受けない（196 は 2268 件すべて PASS）。
`198_holonomic_p142` の実行ログにも、`V_1^{(+)}` の平方根で `hatZ^{(-)}` を共役すると
閉じた表示からずれることが観察値として記録してある（同じ原因）。

### 本文の主張ではなく浮動小数点の問題だったもの（記録）

`λ_± = γ_1 ± √(−γ_2(θ)γ_2(−θ))` の平方根の中身は、`relation_of_gamma_2` により厳密には
非負実数 `|γ_2|²` である（227 で独立に検証済み）。ところが倍精度では虚部に ~1e-17 の丸めが乗り、
それが負側に出ると `arg^{[0,2π)}` が 0 ではなく ~2π を返すため、本プロジェクト定義の `sqrt`
（偏角を半分にする分枝）が**符号を反転させてしまう**。主張の誤りではないので、
`_shared/operators.sage` の `lambda_pm_of` で虚部が無視できるときは実軸へ落とす処理を入れ、
理由をコードのコメントに明記した。

## 完了（2026-07-26・追補4）: ソース形式を TypeScript に完全統一（`.mjs` を全廃）

**このプロジェクトに `.mjs` は 1 ファイルも残っていない。** 混在させると片方が型検査の網から漏れるため。

- `content/` 15 ファイル・`notes/` 8 ファイルを `.ts` へ変換（`tools/codemod-mjs-to-ts.ts --apply`、
  `git mv` で履歴維持）。変換は import 行の書き換え・未使用 import の除去・本文中の
  自ファイルパス参照（`sourcePath` 等）の追随だけで、**証明の中身は 1 文字も変えていない**。
- `schema.mjs`、`tools/*.mjs` の互換入口、`tsconfig.mjs-content.json`（checkJs 用）を削除。
- `sagemath/tools/verify-check-linkage.ts` も `.ts` 化し、ラベル一覧は
  `structured-latex/labels.generated.ts` を直接読むようにした（読み込み処理の重複を解消）。
- `tools/content-modules.ts` は `content/` `notes/` に `.mjs` を見つけたらエラーで落とす（再発防止）。
- ビューア（realtime-web-preview）の入力ソースも `.ts` のみに統一。
  ビルド・型検査・lint と、HTTP 経由で 173 blocks / 38 notes の配信を確認済み。
- レビュー第2ラウンドの指摘も反映: 定理型ブロックの `level` を実行時にも拒否、
  `verify-no-lost-proofs` は `sourcePath` が実在しないブロックをエラーにする（黙って skip しない）、
  codemod の裸ファイル名置換をパス区切りで限定、実行時検証テストの判定を厳密化。

**784 箇所の相互参照がすべて `.ts` として型検査される状態になった。**
## 完了（2026-07-26・追補）: `H_1, H_2` の hat 表示と 6 本の交換関係を Lean で形式化（**原文の誤り 2 件を検出**）

### 成果物

| ファイル | 内容 |
| --- | --- |
| `lean/Ising2D/Part004/Claim011_H1H2ViaHat.lean` | `<H1_H2_via_hatZ_hatY>` の具体版（`H_1^{(±)} = (1/M)∑_j e^{-i2πj/M} hat(Y)_j hat(Z)^{(±)}_{-j}`、`H_2 = (1/M)∑_j hat(Z)^{(-)}_{-j} hat(Y)_j`） |
| `lean/Ising2D/Part008/Claim001_CommutatorHZY.lean` | `<commutator_of_H_and_Z_Y>` の具体版（6 本） |
| `lean/Ising2D/Abstract/CommutatorClifford.lean` | 同ラベルの抽象版（`Ising2D.Abstract.CliffordTriple`） |

`lake build` 成功、`scripts/check-no-sorry.sh` exit 0（新規定理はすべて targets へ追記済み）。

### 抽象版で分かったこと

6 本の交換関係に効いているのは `[a b, c] = a[b,c]₊ - [a,c]₊ b` と
「反交換子が係数のスカラー倍の `1` になること」だけである。`hat(Z), hat(Y)` の具体形も、
行列であることも、`D` の中身（`2M δ^M`、`-4 e^{-i2π(μ+ν)/M}`）も効いていない。
`hat(Z)^{(±)}` と `hat(Z)^{(∓)}` の差は「`D_z` と `D_{z'}` という別のスカラー関数」に
抽象化でき、原文が符号で書き分けている 6 本は
「積の並びが `y z` か `z y` か」×「交換相手が `z` / `z'` / `y`」の 6 通りに対応する。

### **原文の誤り 2 件（本文修正は別セッションの担当）**

対象ブロック: `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs` の
`TV1_hatZ_hatY_001_claim_commutator_H_Z_Y`（ラベル `commutator_of_H_and_Z_Y`）。

1. **第 2 式 `[H_1^{(±)}, hat(Z)_μ^{(∓)}] = 2e^{-iθ_μ}hat(Y)_μ` は偽。**
   正しくは `2e^{-iθ_μ}hat(Y)_μ - 4e^{-iθ_μ}Y_M`。
   原文自身が最終段で余分な項 `-(4/M)e^{-iθ_μ}∑_{k=1}^M Y_k M δ^M_{(k,0)}` を持ちながら
   それを `0` と置いている。`k ∈ {1,…,M}` で `δ^M_{(k,0)} = 1` になるのは `k = M` なので、
   この項は `-4e^{-iθ_μ}Y_M` であって消えない（`Y_M^2 = I` より `Y_M ≠ 0`）。
   当該ブロックの `conversion.notes` にも「原文の該当ステップの正当化は不完全」と記録済み。
   Lean: 訂正版 `Ising2D.lie_H1_hatZ_opp`、偽であることの証明 `lie_H1_hatZ_opp_ne_orig`。
2. **第 5 式 `[H_2, hat(Z)_μ^{(+)}] = -2hat(Y)_μ + (1/M)∑_j(-2e^{-i(2π/M)(-j+μ)}hat(Y)_j)` は偽。**
   正しくは `-2hat(Y)_μ + 4e^{-iθ_μ}Y_1`。原文は `-[hat(Z)_μ^{(+)}, hat(Z)_{-j}^{(-)}]₊` の展開で
   マイナス符号を第 1 項にしか分配しておらず、次の行で係数 `4` も `2` に化けている。
   独立な検算（`hat(Z)^{(+)}_μ = hat(Z)^{(-)}_μ - 2e^{-iθ_μ}Z_1` と `[H_2, Z_1] = -2Y_1`）でも
   訂正版と一致する。Lean: `Ising2D.lie_H2_hatZPlus` / `lie_H2_hatZPlus_ne_orig`。

**波及範囲**: 後段（`nesting_of_commutator_of_H_and_Z` 以降）が使うのは (1)(3)(4)(6) の 4 本だけで
（当該ブロックの proof が (A)(B)(C)(D) として明示している）、誤っている (2)(5) は使われていない。
したがって結論には波及しない。**本文の修正は `docs/tasks/2026-07_original-text-gaps/` と同じく
別セッションの担当**（このセッションは `structured-latex/content/` を編集していない）。

### 次にやること

`<H1_H2_via_hatZ_hatY>` と `<commutator_of_H_and_Z_Y>` が揃ったので、
`Ising2D.matExp_conj_two_dim_z` / `..._y`（`Part008/Claim006_ExpConjugation.lean`）へ代入すれば
`<extract_taylor_coefficient_of_Z_Y>` の 4 式が出る。そこまで行けば
`TV1_hatZ_hatY_012_claim_TV1_TV2_actions` が証明でき、`Ising2D.TV_hatZ_hatY_of_action` の
仮定 `hT1`, `hT2` を外して `T_V_hatZ_hatY` を無条件の定理にできる。

---

## 完了（2026-07-26・追補3）: structured-latex の TypeScript 化（第1段：基盤・スキーマ・ツール）

**目的**: 「存在しない定理・ラベルへの参照」を実行時の検証スクリプトではなく**コンパイル時**に落とす。

- `schema.mjs` → **`schema.ts` が型と実行時検証の正本**。`schema.mjs` は再エクスポートだけの互換入口
  （未変換の `content/*.mjs` が読むため。全変換後に削除する）。手書きの `schema.d.ts` は削除。
- `tools/generate-labels.ts` が `content/` の実在ラベル 146 件を集めて **`labels.generated.ts`**
  （ユニオン型 `Label`）を生成する。`ref(target: Label)` / ノートの `targets: [Label, ...Label[]]` /
  ブロックの `labels: readonly Label[]` がこの型で縛られる。
- 型で落ちるようになったもの: 存在しないラベルへの参照・ノートの紐づけ、未登録ラベルの宣言
  （＝生成物の再生成漏れ）、`targets` の空配列、見出しへの本文混入、本文ブロックの `notes`。
- **未変換の `content/*.mjs` も既に型検査されている**（`tsconfig.mjs-content.json` の
  `allowJs` + `checkJs`。`schema.mjs` が `schema.ts` の再エクスポートなので型が流れる）。
  つまり「存在しないラベルへの参照をコンパイル時に落とす」は第2段を待たずに達成済み。
- 実証: `node tools/negative-type-test.ts`（正しいラベル版が通り、壊した版で tsc が落ち、
  診断が当該ラベルを指すことまで確認。`.ts` 経路と `.mjs` 経路の両方）。
  回帰は `type-tests/label-typing.test-d.ts`。CI は `.github/workflows/structured-latex-check.yml`。
- ツールも TS 化（`validate-content.ts` / `verify-no-lost-proofs.ts` / `extract-source-blocks.ts`）。
  CLAUDE.md が案内する `.mjs` のコマンドは同名の互換入口として残してある。
  `extract-source-blocks` は原本の退避（`_old/typst/`）に追随していなかったので参照先を直した。
- 実行方式: **Node 22.18+ の型ストリップで `.ts` を直接実行する**（`dist/` を作らない。`tsc` は検査専用）。
  ビューア（realtime-web-preview）の入力ソース読み込みも `.mjs` / `.ts` の両対応にし、
  変換後の `.ts` content を実際に配信できることを確認済み（173 blocks / 38 notes）。
- **フィールド名の打ち間違い（`proof` → `proofs` 等）も落ちる**: `defineBlocks` を非ジェネリックに
  戻して余剰プロパティ検査を効かせ、実行時にも未知キーで throw する（`tools/schema-runtime-test.ts`）。
  レビューで「証明が黙って消える経路」として指摘された穴を塞いだもの。
- 一括検査: `cd structured-latex && npm run check`（初回のみ `pnpm install`）。
  中身は 生成物の鮮度 → 型検査(.ts) → 型検査(.mjs) → 実行時検証 → 移行漏れ検出 → 負テスト → 実行時検証テスト。

**第2段（content/notes の一括 `.ts` 変換）は未実行**。別セッションが記法置換（⊗→⊠）で
content を書き換え中のため衝突を避けた。変換は `node tools/codemod-mjs-to-ts.ts --apply`
（既定は dry-run。`--out-dir` で試験変換）。**試験変換 23 ファイルは既に型検査を通ることを確認済み**
なので、記法置換が main に入り次第そのまま実行してよい。

## 完了（2026-07-26・追補2）: Lean 形式化が検出した本文の穴 5 件を content 側で解消

対象は `structured-latex/content/008_TV1_hatZ_hatY_part2.mjs` のみ（ラベルは一切変更していない）。

1. **`anticommutator_of_psi`（ψ の反交換関係）— 平方根の分枝の一致が暗黙だった。**
   statement に「ここでの √ は `def_sqrt_cc` の単一値写像 ℂ→ℂ である」ことを明記し、proof に Step 0 を追加。
   Step 0-1（γ_2 の 2π 周期性）→ 0-2（μ+ν ≡ 0 mod M ⟹ θ_ν = -θ_μ + 2kπ ⟹ 根号の中身が ℂ の元として一致）
   → 0-3（√ が写像であることから t_ν = t_μ、±の自由度は無い）→ 0-4（t_μ ≠ 0 なので、逆分枝を取ると
   第 1 式・第 2 式が偽になる＝分枝の一致は不可欠）。旧 proof の「θ_ν = -θ_μ」という誤った 1 行も直した
   （正しくは 2π の差を許す）。
2. **`det_A_theta` — 双対関係 c_2 s_2^* = c_2^* が明示されていなかった。** proof を書き直し、
   `factorization_of_A_theta` 経由（この分解自体に双対関係が埋め込まれている）ではなく `def_A_theta` の
   定義から直接 det A = γ_1^2 + γ_2(θ)γ_2(-θ) を計算し、(i) c_1^2-s_1^2=1、(ii) (c_2^*)^2-(s_2^*)^2=1、
   (iii) c_2 s_2^* = c_2^*（`duality_c2_star_eq_s2_star_c2`）の 3 関係を使う 6 ステップに分けた。
   (iii) を落とすと det A は θ に依存し 1 にならない（数値で確認済み: 1.06, 1.31, 2.17, …）。
   statement 側にも前提 K_1,K_2 ∈ R_{>0} を補い、λ_+λ_- = 1 の証明も追加した（原文には無かった）。
3. **`gamma_2_theta_is_0` — s_2^* ≠ 0 が暗黙だった。** Step 0 で K_2 > 0 ⟹ 0 < tanh K_2 < 1 ⟹
   K_2^* > 0 ⟹ s_2^* = sinh 2K_2^* > 0 を 1 段ずつ書き、s_2^* ≠ 0 を statement にも明記した。
4. **同ブロック — sin θ_μ = 0 の μ 表現。** Step 3' を新設し、sin θ_μ = 0 ⟺ M | 2μ ⟺
   (M が奇数) μ ≡ 0 (mod M) / (M が偶数) μ ≡ 0 または M/2 (mod M) と正しく書いた。
   「sin θ_μ = 0 ⟺ μ = ±M」は偽であることを明示。最終結論は変わらず、μ = ±M/2 の排除は Step 4 の
   c_2 s_1 = -c_1 < 0 と正値性の矛盾で行う。
5. **`diagonalization_P_D` — P_μ の可逆性が未確認だった。** proof を 6 ステップに分け、
   det P_μ = i√(γ_2(θ_μ)γ_2(-θ_μ))/(2M γ_2(-θ_μ)) を計算し、γ_2(θ_μ) ≠ 0（⟹ 根号の中身 -|γ_2|^2 ≠ 0）と
   M ≥ 1 の下で非零であることを示した（Lean の `det_Pmat`/`det_Pmat_ne_zero` と同じ計算。数値でも一致）。
   AP = PD から A = PDP^{-1} への移行も分けて書いた。

検証は `validate-content` / `verify-no-lost-proofs` / `verify-check-linkage` の 3 本とも通過。
Lean 側は本作業では触っていない。

## 完了（2026-07-26）: 残る全章の抽象テンソル積記法をクロネッカー積へ置換（本文の `\otimes` を 0 件に）

006/007 章に続き、**残っていた 489 箇所**に加え、作業中に origin/main から合流した新章 010（22 箇所）も置換した。
これで `structured-latex/content/` 全 16 ファイルに抽象テンソル積の記法は 1 箇所も残っていない（README 2 節のゴール設定を本文が満たした）。

| ファイル（章の内容） | 置換前 | 置換後 |
| --- | ---: | ---: |
| 002 線型空間の一般論 | 20 | 0 |
| 004 転送行列 | 372 | 0 |
| 008 T_(V1) と hatZ/hatY の関係（前半） | 49 | 0 |
| 008 同（後半） | 37 | 0 |
| 009 V の固有値 | 11 | 0 |
| 010 転送行列と Pauli 表示の橋渡し（マージ後に合流した新章） | 22 | 0 |

- 記法: `A_1⊗⋯⊗A_M` → `A_1⊠⋯⊠A_M`、`Mat(2,C)^{⊗M}` → `Mat(2^M,C)`、
  `(C^2)^{⊗M}` → `C^{2^M}`、`I_{(Mat(2,C))^{⊗M}}` / `I_{(C^2)^{⊗M}}` → `I_{Mat(2^M,C)}`。
- **`def_kronecker` の「⊗ は ⊠ の別記法」という同一視の注記を削除した。** 本文に ⊗ が無くなり
  役目を終えたため。代わりに「クロネッカー積が住む空間は何か」を述べる段落へ置き換えた。
- **新設した主張: `kronecker_transpose`（クロネッカー積の転置は因子ごとの転置）。**
  009 章の実対称性の議論が `(A_1⊗⋯⊗A_M)^T = A_1^T⊗⋯⊗A_M^T` を**根拠なしに**使っていた。
  クロネッカー積の成分の定義から証明できるので 002 章に主張として置き、009 から参照させた。
  （ラベルが 146 → 147 件に増えたので `labels.generated.ts` を再生成済み。）
- 根拠の付け替え（単なる文字列置換にせず、具体的な行列計算として読めるようにした箇所）:
  - 008 前半「テンソル積の積は成分ごとの積である」→ `<kronecker_product_rule>` (1) と
    `<kronecker_multilinear>` への参照。
  - 008 前半「異なるテンソル因子にのみ非自明に作用するので可換」→ 他サイトが `I_{Mat(2,C)}` に
    なることと `<kronecker_product_rule>` (1) による可換性の説明。
  - 009「テンソル積代数の積の定義より因子ごとの積になるため」→ 同上。
  - 009 の `U := EF` の因子が可換であることの根拠に `<kronecker_product_rule>` (1) を明示。
  - 004 の記号定義にあった「⊗ は ⊠ の別記法であり Mat(2^M,C) は Mat(2^M,C) のこと」という
    同一視の橋渡し段落と、`def_end_iso` の `F := (C^2)^{⊗M} = C^{2^M}` が置換で同語反復に
    なるので、意味のある文へ書き直した。
- 参照用ノート側も、**本文の対象を指していた** ⊗ 表記（008 の 2 ノート・009 クリフォード代数ノート、
  計 14 箇所）を同じ規則で直した。`notes/002_linear_space_general.ts` の ⊗（5 箇所）は
  **抽象テンソル積そのものを論じる読み物**（本文に採用しなかった経路の記録）なので**意図的に残した**。
- 証明の内容・段階構造・ラベルは変更していない。変更した 41 ブロックには何をどう置換したかを
  `conversion.notes` に記録した。
- 検証: `npm run check`（ラベル生成物の同期・型検査・内容検証 188 ブロック 897 参照・移行漏れ・
  負テスト・実行時テスト）と `sagemath/tools/verify-check-linkage.ts`（100 check）をすべて通した。

## 完了（2026-07-26）: 006 章・007 章の抽象テンソル積記法をクロネッカー積へ置換

`Z と Y の反交換関係`（006）と `hatZ と hatY の反交換関係`（007）から、抽象テンソル積の記法を
すべて排除した。002 章に新設された `def_kronecker` / `kronecker_product_rule` /
`kronecker_multilinear` を参照する形へ直してある。

- 記法: `⊗` → `⊠`（006 で 208 箇所）、`Mat(2,C)^{⊗M}` → `Mat(2^M,C)`、
  `I_{(C^2)^{⊗M}}` → `2^M` 次の単位行列 `I_{Mat(2^M,C)}`。両ファイルとも `\otimes` は 0 件。
- 根拠の付け替え: 「テンソル積代数の積の定義」→ `<kronecker_product_rule>` (1)、
  「テンソル積の第 j 因子についての C-線型性」→ `<kronecker_multilinear>`、
  `I⊠⋯⊠I = I_{Mat(2^M,C)}` → `<kronecker_product_rule>` (2)。
- 併せて直した点: (a) 006 の μ>ν の場合に符号 −1 を外へ出す 3 箇所が根拠無しだったので
  `<kronecker_multilinear>` を明示した。(b) 007 の第 1 式・第 4 式の右辺の単位行列が裸の `I` で
  何次か不定だったので `I_{Mat(2^M,C)}` に揃え、等式が `2^M` 次の複素行列の等式であることを
  statement 冒頭に明示した。
- 証明の内容・段階構造・ラベルは変更していない。検証は validate-content /
  verify-no-lost-proofs / verify-check-linkage をすべて通した。

**（その後の追記）** ここで未了としていた 002/004/008/009 の置換は、上記
「残る全章の抽象テンソル積記法をクロネッカー積へ置換」で完了済み。同一視の注記も削除された。

## 完了（2026-07-26）: 自由エネルギーまでの道筋を確定し、その最初の章（定数 c と V の固有値）を執筆

### ゴールと結果

`V_eq_Vprime`（`V = cV'`）から先が本文に一切存在しなかった（「自由エネルギー」「熱力学極限」は
content・notes とも 0 件）。この未到達部分について **(1) 依存順の章立てを作り、(2) 最初の章を書き切った。**

### (1) 章立て: `docs/tasks/free-energy-roadmap/task-dependency-graph.md`

章 A（定数 c と V の固有値・**本セッションで執筆済み**）→ 章 B（001 章と 004 章の橋渡し）→
章 B2（ε の偶奇セクター分解）→ 章 C（最大固有値）→ 章 D（自由エネルギーと熱力学極限）→ 章 E（臨界点）。

**調査で見つかった重大な断絶（次に着手すべき最優先事項）**:
001 章の転送行列（成分で定義された `V_1,V_2 ∈ Mat(2^N,C)`、`Z = tr((V_1V_2)^M)`）と、
004 章以降の `V_1,V_2 ∈ Mat(2,C)^{⊗M}`（σ 行列で定義）を**同一視する主張がどこにも無い**。
`partition_function_via_transfer_matrix` を参照しているブロックは content 全体で **0 件**で、
004 章以降は 001 章から切り離された島になっている。**固有値をいくら求めても、この橋が無いと分配関数へ戻れない。**
加えて 001 章は「M 行 N 列」、004 章以降は鎖長が M で、**M と N の役割が入れ替わっている**。

### (2) 執筆した章: `structured-latex/content/009_eigenvalues_of_V.mjs`（18 ブロック）

主結果:

```
c = (2 sinh 2K_2)^{M/2},   すなわち V = (2 sinh 2K_2)^{M/2} V'
Λ_ε = (2 sinh 2K_2)^{M/2} exp( Σ_{μ∈I} γ(θ_μ)(ε_μ − 1/2) )     (ε ∈ {0,1}^I)
Λ_max = (2 sinh 2K_2)^{M/2} exp(+½ Σ γ(θ_μ)),  Λ_max·Λ_min = c²
```

内訳: トレースの定義と基本性質 / 冪等行列のトレース＝像の次元 / フェルミオン数演算子
`n_μ := ψ_μ† ψ_{-μ}` の冪等性・可換性・`tr(n_{μ1}⋯n_{μk}) = 2^{M-k}` / 同時固有空間分解
（`Q_ε` が直交冪等系をなし `tr(Q_ε) = 2^{M-m}`）/ `V'` の固有値と `tr(V') = tr(V'^{-1}) > 0` /
共役転置・エルミート・正定値の定義 / エルミート行列の exp は正定値 /
`i K_1 H_1^{(±)}` と `i K_2^* H_2` が実対称であること / `V` の正定値性（⟹ `tr(V) > 0`）/
符号反転共役 `U` / `c` の決定 / `V` の固有値。

**採った証明方針（重要・行列式を使わない）**: `V` と `V'` の固有値の積を比べる素直な経路は
`det(AB) = det A det B` を要し、置換と符号の一般論を本文へ持ち込むことになる（README 2 節の基準に反する）。
代わりに

- `tr(V)/tr(V^{-1}) = c²`（`tr(V') = tr(V'^{-1}) ≠ 0` から）
- 符号反転共役 `U = (Π_{m odd} σ^x_m)(Π_m σ^z_m)` による `tr(e^{S_1}e^{S_2}) = tr(e^{-S_1}e^{-S_2})`
  （⟹ `c² = (2s_2)^M`）
- `V` が実対称正定値（⟹ `tr(V) > 0` ⟹ `c > 0`）で符号を確定

という経路を採った。この `U` は **M の偶奇にも `H_1` の符号 (±) にもよらず**働く（数値でも残差 0）。

### 数値検証: `sagemath/check/042_claim_constant_c_and_eigenvalues_of_V/`（5 チェック、全 PASS）

`M = 2,3,4,5`、`(K1,K2)` 10 組、`H_1^{(+)}`/`H_1^{(-)}` 両符号。
`i K_1 H_1^{(±)}` と `i K_2^* H_2` の実対称性、および符号反転共役は**残差 0.00e+00（厳密）**。
`c = (2 sinh 2K_2)^{M/2}` は相対誤差 7.6e-15 以下。実行ログは `run-log.txt`。

**check_04 は本文の証明を再現していない**（`V` と `V'` を定義から独立に構成して `V'^{-1}V` を
直接計算している）ので、本文の証明が誤っていても結論の正しさは独立に担保される。

### 注意（次に触る人へ）

- **臨界点（`m = M−1`、`γ_2(θ_M) = 0`）は数値検証に含めていない**（浮動小数で `γ_2 = 0` の判定が
  不安定なため）。本文の証明は `m` を一般のままにしてあるので臨界点でも通るが、数値の裏付けは無い。
- 章 B2-5（`ε` をフェルミオン数で書く）は符号が自明でないので、**数値で先に確定させてから**書くこと。
- 記法をクロネッカー積へ書き換える横断リファクタは別セッションの担当。009 章も既存の
  `Mat(2,C)^{⊗M}` 記法に合わせてあるので、リファクタ時に一緒に書き換える対象になる。

---

## 完了（2026-07-26・追補）: ψ の反交換関係に**抽象版**を追加し、分枝の必要性を定理として証明

同じブロック（`anticommutator_of_psi`）の形式化が並行トラックで先に main へ入っていたため
（`lean/Ising2D/Part008/Definition030_Fermi.lean`）、**既存ファイルには一切手を触れず**、
README のゴール設定 4 節が要求する「具体版＋抽象版の 2 本立て」の**抽象版**だけを
新規ファイル 2 本として追加した（抽象版の置き場所は先行トラックが定めた規約に合わせ、
`lean/Ising2D/Abstract/`・名前空間 `Ising2D.Abstract` とした）:
`lean/Ising2D/Abstract/Fermion.lean`（抽象版）と
`lean/Ising2D/Part008/Claim032_AnticommutatorPsiAbstract.lean`（具体版の導出と分枝の必要性）。

- 抽象版 `Ising2D.Abstract.acomm_lincomb_clifford` / `Ising2D.Abstract.car_of_coeffs`:
  **4 元の反交換関係と係数のスカラー恒等式 2 本だけ**を仮定した形（係数は任意の可換環、台は任意の環）。
  行列であることも `hat(Z)`, `hat(Y)` の具体形も `γ_2`・`δ^M` も使わない。
  持ち込んだ抽象化は ℂ-代数までで、テンソル積の一般論は使っていない。
- 具体版が抽象版の特殊化で得られることを `acomm_psi_relations_of_car`
  （既存の 3 定理と同じ主張を抽象版の系として導出）と
  `acomm_hatZMinus_hatY_lin2_of_abstract` で明示した。
- **平方根の同一分枝の仮定 `hbr` が省略できないことを定理として証明した**:
  `M ∣ μ+ν` かつ `t_ν = -t_μ`（逆分枝）のとき
  `acomm_psiDag_psiDag_of_opposite_branch` により `[ψ_μ^†, ψ_ν^†]₊ = I ≠ 0`、
  `acomm_psiDag_psi_of_opposite_branch` により `[ψ_μ^†, ψ_ν]₊ = 0`（本来 `I` のはず）。
  すなわち原文第 1 式・第 2 式は逆分枝では**偽**である。
  なお原文の `√` を「積の値だけで決まる単一値関数」と読めば逆分枝は起こらないので、
  **原文が誤っているわけではない**（statement に分枝の指定が無い、という穴）。
  原文（`structured-latex/content`）は書き換えていない。

`lake build` 成功、`bash lean/scripts/check-no-sorry.sh` exit 0、構造化テキストの 3 検証も通過。

### 引き継ぎ

- ~~**`AMat` と `Amat` の二重定義を一本化する。**~~ → **完了（下記「完了（2026-07-26）:
  `A(θ)` の二重定義の一本化」を参照）。**
- **他の主張にも抽象版が無いものが多く残っている**（README 8 節）。本追補と同じ要領で、
  既存の具体版を消さずに抽象版を別ファイルへ足し、系として具体版を導く形が使える。

---

## 完了（2026-07-26）: `A(θ)` の二重定義を `AMat` へ一本化し、原文の穴 5 件を docs/tasks へ書き出した

### (1) `A(θ)` の二重定義の解消

`Ising2D.Amat`（複素パラメータ 5 個版）を削除し、`Ising2D.AMat`（`IsingConst` と実 θ 版）に
一本化した。詳細な変更内容は `lean/README.md` の「`A(θ)` の二重定義（解消済み・2026-07-26）」に記録。
要点だけ:

- `Part008/Definition016_TV.lean` が `Part008/Definition019_ThetaGamma.lean` を import。
- 旧 `B1_mul_B2_mul_B1_eq_Amat` を `B1_mul_B2_mul_B1_eq_explicit`（重い行列計算。証明は元のまま）と
  `B1_mul_B2_mul_B1_eq_AMat`（`AMat` への cast）に分割。
- `TV_hatZ_hatY_of_action` / `..._of_action'` の作用行列を `AMat K θ` へ。
- `Definition030_Fermi.lean` 末尾の橋渡し 3 補題は不要になったので削除。
- `scripts/check-no-sorry.sh` の `targets` も整合させた。

`lake build` 成功、`bash lean/scripts/check-no-sorry.sh` exit 0（`sorry` / `admit` ゼロ）。

### (2) 原文の穴 5 件の一次情報を `docs/tasks/2026-07_original-text-gaps/` へ

**本文（`structured-latex/content/`）は編集していない。修正は別セッションの担当。**
各ファイルに (a) 対象ブロックの id と label、(b) 修正後のステートメント案、
(c) 反例・数値検算・対応する Lean 定理名 を書いた。

**5 件とも解消済みで、本文の修正作業は残っていない。**

- 調査に着手した時点で 3 件（010・020・040）は既に解消されていた。
- 残る 2 件（030 `det_A_theta` / 050 `anticommutator_of_psi`）は調査時点で未解消だったが、
  並行セッションのコミット `733a5ee`（「008: Lean 形式化が検出した本文の穴 5 件を解消」）が
  本スコープの修正案とほぼ同じ形で解消した（030 は `def_A_theta` から直接 det を計算して
  (i) c₁²−s₁²=1 (ii) (c₂*)²−(s₂*)²=1 (iii) c₂s₂*=c₂* を明示、050 は γ₂ の 2π 周期性を
  Step 0 として追加）。

記録として残した重要な訂正 2 点:

- **050 の当初の指摘「平方根の分枝の一致を暗黙に仮定」は不正確**。本リポジトリの √ は
  `def_sqrt_cc` の単一値写像 ℂ→ℂ なので分枝の不一致は起こらない。実際に飛んでいたのは
  手前の一段「μ+ν ≡ 0 (mod M) すなわち θ_ν = −θ_μ」で、正しくは θ_ν = −θ_μ + 2kπ。
  反例: M = 4, μ = 1, ν = 3 で θ_ν − (−θ_μ) = 2π（γ₂ の値は 2π 周期性により一致する）。
- **`factorization_of_A_theta` の proof が作用素の等式から行列の等式へ飛んでいる点は未解消**
  （Ẑ, Ŷ の線型独立性が要る）。ただし `det_A_theta` はもうそこに依存していない。
## 完了（2026-07-26）: 群の一般論一式を本文から排除した（点検レポート A-5 と A-6 の part2 分）

`docs/tasks/goal-alignment-audit.md` の A-5（群の一般論が本文にある）と
A-6 のうち 008 章 part2 分（多元環の語彙）を解消した。

### A-5: 群論 7 ブロックを本文からノートへ

008 章本文にあった **自己同型群・内部/外部自己同型群・群準同型・核・像・群の中心・
`Inn(G) ◁ Aut(G)`・群の完全列・`Aut` の完全列・一般の環の乗法群** の 7 ブロックを、
`structured-latex/notes/008_group_theory_general.mjs`（新規）へ**要約せずそのまま**移した。
ノートには「ゴールに照らして本文には採用しなかった」ことと理由を明記してある。
本文から消えたラベルへの相互参照だけは、参照が解決しなくなるため文字列へ置き換えた。

この一式が本文で実際に効いていたのは
**「共役写像 `T` は定数倍を除いて単射」（`injectivity_of_T_up_to_scalar`）の証明の中の 1 点**
（核が中心に一致する）だけだった。そこは

- `g h g^{-1} = g' h g'^{-1}` ⟺ `(g^{-1}g') h = h (g^{-1}g')`（両辺に左から `g^{-1}`、右から `g'`）

と書き換え、`centralizer_is_scalar`（すべての元と可換な元はスカラー倍の単位行列に限る）を
直接当てる形へ**群論の語彙を一切使わずに証明し直した**（Step 1〜4 に分けて圧縮せず記述）。

一般の環の乗法群の定義は、本文側では
`def_invertible_elements_of_R`（`Mat(2,C)^{⊗M}` の可逆元。逆元の一意性と、
単位元・積・逆元・スカラー倍が可逆であることを証明つきで述べる）へ具体化して置き換えた。
`R^×` が未定義概念のまま使われる状態を作らないため。

### A-6（part2 分）: 多元環の語彙を具体的な言い換えへ

`T_V_eq_T_Vprime`（`T_{(V)} = T_{(V')}`）の Step 3・Step 4 にあった
「`C`-部分多元環」「最小の `C`-部分多元環」を、
「和・スカラー倍・積について閉じ、単位元を含む部分集合」「それを満たす最小の部分集合」へ
書き換えた（内容は変えていない）。

**残っている関連作業**: A-6 のうち `Z_Y_generate_algebra`（004 章）側の多元環の語彙、
A-8 のパウリ群・クリフォード群（008 章に残置）。

---

## 完了（2026-07-26）: Lean を「具体版＋抽象版」の2本立てに整え始めた（5主張）

README 4 節の方針（同じ主張に、人手証明と1対1に対応する具体版と、必要な概念だけを残した
抽象版の両方を置く）にしたがい、**片側しか無かった主要補題のうち 5 主張**に不足側を補った。

- **交換子と反交換子の恒等式**（`<commutator_via_anticommutators>`）: 抽象版（任意の環）は既存。
  原文どおり `Mat(n, ℂ)` 上で交換子・反交換子を定義し直した具体版を追加
  （`Ising2D.matComm_mul_eq_matAcomm_sub_matAcomm`。抽象版の特殊化として導出）。
- **スカラー倍の恒等行列は全行列と可換**（`<scalar_identity_commutes>`）: 具体版は既存。
  抽象版（任意の `S`-代数）を追加し、**具体版をその特殊化に置き換えた**。
  原文どおり体 `K` 上の `Mat(n, K)` で述べた 1 対 1 対応版も追加。
- **中心はスカラー**（`<centralizer_is_scalar>`）: 具体版は既存。抽象版（係数は任意の半環、
  スカラーは係数環の中心の元）を追加し、具体版をその特殊化に置き換えた。
- **行列単位の積公式と単位元の分解**（同ラベル Step 2）: 具体版は既存。抽象版（任意の半環、
  添字は 4 つとも別の型でよい）を追加し、具体版をその特殊化に置き換えた。

抽象版は `lean/Ising2D/Abstract/`（名前空間 `Ising2D.Abstract`）に隔離し、
**人手証明の本文にも参照用ノートにも持ち込んでいない**。対応表と、抽象版から得られた知見
（例: 中心＝スカラーに効いているのは添字集合の有限性だけで、係数が ℂ である必要はない）は
`lean/README.md` の「具体版と抽象版の 2 本立て」節に置いた。

`lake build` と `check-no-sorry.sh`（新規 9 件を targets へ追加）はいずれも通過。
**残作業**: 他の主張も順次 2 本立てにする（未着手のものが多数）。

---

## 完了（2026-07-26）: 「原文の誤植・不整合をそのまま再現」と記録されていた箇所を解消

### ゴールと結果

`structured-latex/content/008_TV1_hatZ_hatY_part1.mjs` の conversion.notes に
「原文の誤植・不整合をそのまま再現し fix していない」と記録されていた 2 件を、
**数値検証で正誤を確定 → statement と整合する形へ修正 → 証明を最後まで記述** の順で解消した。
併せて、同じファイル群で見つかった同種の未修正誤植 2 件も解消した（下記 3, 4）。

### 解消した 4 件

1. **テイラー係数の抽出（`extract_taylor_coefficient_of_Z_Y`）の proof が未完・不整合**
   （ブロック `TV1_hatZ_hatY_005_claim_extract_taylor_coefficient`）。
   原文 proof は (h1.z) だけが cosh/sinh まで到達し、(h1.y) と (h2.z−) は偶奇分割の途中で終わり、
   さらに cases 内の項・係数が同じ原文の statement と食い違っていた（(h2.y) は proof 自体が無かった）。
   **数値検証の結論: 誤りは proof 側で、statement は正しい。**
   原文 proof の cases 表式（(h1.y) 奇数項 `i K1^n e^{iθ} hatY`・偶数項 `K1^n hatZ`、
   (h2.z−) の `(K2*)^n` と偶数項に残る `i`）は残差が O(1) で成立せず、
   statement と整合する形は残差 1e-14 オーダーで成立する。3 式すべてを cosh/sinh まで書き切った。

2. **`hatY` への作用の行列表示が scalar 表示と不整合**
   （ブロック `TV1_hatZ_hatY_012_claim_TV1_TV2_actions`、原文「ホロノミック量子場 p142 下段」）。
   scalar 表示 `-i e^{iθ} sinh(K1) hatZ + cosh(K1) hatY` に対し、列ベクトル表示の第 1 成分が
   `i e^{-iθ} sinh(K1)` と**符号も exp も**食い違っていた。
   **数値検証の結論: 誤りは行列表示側。** scalar 表示に合わせて修正した。
   下流の `calc_of_TxT_hatZxhatY`（014）が既に修正後の形（`B_1(θ)` の (1,2) 成分 `-i e^{iθ} sinh K1`）を
   使っていたので、原文の行列表示だけが文書内で孤立して誤っていたことになる。
   併せて `T_{(V1)^{1/2}}(hatY)` と `T_{V2}(hatY)` の proof（原文は「同様」の一言）を書き下した。

3. **`V_2^{-1}` の exp の符号**（同ブロックの proof）。
   `V_2 = (2s2)^{M/2} exp(i K2* H2)` の逆元を `((2s2)^{M/2} exp(-i K2* H2))^{-1}` と書いていた誤植を修正。

4. **note の (h1.y) n=3 の exp の符号**（`structured-latex/notes/008_TV1_hatZ_hatY.mjs`）。
   n=1 では `e^{-i2π(-μ)/M}`（= `e^{+iθ}`、1 重公式 (B) と整合）なのに n=3 だけ `e^{-i2πμ/M}` になっていた。
   n=1 と同じ形へ修正。

### 併せて行った証明の強化（`cosh_sinh_coefficient_conversion`、ブロック 003）

- 原文 statement は (h1.z), (h2.z−) だけを書き「(h1.y), (h2.y) も同様」で済ませていた。
  下流の proof が 4 式すべてを必要とするので、**4 式すべてを statement に明示**し、
  proof でも 4 式すべての代入計算を書き下した。
- 原文の指数簡約は `(-1)^{1/2}` という**実数の範囲で意味をなさない中間式**を経由していた
  （`(n-1)/2 + n/2` を `(2n+2)/2 + 1/2` と書く等）。最終結果は正しいが各ステップの正当化ができない。
  次の 2 補題を明示的に立てて、**すべての指数を整数の範囲で扱う形**に書き改めた。
  - 補題 1（生成子のスカラー倍）: `ad_{αX}^n = α^n ad_X^n`（交換子の第 1 引数についての線型性から）。
  - 補題 2（虚数単位の冪）: `i^n = i(-1)^{(n-1)/2}`（n 奇数）/ `(-1)^{n/2}`（n 偶数）。

### 数値検証（新規追加）

共通基盤 `sagemath/_shared/spin_ops.sage` を新設した。`Mat(2,C)^{⊗M}` 上の
`Z_m, Y_m, H_1^{(±)}, H_2, hatZ_mu^{(±)}, hatY_mu` を**定義に戻って明示的な複素行列として構成**する。
既存の `_shared/defs.sage`（転送行列のスカラー記号）と役割が違うので別ファイルにした。

- `sagemath/check/040_claim_extract_taylor_coefficient_of_Z_Y/`（対象ラベル `extract_taylor_coefficient_of_Z_Y`）
  - check_01: 1 重交換子 (A)〜(D)
  - check_02: 生成子スケール後の n 重交換子 4 式（n=0..8）
  - check_03: テイラー係数の抽出 4 式（級数 40 次打ち切り）
  - check_04: **原文 proof の cases が成り立たないこと**（残差 ≥ 1e-3）と修正版が成り立つこと
- `sagemath/check/041_claim_TV1_TV2_actions/`（対象ラベル `ホロノミック量子場_p142下段_1`）
  - check_01: 4 つの作用を**行列指数関数の直接計算**で確認（交換子の級数展開に依存しない独立経路）
  - check_02: `hatY` の列ベクトル表示について、修正版が成立・原文版が不成立であることを確認

パラメータは `M = 3,4,5`、`μ ∈ calM = {-M,…,-1,1,…,M}` の全域、`(K1,K2)` は臨界点上・高温極限付近を含む 4 組。

### 注意（次に触る人へ）

- `spin_ops.sage` の検証は `M ≤ 5`（行列サイズ 32×32）でも**マシン負荷次第で 1 ファイル 10 分以上かかる**。
  ノルム計算より Sage の型変換が支配的なので、増やすなら `SPIN_TEST_M` を減らすほうが速い。
- ブロック 012 の statement は `T_{(V_1^{(±)})^{1/2}}` が `hatZ_mu^{(-)}` に作用する形で書かれている
  （`H_1` の符号と `hatZ` の符号が見かけ上そろっていない）。proof では
  `extract_taylor_coefficient_of_Z_Y` を `± = -` で適用する旨を明示した。
  数値検証も `H_1^{(-)}` と `hatZ_mu^{(-)}` の組で行っている。

---

## 完了（2026-07-26）: ゴール基準に反する本文記述の点検（修正はしていない）

`docs/tasks/goal-alignment-audit.md` に結果を置いた。`structured-latex/content/` の
全 14 ファイルを通読し、README のゴール設定に反する箇所を優先度 A/B で一覧にしたもの。
**修正方針は依頼者判断待ちなので、本文には一切手を付けていない。**

優先度 A（本文の骨格に関わる、局所的な書き換えでは済まないもの）:

- A-1 抽象テンソル積の定理 `tensor_basis`（基底のテンソル積が基底）が本文にあり、
  `centralizer_is_scalar` / `Z_Y_linearly_independent` / `def_end_iso` / `Z_Y_generate_algebra`
  がそこに依存している。README 2 節が名指しで禁じた主張。
- A-2 `Mat(2,C)^{⊗M}` 記法が本文全域（`\otimes` が 454 箇所）。クロネッカー積の定義ブロックが無い。
- A-3 「テンソル積代数の積の定義」「第 j 因子についての C-線型性」を 20 箇所以上で根拠に使うが、
  定義も証明も本文に無い（未定義概念）。
- A-5 群の一般論一式（`def_aut_inn_out` / `def_group_hom_ker_im` / `def_center_of_group` /
  `inn_is_normal_in_aut` / `def_exact_sequence` / `exact_sequence_of_aut` / 環の乗法群）。
  実際に効いているのは `injectivity_of_T_up_to_scalar` 内の $\mathrm{Ker}(\varphi)=Z(R^\times)$
  の 1 点だけで、そこは `centralizer_is_scalar` を当てれば群論なしで書ける。
- A-6 多元環の一般論（`Z_Y_generate_algebra` の「単位的結合多元環」「最小の C-部分多元環」、
  `V_eq_Vprime` の Step 3）。
- A-7 exp の土台が抽象的な有限次元ノルム線型空間（`exp_converges` / `def_exp`）。
  「ノルム線型空間」の定義が本文に無い（`def_matrix_norm` は $K^d$ と $\mathrm{Mat}(n,K)$ のみ）。
- A-8 パウリ群・クリフォード群（`def_pauli_group` / `def_clifford_group` /
  `V2_not_in_clifford_group`）。本文自身が「本証明では使わない」と書いている。

A-4（リー群・リー環）は点検中に取り込んだ `origin/main` で解消済みだった（下記の項目）。

優先度 B の主なもの: 体 `K` を一般のまま置いた 11 ブロック、未定義のまま使われている
実数の `exp` / `log` / `tanh` / `(2 sinh 2K_2)^{M/2}` / 複素指数 $e^{i\theta}$ / `det` /
`π` と弧長（外部文献「齋藤微積分」に委ねている）、`I_{(C^2)^{⊗M}}` と
`I_{(Mat(2,C))^{⊗M}}` の記号不整合、複素数をモノイド・群・体の言葉で述べている 000 章。

## 完了（2026-07-26）: リー群・リー環の経路を参照用ノートへ退避

README のゴール設定（1 節「典型例がリー群・リー環である」／6 節「採用しなかった経路の扱い」）に従い、
`structured-latex/content/005_exp_conjugation_proof.mjs` からリー群・リー環を使う 6 ブロックを
`structured-latex/notes/005_exp_conjugation_lie_route.mjs` へ**要約せず原文のまま**移した。
各ノートの冒頭に「ゴールに照らして本文には採用しなかった。理由: リー群の一般論を先に理解しないと
証明を追えなくなり、本筋と無関係なところで読者の負担を生むため」を明記してある。

移したもの: Ad/ad のリー環的定義、リー群上の $\mathrm{Ad}(\exp X)=\exp(\mathrm{ad}X)$（未証明の
TODO ごと）、$\mathbf{GL}(n,\mathbb{C})$ の定義、Matrix Lie群の定義（旧 `def_matrix_lie_group`）、
Brian Hall Def 3.32 の $\mathrm{Ad}_g/\mathrm{ad}_X$、Matrix Lie群版の主定理（旧 `brianhall_3.35`）。

本文に残したのは級数展開だけで済む経路: $M(n;\mathbb{C})$ のノルム・収束（`def_frobenius_inner_product`）、
`ad_binomial`、`matrix_exp_conjugation`（主定理 $e^XYe^{-X}=e^{\mathrm{ad}_X}(Y)$）、`brianhall_exc14`。

参照が切れないようにした処置（重要）:

- `def_ad_X_matrix` は 005 章の 3 ブロックと 008 章の 2 箇所から参照されているので、**同じラベルのまま**
  Matrix Lie群を使わない具体版の定義ブロック（`exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix`）へ
  差し替えた。$\mathrm{ad}_X(Y)=[X,Y]$ と、正則な $g$ に対する $\mathrm{Ad}_g(Y)=gYg^{-1}$（逆行列の
  一意性の証明つき）だけを述べており、リー群は出てこない。008 章側が期待していた記号とも一致する。
- ノートから `def_matrix_lie_group` への `ref` はラベルが content に無くなるため解決しない
  （`validate-content.mjs` はノートの ref も content のラベルへ解決することを要求する）。該当箇所は
  ノート ID への言及に置き換えた。
- 旧 `brianhall_3.35` はどこからも参照されていなかった（grep 確認済み）。

検証3種すべて通過（origin/main のクリフォード代数ノートをマージ後: 156 ブロック・130 ラベル・
579 参照すべて解決、ノート 28 件）。

## 完了（2026-07-26）: クリフォード代数の読み物ノートを追加

README 5 節「なぜこの計算を思いついたのかを説明する材料（読み物）」に該当するものとして、
`structured-latex/notes/009_clifford_algebra.mjs`（5 件）を新規作成した。厳密証明ではない。

内容と、それぞれが対応する本文のラベル:

- 反交換関係（`anticommutator_of_Z_and_Y`）が、$2M$ 個の生成元に通し番号を振ると
  $e_a e_b + e_b e_a = 2\delta_{ab}I$ という**クリフォード代数の定義関係式そのもの**であること。
- 生成元から作られる代数の次元が $2^{2M} = 2^M \times 2^M$ で全行列環と一致し、
  Jordan--Wigner 構成（$Z_m,Y_m$ の定義に現れる $\sigma^x$ の弦）がその同型を具体的に与えること
  （`Z_Y_generate_algebra` / `Z_Y_linearly_independent`）。
- 二次式の指数関数による共役が生成元の張る $2M$ 次元空間を保ち直交変換になること。これが
  「共役が $A(\theta)$ という $2\times 2$ 行列の作用に化ける」理由であること
  （`T_V_hatZ_hatY` / `def_T_V` / `V1_in_Z_Y_epsilon` / `V2_in_Z_Y`）。
- その対応の核がスカラーちょうどであることが、「$V$ と $V'$ が定数倍を除いて一致する」の
  構造的な意味であること（`V_eq_Vprime` / `T_V_eq_T_Vprime` / `centralizer_is_scalar`）。

ノート冒頭に、(1) クリフォード代数はテンソル代数の商代数として定義されるため README 2 節の基準により
厳密証明には含めない、(2) 本文の証明はこのノートに依存していない（本文は具体計算だけで自足）、
の 2 点を明記してある。検証3種はすべて通過（notes 22 件・targets 29 件すべて解決）。

---

## 完了（2026-07-26）: 人手証明に残っていた未完（TODO）を全件解消 — **総括**

本セッションのゴールは「`structured-latex/content/*.mjs` に残る未完を、証明完成か、
埋められない根拠の一次情報による特定か、のどちらかに到達させる」ことだった。到達した。
以下は個別セッションの記録（このすぐ下から並ぶ各節）の索引であり、**残っている未完はこの節に全部書いてある**。

### 数え方の注意（重要）

「TODO 8 件」という数字は `verify-no-lost-proofs.mjs` の出力であり、これは
**proof が `todo()` だけのブロック**を数えている。実際には `statement` 側の `todo()` や、
証明の途中まで書いて末尾が `todo()` のブロックもあり、**`todo()` ノードを含むブロックは全部で 16 件**だった。
本セッションはこの 16 件すべてを対象にした。

### 結果

- `todo()` を含むブロック: **16 件 → 1 件**。
- `verify-no-lost-proofs.mjs` の「proof が todo のみ」: **8 件 → 0 件**。
- 併せて、`todo()` を使わない形で残っていた未完 4 箇所（「証明略」「（暫定）一旦受け入れる」
  「未証明につき使用禁止」）も解消した。**本文に未証明の主張を根拠として使っている箇所は無い**
  （grep で確認済み）。
- 検証3種すべて通過: `validate-content`（161 ブロック・132 ラベル・557 参照すべて解決）/
  `verify-no-lost-proofs`（0 件）/ `verify-check-linkage`（7 件）。

### 唯一残した未完とその根拠

`exp_conjugation_proof_002_theorem_Ad_exp_lie`（**一般の Lie 群上の** $\mathrm{Ad}(\exp X)=\exp(\mathrm{ad}X)$）。
理由は「難しいから」ではなく、**主張の記号が意味をもつ土台がリポジトリに存在しないから**である
（多様体・Lie 群・Lie 環・$\mathrm{Lie}(G)$ を定義したブロックが 1 件も無いことを grep で確認）。
**本論はこの一般版に依存しない**。必要なのは行列環上の $e^XYe^{-X}=e^{\mathrm{ad}_X}(Y)$ だけで、
そちらは `matrix_exp_conjugation` として完全に証明済みであり、以降の参照もすべてそこへ張り替えた。
詳細は末尾の「未完 TODO の根拠（005 …）」節を見よ。

### 本セッションで発見・訂正した原文の誤り（すべて数学的に実質的なもの）

1. **分配関数の $J$ と $J'$ が転送行列側と入れ替わっていた**（001）。$M\neq N$ のとき
   $\mathrm{tr}((V_1V_2)^M)$ は $Z(J,J')$ ではなく $Z(J',J)$ に一致してしまう。$V_1,V_2$ の定義側を訂正。
2. **周期境界条件が未記載で、分配関数と転送行列の定義式そのものが意味を持っていなかった**（001）。
   $s(M+1,j):=s(1,j)$、$s(i,N+1):=s(i,1)$、$\mu(N+1):=\mu(1)$ を明記。
3. **$V_1$ の定義の虚数単位が余分だった**（004）。原文どおりだと $V_1=\exp(-K_1(Y_1Z_2+\cdots))$ となり
   原文自身の主張と矛盾する。$\sqrt{-1}$ は Jordan–Wigner 置換 $\sigma^z_m\sigma^z_{m+1}=\sqrt{-1}\,Y_mZ_{m+1}$ から生じる。
4. **$\mathrm{End}(\mathcal{F})\cong\mathrm{Mat}(2,\mathbb{C})^{\otimes M}$ が「線型同型を一つ取る」だけで、
   積を保つ保証が無かった**（004）。これでは $\exp$ を移せず証明が成立しない。正準な単位的 $\mathbb{C}$-代数同型として構成し直した。
5. **$\gamma_1$ の偏角の場合分けの第 2 の場合（$\arg=\pi$）は空**（008後半）。
   $c_1>s_1>0$, $c_2^{*}>s_2^{*}>0$ より $c_1c_2^{*}/(s_1s_2^{*})>1\ge\cos\theta_\mu$ で、常に $\gamma_1>0$。
6. **「$\sin\theta_\mu=0 \iff \mu=\pm M$」は単独では偽**（008後半）。$M$ が偶数なら $\mu=\pm M/2$ も満たす。
   これが排除されるのはもう一方の条件が $c_2s_1=-c_1<0$ を要求して正値性と矛盾するためで、
   **連立して初めて** $\mu=\pm M$ に絞られる。
7. **$\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)/\gamma_2(-\theta_\mu))$ は原文がプレースホルダー `???` のままだった**（008後半）。
   $\gamma_2(-\theta)= -\overline{\gamma_2(\theta)}$ から確定式へ置換した。
8. **原文がテンソル因子の位置に全体の単位元を書いていた**（006）。2×2 の $I_{\mathrm{Mat}(2,\mathbb{C})}$ に修正。

### 検証されたこと（誤りではなかったもの）

- $B_1(\theta_\mu)B_2B_1(\theta_\mu)=A(\theta_\mu)$（008前半）は **statement のとおり正しい**。
  4 成分すべてを手計算で確認し、$(1,2)$/$(2,1)$ 成分に現れる $c_2^{*}$ が $\gamma_2$ の $c_2$ と一致するのは
  双対関係 $c_2^{*}=s_2^{*}c_2$ による（独立ブロック `duality_c2_star_eq_s2_star_c2` として切り出した）。
  呼び出し元でも $K_1,K_2,\theta$ の 4 組で数値独立確認済み（誤差 $10^{-15}$ 以下）。
- $\gamma_1$ の偏角の境界 $\gamma_1=0$ を $\arg=0$ 側に含める原文の扱いは**正しい**。
  このリポジトリの $\arg^{[0,2\pi)}$ は全域関数で $\arg^{[0,2\pi)}(0_{\mathbb{C}})=0$ だから。

### 次にやるとよいこと

- 一般 Lie 群版を本当に証明したいなら、多様体・Lie 群・Lie 環・指数写像の定義ブロックを整備するところから。
  ただし**本論には不要**なので、優先度は低い。
- クリフォード群まわりで、`T_g` の定義域をクリフォード群へ狭める案は採れないことが
  `V2_not_in_clifford_group` で確定した（$V_2\sigma_1^zV_2^{-1}$ が Pauli 基底で 2 成分をもつ）。
  代わりに単射性は `injectivity_of_T_up_to_scalar` で直接証明済み。

## 完了（2026-07-26）: フェルミオン ψ の定義・反交換関係・T_(V) の作用を Lean で形式化

対象ブロック（`structured-latex/content/008_TV1_hatZ_hatY_part2.mjs`）:
`TV1_hatZ_hatY_030_definition_fermi`（`def_fermi`）/ `TV1_hatZ_hatY_031_claim_V_psi_commutator`
（`commutation_V_psi`）/ `TV1_hatZ_hatY_032_claim_anticommutator_psi`（`anticommutator_of_psi`）。
新規ファイル `lean/Ising2D/Part008/Definition030_Fermi.lean`。

### 引き継ぎ: `A(θ)` の二重定義は未解消（橋渡し補題だけ置いた）

`Ising2D.Amat`（複素パラメータ版、`Definition016_TV.lean`）と `Ising2D.AMat`（`IsingConst` と実 θ 版、
`Definition019_ThetaGamma.lean`）が**同じ行列の二重定義**で、名前も大文字小文字違いだけである。

一本化は既存 Lean ファイルのリファクタになり、**既存ファイルを「具体版＋抽象版の2本立て」へ整える
別トラックの作業と衝突する**ため、ここでは既存ファイルを変更していない。代わりに新規ファイル
`Ising2D/Part008/Definition030_Fermi.lean` の末尾に橋渡しを置いた。

- `Amat_eq_AMat`: 実パラメータ・実 θ へ coe すれば両者が一致する
- `B1_mul_B2_mul_B1_eq_AMat'` / `TV_hatZ_hatY_of_action_AMat`: 既存の `Amat` 版を `AMat` 版へ移送

**次にやること**: 既存ファイルのリファクタ時に `Amat` を削除し `AMat` へ一本化する
（接続に必要なのは、モデル定数について `(K.c1 : ℂ) = Complex.cosh (2K_1)` の形の仮定と、
`Complex.ofReal_cos` / `Complex.ofReal_sin` による三角関数の cast だけであることを確認済み）。

### 発見した原文の穴: `anticommutator_of_psi` は平方根の分枝の一致を暗黙に仮定している

原文は `M ∣ μ+ν` のとき `γ_2(θ_ν) = γ_2(-θ_μ)` から
`√(γ_2(θ_ν)γ_2(-θ_ν)) = √(γ_2(θ_μ)γ_2(-θ_μ))` を使っているが、根号の中身が等しいことから
従うのは `t_ν = ±t_μ` までで、**μ と ν で分枝が同じであることは自明でない**。

自分で計算して確定した結果（Lean 側でも機械的に確認）:

- `[ψ_μ^†, ψ_ν^†]₊` の係数は `c_μ c_ν(γ_2(-θ_μ)γ_2(-θ_ν) - t_μ t_ν)·2Mδ` で、
  `M ∣ μ+ν` のとき `γ_2(-θ_μ)γ_2(-θ_ν) = t_μ^2` だから括弧は `t_μ(t_μ - t_ν)`。
- `γ_2(θ_μ) ≠ 0` より `t_μ^2 = -|γ_2(θ_μ)|^2 ≠ 0`、すなわち `t_μ ≠ 0`。
- したがって**同一分枝 `t_ν = t_μ` なら原文どおり `0`、逆分枝 `t_ν = -t_μ` なら `2t_μ^2 ≠ 0` で原文は偽**。
- `[ψ_μ^†, ψ_ν]₊` も同様で、逆分枝だと `δ^M_{μ+ν,0} I` ではなく `0` になる。

**結論: 同一分枝の選択は必要不可欠で、原文の穴である。** Lean 側では
仮定 `hbr : (M : ℤ) ∣ (μ + ν) → tν = tμ` として明示した（`M ∤ μ+ν` なら分枝は結論に効かない）。
原文（`structured-latex/content`）は書き換えていない。

### 未証明の穴（sorry ではなく仮定として持った箇所）

`T_(V)` が `(hat(Z)_μ^{(-)}, hat(Y)_μ)` に `A(θ_μ)` で作用すること（原文 `T_V_hatZ_hatY`）は、
`parts 008` の 001〜005（ネストした交換子のテイラー係数抽出）が未形式化のため証明できない。
`ActsBy T … (AMat K (thetaMu M μ))` を明示的な仮定として持ち、そこから先
（`P_μ` の各列が固有ベクトル ⇒ `ψ_μ^†, ψ_μ` が `T` の固有ベクトル、固有値は `D_μ` の対角成分）は
完全に証明した。`sorry` / `admit` は無い。

### 追加した主な定理

`psiDag` / `psi`（`P_μ` の第 0 列・第 1 列）、`psiDag_eq` / `psi_eq`（原文の「すなわち」の検算）、
`acomm_lin2` / `acomm_hatZMinus_hatY_lin2`（双線型性）、
`acomm_psiDag_psiDag` / `acomm_psiDag_psi` / `acomm_psi_psi`（反交換関係 3 式）、
`Pmat_col_zero` / `Pmat_col_one` / `AMat_mulVec_Pmat_col_zero` / `AMat_mulVec_Pmat_col_one`、
`TV_psiDag_of_action` / `TV_psi_of_action` / `TV_psiDag_psi_of_action`。

## 完了（2026-07-26）: 転送行列 V1/V2 の定義と共役作用 T_g / T_V を Lean で形式化

新規ファイル 2 つ（`lake build` 成功、`scripts/check-no-sorry.sh` exit 0）。

- `lean/Ising2D/Part004/Definition010_H1H2V1V2.lean`
  - `H1 η`（`Y_m Z_{m+1}` の和、最終項の符号を `η : ℂ` で持つ）と `H2`。
    site 添字の巡回は `Fin M` の加法（`NeZero M` を要求する）を避け、
    自前の `nextSite m = ⟨(m+1) % M, _⟩` で表す（`M` に追加仮定を置かないため）
  - `V1`, `V1half`, `V2`（`(2s_2)^{M/2}` は `Real.rpow`）と、その可逆性
    （`V1Units` / `V1halfUnits` / `V2Units`。`V_2` のスカラー因子が 0 でないために `s_2 > 0` が要る）
- `lean/Ising2D/Part008/Definition016_TV.lean`
  - `TConj g`（原文 `def_T_g`）を **ℂ-代数自己同型**として構成（既存の
    `Ising2D.Conjugation.*` を再利用し、`commutes'` だけ足した）
  - `TV g1 g2`（原文 `def_T_V`）と `TV_eq_TConj : T_{(V)} = T_{g_1 g_2 g_1}`、
    ℂ-線型性・乗法性・単位性
  - 行ベクトル記法 `(T z, T y) = (z, y) B` の述語 `ActsBy` と合成則 `ActsBy.comp`、
    および**固有ベクトル移送の一般補題 `ActsBy.eigen`**（後段で ψ が V の固有ベクトルで
    あることを導く鍵）
  - 行列等式 `B_1(θ) B_2 B_1(θ) = A(θ)` を証明（`B1_mul_B2_mul_B1_eq_Amat`）
  - 原文 `T_V_hatZ_hatY` は、`B_1`, `B_2` の作用（`parts 008` の 001〜005 のテイラー係数
    抽出に依存し未形式化）を**明示的な仮定 `hT1`, `hT2`** として持つ定理
    `TV_hatZ_hatY_of_action` の形で述べた。仮定から先は完全に証明済み

### 形式化で見つかった原文の問題（原文は書き換えていない）

1. **`V_2` の 2 つの表式の一致が未説明。**
   `transfer_matrix_001_definition_symbols` は `V_2 = (2 sinh 2K_2)^{M/2} exp(K_2^*(σ^x_1+⋯+σ^x_M))`、
   `transfer_matrix_011_definition_H1_H2` は `V_2 = (2s_2)^{M/2} exp(√-1 K_2^* H_2)` と書くが、
   一致には `√-1 Z_m Y_m = σ^x_m`（`Z_m Y_m = -√-1 σ^x_m` から従う）が要る。原文は「よって、」
   とだけ書いて根拠を示していない。Lean では `I_smul_H2_eq_sum_sigmaX` として補って証明した。
2. **`A(θ)` に `c_2` が現れるのに、その出所（双対関係）が明示されていない。**
   `def_A_theta` の非対角成分は `s_2^*(c_1 cos θ ∓ i sin θ - s_1 c_2)` だが、
   `B_1(θ) B_2 B_1(θ)` を計算して同じ位置に出るのは `c_2^*` である。両者が一致するには
   `c_2^* = s_2^* c_2`（`sinh 2K_2 · sinh 2K_2^* = 1` から従う）が必要。原文は
   `def_A_theta` でも `T_V_hatZ_hatY` の証明でもこの等式に触れていない。
   Lean では `B1_mul_B2_mul_B1_eq_Amat` の仮定 `hdual : s_2^* c_2 = c_2^*` として明示した。
3. **`(V_1^{(±)})^{1/2}` の意味が未定義。** 原文は `exp(X)^{1/2}` を無断で `exp(X/2)` と
   読み替えているが、一般に行列の平方根は一意でない。Lean では `V1half := exp(X/2)` を定義とし、
   `V1half_sq : V1half^2 = V1` を証明して「平方根であること」を確認した。
## 完了（2026-07-26）: `A(θ)` の対角化（γ_1, γ_2, 固有値・固有ベクトル、P D P⁻¹）を形式化

追加ファイル: `lean/Ising2D/Part008/Definition019_ThetaGamma.lean`, `lean/Ising2D/Part008/Claim027_EigenATheta.lean`。
対応する原本ブロックは `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs` の
`TV1_hatZ_hatY_017/019/020` と `..._part2.mjs` の `TV1_hatZ_hatY_022/023/027/028/035`。

### 方針（要点だけ）

- 複素平方根の分枝を持ち込まず、`t^2 = γ_2(θ)γ_2(-θ)`（あるいは `s^2 = -γ_2(θ)γ_2(-θ)`）を
  **満たす複素数を仮定として受け取る**形にした。分枝の選択は「`t` と `-t` のどちらか」だけに
  縮約され、結論（`P` の 2 列と `D` の 2 成分が同時に入れ替わるだけ）が分枝によらないことが見える。
- モデル定数 `c_1, s_1, c_2, c_2^*, s_2^*` は 5 個の実数（`IsingConst`）として扱い、
  `cosh^2 - sinh^2 = 1` や双対関係は**使う定理ごとに仮定として明示**した。
  どの結論がどの関係に依存するかが形式化の側で可視化される。

### 形式化で見つかった原文の問題

1. **`gamma_2_theta_is_0`（`TV1_hatZ_hatY_022`）は `s_2^* ≠ 0` を暗黙に仮定していた**（`γ_2` は
   `s_2^*` を因子に持つ）。また **「`sin θ_μ = 0 ⟺ μ = ±M`」は単独では偽**で、正しくは `M ∣ 2μ`
   （`M` が偶数なら `μ = ±M/2` も該当）。
   → **本セッションと並行して、原文側で両方とも修正済み**（現在の当該ブロックは `K_1, K_2 ∈ ℝ_{>0}`
   を前提に置き、`μ = ±M/2` が `c_2s_1 = -c_1 < 0` の矛盾で排除されることも明記されている）。
   Lean 側は `gamma2_eq_zero_iff` と `sin_thetaMu_eq_zero_iff` を機械的な裏づけとして残した。
2. **`det_A_theta`（`TV1_hatZ_hatY_035`）の `det A(θ_μ) = 1` は `A(θ)` の定義からは出ない。**
   定義だけから無条件に言えるのは `det A(θ) = γ_1(θ)^2 + γ_2(θ)γ_2(-θ)` まで。`1` になるのは
   (i) `c_1^2 - s_1^2 = 1`、(ii) `(c_2^*)^2 - (s_2^*)^2 = 1`、(iii) `c_2 s_2^* = c_2^*` が揃うとき。
   原文は `A = B_1B_2B_1` から `det A = (det B_1)^2 det B_2 = 1` を出しており (i)(ii) はそこで使うが、
   **(iii) が明示されていない**。`B_1, B_2` には `c_2^*, s_2^*` しか現れず、`def_A_theta` の (1,2) 成分の
   `c_2` は `B_1B_2B_1` を展開すると `c_2^*/s_2^*` として出てくる。つまり (iii) は
   `factorization_of_A_theta`（その proof は原文では TODO＝Mathematica による数値確認のみ）に
   埋め込まれた前提である。(iii) を `c_2 = c_2^*` に置き換えると `det A` は `θ` 依存になり `1` にならない
   （数値例で確認済み）。
3. **`diagonalization_P_D`（`TV1_hatZ_hatY_028`）は `P_μ` の可逆性を確認していない。**
   `A = P D P^{-1}` と書くのに `det P_μ ≠ 0` の確認が無い。Lean 側で
   `det P_μ = i t/(2(√M)^2 γ_2(-θ_μ))` を計算し、`γ_2(θ_μ) ≠ 0`, `M ≠ 0` の下で非零を示した。
4. 固有値・固有ベクトルの符号対応（`λ_± = γ_1 ± √(-γ_2γ_2)` ↔ `v_± = c(±i√(γ_2γ_2), γ_2(-θ))`）は
   **検算の結果、原文が正しい**。ただし整合するのは `arg^{[0,2π)}` 分枝での
   `√(-1·z) = -√(-1)√z`（`z = γ_2(θ)γ_2(-θ)` は負の実数）を使うときに限る。
   原文は proof 中でこの分枝規約を導いているが、statement 側には分枝の指定が無い。
   Lean 側では `t := √(γ_2γ_2)` の言葉で「`i t` 側の固有値は `γ_1 - i t`」と明示した。
5. `eigenvector_of_A_theta` の「`γ_2 = 0` のとき `A(θ_μ) = I`」は、原文が
   `A_theta_is_identity_when_gamma2_zero`（`045`）を参照しており、そこで `det A = 1` と `γ_1 ≥ 1` から
   `γ_1 = 1` を出している。**原文の穴ではない**（当初は穴と判断したが、参照先を確認して撤回した）。
   Lean 側では依存関係が見えるよう `AMat_of_gamma2_eq_zero`（`A = γ_1 I` まで）と
   `gamma1_sq_eq_one_of_gamma2_eq_zero`（3 関係から `γ_1^2 = 1`）に分離してある。

## 完了（2026-07-26）: `todo()` 以外の形で残っていた未完 4 箇所

`todo()` を使わない形（「未証明につき使用禁止」注記・「暫定」proof・「証明略」）で残っていた
4 箇所をすべて人手証明で閉じた。**未証明のまま残した差分は無い**（＝ MEMORY への「根拠つき記録」に
回した項目は 0 件）。

- **`brianhall_exc14` / `brianhall_3.35`（`005_exp_conjugation_proof.mjs`）**:
  「Brian Hall Prop 3.35 の参考記述であり未証明・使用禁止」注記を撤回し、
  `matrix_exp_conjugation`（行列版 $e^XYe^{-X}=e^{\mathrm{ad}_X}(Y)$、同ファイルで完全証明済み）と
  `ad_binomial` から証明を書いた。**一般 Lie 群でしか意味をもたない差分はこの 2 ブロックには無い**：
  `brianhall_exc14` は $\mathrm{M}(n,\mathbb{C})$ 上の主張そのもの、
  `brianhall_3.35` の Matrix Lie群 $G$ に関する仮定
  （$\forall t\in\mathbb{R},\ \exp(tX)\in G$ と $Y\in G$）は
  $\mathrm{Ad}_{\exp X}$ を $G\to G$ の写像として読むためにのみ使われ、等式自体は任意の
  $X,Y\in\mathrm{M}(n,\mathbb{C})$ で成り立つ。Matrix Lie群の定義の第2条件（極限に関する閉性）は不要。
  一般 Lie 群版が未証明なのは `exp_conjugation_proof_002` のみで、これは従来どおり `todo()` のまま
  （根拠は後述の「未完 TODO の根拠（005 …）」節）。
  併せて **`matrix_exp_conjugation` のブロックを `brianhall_exc14` より前へ移動**し、
  証明が後方のブロックを参照する依存の逆転を解消した。
  Matrix Lie群の定義ブロックに `def_matrix_lie_group` ラベルを新設。
- **`exp_X_Y_exp_-X`（`008_TV1_hatZ_hatY_part1.mjs`）**:
  「（暫定）リー群・リー環の掘り下げを避けて一旦受け入れる」を撤回し、`matrix_exp_conjugation` を
  根拠に完全な証明へ書き換えた。statement 側に $X,Y\in\mathrm{Mat}(d,\mathbb{C})$ と記号の定義元を明示。
  これで **`brianhall_3.35` を根拠に使っている証明は本文に 1 件も無い**（grep 済み）。
- **`sqrt_nonnegative_existence_uniqueness`（新設・`000_calculation_formulae_00_09.mjs`）**:
  `definition_of_sqrt_r_positive` が「証明略」としていた
  「$x\ge0$ に対し $y\ge0\land y^2=x$ なる $y$ がただ一つ存在」を独立 claim として切り出し証明した。
  存在は $S=\{s\ge0\mid s^2\le x\}$ の上限をとる（**ここで非可算集合 $\mathbb{R}$ の完備性＝上限性質へ
  移行することを proof 冒頭で明示**。$\mathbb{Q}$ では成り立たないことも記載）。
  一意性は $x=0$ を場合分けしたうえで既存の `cosh_sinh_basic_properties` (4)
  （正実数について $a^2=b^2\iff a=b$）を参照し、重複証明を避けた。
- **`angle_section_existence_uniqueness`（新設・`000_calculation_formulae_10_19.mjs`）**:
  `section_of_angle_representation`（角度表現の切断）が「証明略」としていた
  「$0\le\theta-2n\pi<2\pi$ なる $n\in\mathbb{Z}$ の一意存在」を独立 claim として切り出した。
  従来はこの証明が `sqrt_expansion_via_polar` の proof Step 1 に書かれており、
  **定義が依存する事実を、その定義を使う側の主張の中で証明する依存の逆転**が起きていた。
  切り出したブロックは文書順で `section_of_angle_representation` より前に配置し、
  定義側と `sqrt_expansion_via_polar` の Step 1 の両方から参照する形にした（証明内容は元の Step 1 と同一。
  $\mathbb{R}$ のアルキメデス性を使う）。

## 完了（2026-07-26）: γ_1, γ_2 の偏角・零点・臨界条件（008 後半の 4 ブロック）

`008_TV1_hatZ_hatY_part2.mjs` の TODO 4 件をすべて人手証明で埋め、`todo()` を除去した。

- **`cosh_sinh_basic_properties`（新設・`000_calculation_formulae_00_09.mjs`）**:
  cosh/sinh の基本性質がどのブロックにも主張として無かったため新設した。
  (1) cosh x − sinh x = e^{−x} > 0、(2) cosh²−sinh² = 1、(3) x>0 で cosh x > sinh x > 0、
  (4) 正の実数について a² = b² ⟺ a = b。exp については乗法性・exp(0)=1・正値性・狭義単調増加だけを使う。
- **`TV1_hatZ_hatY_021`（γ_1 の偏角）**: γ_1(θ_μ) は実数で、符号は cos θ_μ と c_1c_2*/(s_1s_2*) の
  大小で決まる。境界 γ_1 = 0 の扱いは正しい。本リポジトリの arg は pr_2 が r=0 のとき [0] を返す定義
  （`first_and_second_projections`）なので **arg^[0,2π)(0_C) = 0** であり、境界を arg=0 側へ含める原文の
  場合分けは正しい。さらに c_1 > s_1 > 0、c_2* > s_2* > 0 より c_1c_2*/(s_1s_2*) > 1 ≥ cos θ_μ なので、
  **第2の場合（arg = π）は空**である（この事実を statement に追記した）。原文の `arg` は
  `arg^[0,2π)` に統一し、前提 K_1,K_2 ∈ R_{>0} と θ_μ の定義を補った。
- **`gamma_2_theta_is_0`**: i e^{iθ}s_2* ∈ C^× と C の整域性から γ_2 = 0 ⟺ w_μ = 0 に帰着し、
  実部・虚部で連立へ。**「sin θ_μ = 0 ⟺ μ = ±M」は単独では偽**（M が偶数なら μ = ±M/2 でも sin θ_μ = 0）。
  μ = ±M/2 は θ_μ = ±π ゆえ第2式が c_2s_1 = −c_1 < 0 を要求して正値性と矛盾するため排除される、という
  連立での論法を Step 4 に明示し、statement にも注意書きを入れた。最終形
  「μ = ±M かつ c_1 = s_1c_2」を第4の同値として追加した。
- **`arg_of_gamma2_quotient`（原文はプレースホルダー ??? で未完成）**: 値を確定させた。
  `relation_of_gamma_2` の γ_2(θ_μ)γ_2(−θ_μ) = −|γ_2(θ_μ)|² を使うと商は z²·(−1/r²) に等しく、
  極座標表現で **[(1, 2φ_μ + π)]**（φ_μ := arg^[0,2π)(γ_2(θ_μ))）。よって絶対値は 1、偏角は
  2φ_μ + π を mod 2π で [0,2π) へ還元した 3 場合の式。前提 γ_2(θ_μ) ≠ 0 を statement に明示した。
  φ_polar = φ_cartesian^{-1}（`isomorphism_of_phi_cartesian` の全単射性 + φ_cartesian∘φ_polar = id）を
  使うと、i / e^{iθ} / 正実数 / 負実数の極座標表現が「φ_cartesian で戻して確かめる」だけで出る。
  この主張は本文の後続からは参照されていない（grep 済み。参照は notes 1 件のみ）ので整合性の問題は無い。
- **`critical_condition_c1_eq_s1_c2`**: c_1 = s_1c_2 ⟺ s_1s_2 = 1 を、平方根を経由せず
  「正の実数について a² = b² ⟺ a = b」で両向き証明した。γ_2 の零点と Ising 臨界点の対応（statement 後半）の
  導出も Step 3 に書いた（`gamma_2_theta_is_0` の最終形を使う）。
- 数値検証: K_1,K_2,M の 4 組で γ_1 > 0、|γ_2(θ_μ)/γ_2(−θ_μ)| = 1、偏角 = 2φ_μ+π (mod 2π)、
  および c_1 = s_1c_2 ⟺ s_1s_2 = 1 を確認済み（誤差 1e-15 以下）。

## 完了（2026-07-26）: $V_1, V_2$ の $Z,Y,\varepsilon$ 表示と $V_1$ の固有空間への制限（004）

`004_transfer_matrix.mjs` の 2 つの TODO を解消した。

- `<V1_in_Z_Y_epsilon>` と `<V2_in_Z_Y>`（$V_1,V_2$ を $Z,Y,\varepsilon$ で表す）: Jordan--Wigner 置換
  $\sigma^z_m\sigma^z_{m+1} = i\,Y_mZ_{m+1}$（$1\le m\le M-1$）、$\sigma^z_M\sigma^z_1 = -i\,\varepsilon Y_MZ_1$、
  $\sigma^x_m = i\,Z_mY_m$ をテンソル因子ごとの計算で全部書き下した。**exp の分解（可換性）は不要**で、
  指数の中身が $\mathrm{Mat}(2,\mathbb{C})^{\otimes M}$ の元として等しいことを示せば済む。
  境界項に $\varepsilon$ が付くのは、$Y_M$ の Jordan--Wigner 文字列が一周しても $Z_1=\sigma^z_1$ 側に
  文字列が無く、第 1 因子の $\sigma^x$ が相殺せず残るため（それを打ち消すのが $\varepsilon$）。
- `<V1_restriction_to_eigenspaces>`（$V_1$ の $\mathcal{F}^{(\pm)}$ への制限）: $\varepsilon$ が各 $Z_m,Y_m$ と
  **反交換**すること（`<tensor_anticommutation_from_single_site>` を適用）→ 2 次式 $Y_aZ_b$ とは可換 →
  $\mathcal{F}^{(\pm)}$ が $\hat{G}$ 不変 → 部分和が $n$ の帰納法で一致 → 各点収束（`<exp_converges>`）と
  極限の一意性、という順で証明した。解析へ移行するのは最後の級数の極限だけであることを明記した。

### 原本の誤りを 2 点訂正した（要レビュー）

1. **`<def_transfer_matrix_symbols>` の $V_1$ の定義に虚数単位が余分だった。** 原文は
   $V_1 := \exp(\sqrt{-1}K_1(\sigma^z_1\sigma^z_2+\cdots+\sigma^z_M\sigma^z_1))$ だが、これでは
   $V_1 = \exp(-K_1(Y_1Z_2+\cdots))$ となり原文自身の主張（現 `<V1_in_Z_Y_epsilon>`）と矛盾する。
   $\sqrt{-1}$ は Jordan--Wigner 置換から生じるものなので、定義側を $K_1$ に訂正した
   （$V_2$ の定義には $\sqrt{-1}$ が無く、主張側には付く。同じ構造で整合する）。
   004 章以降（$H_1^{(\pm)}$、$V_1^{(\pm)}$、008 章）はすべて訂正後と整合している。
   NumPy で $M=2,3,4,5$ について両辺の一致を数値確認済み。
2. **`<def_end_iso>`（旧「$\mathrm{End}(\mathcal{F})$ と $\mathrm{Mat}(2,\mathbb{C})^{\otimes M}$ の同型」）が弱すぎ、向きも逆だった。**
   原文は「線型同型を一つ取る」だけだが、任意の線型同型では積が保たれず
   `<V1_restriction_to_eigenspaces>` の証明が成立しない。行列単位 $E_{I,J} \mapsto \Theta_{I,J}$ で
   **正準な単位的 $\mathbb{C}$-代数同型** $\mathbf{end}: \mathrm{Mat}(2,\mathbb{C})^{\otimes M} \to \mathrm{End}(\mathcal{F})$
   を具体的に構成し、その性質を新ブロック `<end_is_algebra_isomorphism>` で証明した。
   また $\mathrm{Mat}(2,\mathbb{C})^{\otimes M}$ 上の $\exp$ の意味（どの位相の級数か）が未定義だったので、
   $\mathbf{end}$ による移送として定義した（$\mathbf{end}(\exp A) = \exp(\mathbf{end}A)$）。

### 付随して直した点

- $\varepsilon$ の固有空間の定義（`<def_eigenspaces_of_epsilon>`）: $\varepsilon f$ の意味が
  $\mathbf{end}(\varepsilon)$ による作用であることを明示し、$\varepsilon^2 = I$ と固有値が $\pm1$ に限る理由を補った。
  $\mathbf{end}$ を要するため、ブロックの位置を `<def_end_iso>` の後ろへ移した。
- 新ラベル（現行では最初のラベルを二分）: `V1_in_Z_Y_epsilon`, `V2_in_Z_Y`, `V1_restriction_to_eigenspaces`, `def_end_iso`,
  `end_is_algebra_isomorphism`, `def_eigenspaces_of_epsilon`, `def_V1_pm`。
- $V_1$ の巡回和は $M\ge 2$ でなければ意味を持たないので、該当ブロックに $M\ge 2$ を明示した。

## 完了（2026-07-26）: 008 part1 の残り 4 ブロック（交換子のネスト・自己同型群の完全列・クリフォード群・T_(V) の作用）

`structured-latex/content/008_TV1_hatZ_hatY_part1.mjs` に残っていた 4 件の TODO をすべて埋め、`todo()` を除去した。

### 交換子のネスト（`<nesting_of_commutator_of_H_and_Z>`）

原文の proof は「TODO : note 参考にして、帰納法で行ける」だけだった。(h1.z)/(h1.y)/(h2.z−)/(h2.y) の
4 式それぞれについて `n` に関する帰納法を書き下した。右辺が `n` の偶奇で場合分けされているので、
帰納段階は「偶数 n → 奇数 n+1」「奇数 n → 偶数 n+1」の 2 通りを別々に書き、符号 `(-1)^{(n±1)/2}`・
係数 `(2K_1)^n`（`(2K_2^*)^n`）・位相因子 `e^{∓i2πμ/M}` の再生を毎回明示した。
`n=0` の規約（0 重交換子＝作用素そのもの）は statement 側に `ad_X` の合成として定義を書いた。
使うのは 1 重の交換子公式（`<commutator_of_H_and_Z_Y>`）と交換子の双線型性だけで、note の具体例には依存しない。

### 自己同型群の完全列（`<exact_sequence_of_aut>`）

原文は statement に「TODO: Ker, Im の定義、Z(G) の定義、完全列の定義」、proof に「TODO:」とあるだけだった。
不足していた定義を独立ブロックとして新設し、4 箇所すべての完全性を証明した。

- 新設: `<def_group_hom_ker_im>`（群準同型・核・像。Ker が正規部分群、Im が部分群、単射 ⟺ Ker が自明）、
  `<def_center_of_group>`（中心 `Z(G)`）、`<def_exact_sequence>`（完全列。両端の `1` を単射性・全射性へ読み替える所まで）、
  `<inn_is_normal_in_aut>`（φ_g ∈ Aut(G)、φ が群準同型、`ψφ_gψ^{-1} = φ_{ψ(g)}` から `Inn(G) ⊴ Aut(G)`）。
- 既存の自己同型群の定義ブロックにラベル `<def_aut_inn_out>` を付け、Aut(G) が合成について群をなすことと
  `Out(G)` が商群として定義できる根拠を statement へ書き足した。
- **この完全列は本文の他所からは参照されていない**（grep 済み。`Aut` の語は 005 の `Ad : G → Aut(G)` にしか出ない）。
  ただし後述の `T` の単射性の証明で `Ker(φ) = Z(G)` を使うため、削除せず本文に残した（conversion.notes にも記録済み）。

### クリフォード群（`<def_pauli_group>` / `<def_clifford_group>`）と `T` の単射性

原文（`parts/008/009`）は definition の体裁だが中身は著者の検討メモで、「3 つのアプローチ」として
**試す1**「V を具体的な行列として書くのがゴールなので `T_((V))` からその表式を見つけられないか」／
**試す2**「`T` の（定数倍を除いた）単射性を Cl に触れずに示す」／
**だめだったら3**「Cl と行列環の同型を認め、`T` の単射性も認めて先に進む」が挙げられていた。
**この検討は決着したので、設計判断待ちとしては残していない。**

- 採用は **試す2**。`<injectivity_of_T_up_to_scalar>` を新設し、`T_g = T_{g'} ⟺ ∃c≠0, g' = cg` を
  Clifford 代数と行列環の同型を経由せずに証明した。使うのは `<centralizer_is_scalar>` と
  上記の完全列の `Ker(φ) = Z(G)` だけ。併せて `Z(R^×)` が全体の中心（スカラー）と一致することを、
  「`x + tI` が可逆になる `t` は有限個を除いて存在する」という議論で明示的に示した（`R^×` の中心と
  `R` の中心の一致は自明ではないので）。
- **「`T_g` の定義域をクリフォード群へ狭める」は採れない。** `<V2_not_in_clifford_group>` を新設し、
  `V_2 σ_1^z V_2^{-1} = c_2^* σ^z ⊗ I⊗… − i s_2^* σ^y ⊗ I⊗…` が Pauli 基底で 2 成分をもつため
  Pauli 群に入らないことを示した。よって `def_T_g` の定義域は `R^×` のままとする。
- クリフォード群の定義は上記 `V_2 ∉ C_M` を述べるために本文に残した。標準的な定義がユニタリ群上で
  与えられるのに対しここでは `R^×` 内の正規化群としたのは、`K_2^* ∈ R` で `V_2` がユニタリでないため。

### `T_(V)` の作用（`<T_V_hatZ_hatY>`）

原文が「mathematica に計算させたら正しいことはわかったので、一旦具体の計算は飛ばす (0426)」として
未計算だった `B_1(θ_μ) B_2 B_1(θ_μ) = A(θ_μ)` を、4 成分すべて途中式込みで人手計算した。
**statement は修正不要**（計算結果と完全に一致）。ただし注意点が 1 つある。

- 素の行列積では (1,2)/(2,1) 成分に `c_2^*` が現れるのに対し、`A(θ)` の `γ_2` には `c_2`（星なし）が現れる。
  両者は双対関係 `c_2^* = s_2^* c_2` で一致する。この関係を `<duality_c2_star_eq_s2_star_c2>` として
  独立ブロックに切り出した（同じ計算が part2 の `equation_of_a_theta_mu` の Step 16 に埋め込まれていた）。
- 数値検証を `sagemath/check/017_claim_T_V_hatZ_hatY/` に追加（4 成分 + 双対関係、全 PASS）。
  `K1=10.4` で成分が ~1e9 になるため check_01〜04 は tol=1e-5（相対誤差は全パラメータで ≤2e-12）。

## 完了（2026-07-26）: `Z` と `Y` の反交換関係 3 式を人手証明で完成（`006/000`）

`006_Z_Y_anticommutation.mjs` の `<anticommutator_of_Z_and_Y>` は、原文以来
`[Z_μ,Y_ν]₊ = 0` と `[Y_μ,Y_ν]₊ = 2Iδ^M` が TODO のままだった。これを埋め、`todo()` を除去した。

- 参照先を作るため、同ファイルに本文ブロックを 2 つ新設した（どちらも原文に対応ブロック無し）。
  - `<pauli_matrix_products>`: Pauli 行列の積（`σ^aσ^a = I` の 3 式と、
    `σ^zσ^x = -σ^xσ^z`, `σ^yσ^x = -σ^xσ^y`, `σ^yσ^z = -σ^zσ^y`）。2×2 の成分計算で証明。
  - `<tensor_anticommutation_from_single_site>`: **1 サイトだけ反可換なら
    テンソル積全体が反交換**。テンソル積代数の積が因子ごとの積であることと、
    第 j 因子についての C-線型性でスカラー `-1` を外へ出すことだけで証明する。
    （Lean の `siteProd_anticomm_of_single_site` に対応する構成。）
- `<anticommutator_of_Z_and_Y>` の証明は、原文と同じ「テンソル因子を並べて書く」書式のまま、
  `[Z_μ,Z_ν]₊`（μ=ν / μ<ν / μ>ν）、`[Z_μ,Y_ν]₊`（μ=ν / μ<ν / μ>ν）、
  `[Y_μ,Y_ν]₊`（μ=ν / μ<ν / μ>ν）を各サイトの因子まで書き下した。符号を生むサイトは
  `[Z,Y]` では μ=ν で μ（`σ^yσ^z`）、μ<ν で μ（`σ^xσ^z`）、μ>ν で ν（`σ^yσ^x`）。
- 併せて直した点: 原文はテンソル**因子**の位置に全体の単位元 `I_{(C^2)^{⊗M}}` を書いていたので
  2×2 の `I_{Mat(2,C)}` に修正。μ>ν を「左右対称に同様」で済ませていた箇所も書き下した。
- 添字は `Z_{M+1}:=Z_1`, `Y_{M+1}:=Y_1` の M 周期性から代表元 `μ,ν ∈ {1,…,M}` に取り、
  その範囲で `δ^M_{(μ,ν)} = [μ=ν]` になることを明示した。
  参照のため `004` の `δ^M` 定義ブロックへラベル `<def_delta_M>` を付けた。

## 完了（2026-07-26）: 複素数の平方根の極座標表示（計算公式 039）の証明を追加

`structured-latex/content/000_calculation_formulae_30_44.mjs` の
`calculation_formulae_039_claim_sqrt_expansion_via_polar`（原文も TODO のままだったもの）に証明を付けた。

- 複素数の平方根はリポジトリ内で **主値等の分枝選択ではなく明示式で定義**されている
  （`calculation_formulae_038_definition_sqrt_of_complex_number`、新ラベル `def_sqrt_cc`）。
  すなわち偏角の切断 $s_{[0,2\pi)}$ を半分にしたもの。したがって本主張は「2乗して戻る根の選択」ではなく、
  **定義式の $\mathrm{pr}_1,\mathrm{pr}_2,s_{[0,2\pi)}$ を代表元で書き下しただけ**の等式である。
- 証明の構成: (1) $0\le\theta-2n\pi<2\pi$ なる $n\in\mathbb{Z}$ の存在と一意性
  （$\mathbb{R}$ のアルキメデス性から。角度表現の切断の定義が「証明略」としていた事実をここで証明した）、
  (2) 右辺の代表元非依存性、(3) $r\ne0$ の場合、(4) $r=0$ の場合（$\mathrm{pr}_2$ が $[0]$ を返す規約が効く）。
- 参照のために新ラベルを 3 件追加: `def_sqrt_cc`、`def_phi_cartesian`、`section_of_angle_representation`。
  本主張自体にも `sqrt_expansion_via_polar` を付け、`041_claim_sqrt_squared_is_original` の証明から参照させた。

## 完了（2026-07-26）: 転送行列による分配関数の表式の証明を完成（001）

`structured-latex/content/001_partition_function_2d_ising.mjs` の
`partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix`
（$Z(J,J') = \mathrm{tr}((V_1V_2)^M)$）の TODO を解消した。

- トレース展開を全ステップ記述: $A^m$ の成分公式を $m$ の帰納法で証明 → トレースの定義適用と
  $\mu^{(M+1)}=\mu^{(1)}$（行方向の周期境界条件）の明示 → 指数の積を指数の和へ（`theorem_exp_product`
  を $n=1, K=\mathbb{R}$ で適用、こちらも帰納法）→ 全単射 $\Phi:\mathfrak{M}^M\to\mathfrak{S}$,
  $\Phi(\mu^{(1)},\dots,\mu^{(M)})(i,j) := \mu^{(i)}(j)$ の well-defined/単射/全射を個別に証明 →
  有限和の添え字付け替えで $Z(J,J')$ の定義式と項ごとに一致。総和はすべて有限和なので、
  順序交換・結合・分配に収束の議論は不要（$\mathbb{R}$/$\mathbb{C}$ の解析的道具へは移行していない）。

### 原本の誤りを2点訂正した（要レビュー）

1. **$J$ と $J'$ の入れ替え。** 原本の $V_1$ は行内相互作用に $J$、$V_2$ は行間相互作用に $J'$ を
   割り当てていたが、$Z(J,J')$ の定義では $J$ が第1引数方向（周期 $M$）、$J'$ が第2引数方向（周期 $N$）の
   結合定数である。$\mathrm{tr}((V_1V_2)^M)$ では転送回数 $M$ が第1引数方向、各 $\mu$ の成分数 $N$ が
   第2引数方向に対応するため、原本のままでは $M \neq N$ で $Z(J,J')$ と一致しない（一致するのは $Z(J',J)$）。
   主張の側ではなく**補助的な定義 `def_transfer_matrix` の側**で $J \leftrightarrow J'$ を入れ替えて訂正した。
   この2定義は他章から参照されておらず（004 章の $V_1,V_2$ は $\mathrm{Mat}(2,\mathbb{C})^{\otimes M}$ 上の
   別物）、影響は 001 章内に閉じている。
2. **周期境界条件が未記載だった。** $s(M+1,j)$, $s(i,N+1)$, $\mu(N+1)$ は定義域外で、規約なしでは
   定義式自体が意味を持たない。「正しさに必要ならそれは注記ではない」に従い、両定義の `statement` に
   $s(M+1,j):=s(1,j)$, $s(i,N+1):=s(i,1)$, $\mu(N+1):=\mu(1)$ を明記した。
   併せて $\mathrm{Mat}(2^N,\mathbb{C})$ の添え字集合 $\mathfrak{M}=\mathrm{Map}(\{1,\dots,N\},\{-1,1\})$
   との同一視も明示した。

検証はすべて通過（validate-content / verify-no-lost-proofs / verify-check-linkage、KaTeX パースも 146 式すべて成功）。

## 完了（2026-07-25）: データモデルの穴を塞いだ（本文ブロックは注記欄を持てない）

ノート分離の狙いは「最終成果物は content のみから生成するので、ノートは構造上混入しない」こと。
ところが**本文ブロック側に注記欄（`notes`）が残っており、ビューアも描画していた**（使用は0件だが、
書けば出版物へ漏れる経路）。これを塞いだ。

- `structured-latex/schema.mjs`: 本文ブロックの `notes` を**明示的に拒否**（エラーメッセージで
  「参照用は notes/ へ、出版本文で述べる必要があるものは statement/proof へ」と誘導）。負テスト済み。
- `schema.d.ts` と ビューアの契約（`realtime-web-preview/domain-model/src/block.ts`）からも型を削除。
- ビューアの本文カードから注記欄の描画を削除（参照用ノートの表示は別経路で維持）。

### データモデル（確定形）

- **文書本体** `content/*.mjs`: ブロックの配列。**並びが文書順の正準表現**。
  共通フィールドは id / kind / sourcePath / sourceOrdinal / title / **labels** / conversion。
  定理型は + statement, proof。見出しは + level（本文を持てない）。**注記欄は持てない。**
- **参照用ノート** `notes/*.mjs`: id / **targets（紐づけ先ラベル、1件以上必須）** / title / sourcePath / body。
- ノード（本文の中身、両者共通）: text / math / displayMath / paragraph / list / **ref** / todo。
- 紐づけは**ノート → 本文の一方向**で、**ラベル**で指す（パス非依存）。数値検証との対応も同じくラベル基準。

### 残っている検討事項

`kind` に `note` / `remark` が残っているが content では**使用0件**（heading 10 / theorem 14 /
definition 50 / claim 72）。出版物の Remark 環境として将来使う余地はあるが、
「不要な構造を持ち込まない」方針からは削除候補。判断待ち。

## 完了（2026-07-25）: Phase 3 継続 — 線型独立性・離散フーリエ変換（hatZ/hatY）・その反交換関係を形式化

`lake build` 成功・`lean/scripts/check-no-sorry.sh` exit 0（`sorry` 0、主要定理 **84 件**が `sorryAx` 非依存）。
**このセッションでも commit / push はしていない。**

### 追加したファイル（人手証明の正本は `structured-latex/content/004_transfer_matrix.mjs` ほか）

| Lean | 人手証明（ラベル） |
| --- | --- |
| `lean/Ising2D/Part004/Claim001_ZYLinearlyIndependent.lean` | `004/001`（`<Z_Y_linearly_independent>`。**形式化時点では原文が TODO**） |
| `lean/Ising2D/Part004/Claim008_ExpSum.lean` | `004/008`（`<exp_sum>`）＋ `004/007` の `δ^M` |
| `lean/Ising2D/Part004/Definition009_HatZHatY.lean` | `004/009`（`<def_hatZ_hatY>`） |
| `lean/Ising2D/Part004/Claim012_HatPeriodicity.lean` | `004/012`（`<hatZ_hatY_M_periodicity>`） |
| `lean/Ising2D/Part004/Claim013_RecoverZY.lean` | `004/013`（`<recover_Z_Y_from_hatZ_hatY>`） |
| `lean/Ising2D/Part007/Claim000_AnticommutatorHatZHatY.lean` | `007/000`（`<anticommutator_of_hat_Z_and_hat_Y>`） |

既存の `Part000/Claim046_...` へ、反交換子の双線型性（有限線型結合の展開）を補助補題として追加した。

### 形式化した命題（主なもの）

- **線型独立性**（形式化時点で原文は「TODO: 証明略」。その後、別セッションが
  `{I,σ^x,σ^y,σ^z}^{⊗M}` 基底を使う人手証明を追記している）: Lean 側は
  `{Z_μ, Y_ν}` が Clifford 関係 `[e_a, e_b]₊ = 2 δ_{ab} I` を満たすことから、
  `∑ g_a e_a = 0` と `e_b` の反交換子をとって `2 g_b I = 0` を出す、という 3 行の議論で済んだ。
  既存の `Z_Y_generate_algebra` も `matrixUnitBasis` も不要だった。
- **離散フーリエ変換**: 位相因子 `expPhase M k = exp(-√-1·2πk/M)`（`k : ℤ`）を定義し、
  `expPhase M k = 1 ⟺ M ∣ k` を mathlib の `Complex.isPrimitiveRoot_exp` +
  `IsPrimitiveRoot.zpow_eq_one_iff_dvd` に帰着。`<exp_sum>` は原文どおり (a) 全項 1、
  (b) 等比和 `geom_sum_eq` の 2 ケースで証明。
- `hat(Z)_μ^{(±)}`, `hat(Y)_μ` の定義。`(±)` の符号は `j = 1` の項の係数 `η : ℂ` として持たせ、
  以降で効くのは `η² = 1` だけであることを明示した（`hatZPlus = hatZ (-1)`, `hatZMinus = hatZ 1`）。
  `M` 周期性は原文の特殊値 `μ = ±M` ではなく一般の `μ ∈ ℤ` で証明し、原文の主張を系として得た。
- **逆変換（復元）**: `Z` と `Y` で証明が同一なので、任意の族に対する `inverse_dft` を先に証明して
  両者を特殊化した。これにより「原文が `hat(Z)^{(-)}`（一様和）でしか復元を述べない理由」も明確になる
  （`hat(Z)^{(+)}` は `j = 1` の重みが `-1` なのでこの形の逆変換は成り立たない）。
- **`hat(Z), hat(Y)` の反交換関係 4 式すべて**（原文は後ろ 2 つを「同様」として省略）。
  原文の二重和展開を、(1) 反交換子の双線型性 → (2) `[Z_j,Z_k]₊ = 2Iδ_{jk}` で対角項だけ残す →
  (3) `<exp_sum>` を適用、の 3 段に整理した。

### 添字づけの規約（重要・以降も踏襲する）

原文のサイト添字は `1, …, M`、Lean は `Fin M`（`0, …, M-1`）。**原文の `j` は Lean の `(j : ℕ) + 1`。**
したがって位相因子は `expPhase M (((j : ℕ) + 1) * μ)` と書き、原文の「`j = 1` の項」は
Lean の `(j : ℕ) = 0` の項である。`hat` の添字 `μ` は `ℤ` のまま扱う（原文の `ℳ = {-M,…,-1,1,…,M}` は
定義式の意味には不要で、`M` 周期性も `μ ∈ ℤ` で成り立つ）。

## 完了（2026-07-25）: 出版を見据えたノートの分離（本文＝出版対象、ノート＝参照用）

構造化テキスト化の狙いは最終的に**論文・書籍**にすること。そこで
**「文書本体には出版に載るものだけを置き、ノートは別置きにしてラベルで紐づける」**構成にした。
最終成果物の生成は `content/` だけを読むので、**ノートは構造上いっさい混入しない**
（フラグの付け忘れで漏れる事故が起きない設計）。

- **原則: 「正しさに必要ならそれは注記ではない」。** 定義が意味をもつ条件・well-defined 性・
  主張から従う数学的帰結は `statement`（証明中の事柄なら `proof`）へ。補足計算・具体例・参考公式・
  原文由来のメモ・物理的解釈・先行研究との比較は `notes/` へ。
- **格上げ 5 件**（注記 → 本文）: 直交座標写像の well-defined 性 / フェルミオンは γ₂≠0 のときのみ定義
  （臨界点では ψ_M が存在しない）/ V' の和の限定で一般性を失わないこと / X の各項の well-defined 性
  （proof 冒頭へ）/ γ₂(θ_M)=0 ⟺ Ising 臨界点。
- **移設 16 件**（→ `structured-latex/notes/`、4ファイル）。本文が移設前とノード列レベルで完全一致することを
  機械確認済み（要約・圧縮なし）。独立していた注記ブロック2件も移設し、本文は 142→140 ブロックに。
- 事前判定から変えたもの: テンソル基底定理と平方根の3件は「statement で正しさが完結しており、注記は
  読み方・特殊化にすぎない」ため格上げせず移設。逆に直交座標写像の well-defined 性は格上げに追加。
- **検証**: `validate-content` が notes も検査し、**targets（紐づけ先ラベル）の未解決はエラーで落とす**。
  現在 140ブロック・ラベル78・参照143 全解決 / ノート16件・targets 16 全解決。
- ビューアはノートを紐づけ先ブロック内に折りたたみ（琥珀色の破線）で表示し
  「参照用ノート・最終成果物には載りません」と明示。ノートが無くても動作する（ドメイン非依存を維持）。
- 描画確認: 数式1655件エラー0・リンク切れ0・注記の非掲載明示が33箇所。

**非移行のまま**: 旧 main.typ 末尾の作業ログ134行（日付つき作業記録・デバッグ試行・数値スニペット）は
引き継ぎメモとタスク管理に置き換わっているため `_old/typst/` に残置。

## 完了（2026-07-25）: Typst を廃止し `_old/typst/` へ温存退避（証明の正本が構造化TeXへ）

**証明の正本は `structured-latex/content/`（142ブロック）になった。** Typst 一式
（`main.typ` / `theorem.typ` / `parts/` 130ファイル）は削除せず `_old/typst/` へ退避し、
参照用に**温存**する（削除候補ではない。破棄は改めて判断する）。

- 退避先 `_old/typst/README.md` に、温存の趣旨・現在の正本の所在・「ここを直しても正本には
  反映されない」旨を明記。**退避先で `typst compile main.typ` が成功することを確認済み**
  （作業ディレクトリをそこにすれば `parts` への相対パスがそのまま効く）。
- 出自パスを新所在へ一括更新（構造化TeX の `sourcePath` 131件 + 見出し10件、数値検証の
  overview 6件）。**全130種の出自パスが実在することを機械確認**。
- リポジトリ直下 `CLAUDE.md` のプロジェクト構成を更新（Typst 前提 → 構造化TeX 前提。
  「相互参照・数値検証の対応はラベルで張る」「変更したら通す検証コマンド3種」を明記）。
- 移行の健全性: `validate-content` 142ブロック・ラベル72・参照144全解決 /
  `verify-check-linkage` 6件 / ビューア描画 数式1659件エラー0・リンク切れ0。

### 今後の作業場所（重要）

証明の修正は**必ず `structured-latex/content/` 側**に入れる。`_old/typst/` は更新しない。

## 完了（2026-07-25）: Phase 3 継続 — 転送行列の記号定義・Z/Y の反交換関係・生成定理を形式化

`lake build` 成功・`lean/scripts/check-no-sorry.sh` exit 0（`sorry` 0、主要定理 43 件が `sorryAx` 非依存）。
**このセッションでも commit / push はしていない。**

### 追加したファイル

| Lean | 人手証明 |
| --- | --- |
| `lean/Ising2D/Part000/Claim046_CommutatorViaAnticommutators.lean` | `000/046`（`<commutator_via_anticommutators>`） |
| `lean/Ising2D/Part004/Definition000_TransferMatrixSymbols.lean` | `004/000`（`<def_transfer_matrix_symbols>`） |
| `lean/Ising2D/Part004/Claim014_ZYGenerateAlgebra.lean` | `004/014`（`<Z_Y_generate_algebra>`） |
| `lean/Ising2D/Part006/Claim000_AnticommutatorZY.lean` | `006/000`（`<anticommutator_of_Z_and_Y>`） |

### 形式化した命題（主なもの）

- `[a b, c] = a [b,c]₊ - [a,c]₊ b` を**任意の環**で（`Ising2D.commutator_via_anticommutators`）。
  反交換子 `Ising2D.acomm` は mathlib に無いので自前定義。交換子は mathlib の Lie 括弧と一致することも示した。
- Pauli 行列 `pauliX/Y/Z` と積公式（mathlib に Pauli 行列は**無い**ので自前）。
- サイト局所作用素 `siteOp k : Mat(2,ℂ) →ₗ[ℂ] TensorPow M`。
  `siteProd`（既存）の多重線型性から `MultilinearMap.toLinearMap` で作ったので、線型性はタダで付く。
  `sigmaX/sigmaY/sigmaZ`、同サイトの積 `siteOp_mul_same`、異サイトの可換性 `siteOp_mul_comm`。
- Jordan–Wigner 文字列 `Z m`, `Y m`（`m : Fin M`、0 始まり）、`xString`（`P_m = σ^x_1⋯σ^x_m`）、`epsilon`。
  原文が場合分けで書く `Z_1 := σ^z_1` は、空文字列 `xString M 0 = 1` から自動で従う（特別扱い不要）。
- **反交換関係 3 式すべて**: `anticomm_Z_Z`, `anticomm_Z_Y`, `anticomm_Y_Y`（原文は後ろ 2 つが TODO）。
  核は `siteProd_anticomm_of_single_site`（1 サイトだけ反可換ならテンソル積は反交換）。
  原文の「サイト μ の因子だけ符号が違う」という計算を、`MultilinearMap.map_smul_univ`
  （各サイトのスカラーがテンソル積の外へ ∏ で出る）で一般化した。
- **`Z_Y_generate_algebra`**: `Algebra.adjoin ℂ ({Z_m} ∪ {Y_m}) = ⊤`。
  原文 Step 2（帰納法）はそのまま写した。Step 3 だけ経路が違い、原文の `{I,σ^x,σ^y,σ^z}^{⊗M}` 基底ではなく
  既存の**行列単位基底** `matrixUnitBasis` を使った（どちらも `<tensor_basis>` の帰結で論法は同じ）。

### 形式化で表面化した原文の要修正点（新規）

- **`004/000` の `ε` の定義式が誤り**。`ε := σ^x_1 ⋯ σ^x_M = (√-1)^M Z_1 Y_1 + ⋯ + Z_M Y_M` の
  右辺は**和ではなく積** `(√-1)^M Z_1 Y_1 ⋯ Z_M Y_M`。
  根拠: `Z_m Y_m = σ^z_m σ^y_m = -√-1 σ^x_m`（Lean: `Ising2D.Z_mul_Y_same`）なので積なら一致するが、
  和だと `M = 2` で `(√-1)^2 (Z_1Y_1 + Z_2Y_2) = √-1 (σ^x_1 + σ^x_2) ≠ σ^x_1 σ^x_2` となり反例になる。
  Lean 側は `ε := σ^x_1⋯σ^x_M`（左辺）を定義とし、積表示の再帰形 `xString_succ_eq` まで証明済み。
- ~~**`006/000` の証明が未完（TODO 2 箇所）**~~ → **解消済み（下記「完了（2026-07-26）」参照）**。
  `[Z_μ,Y_ν]₊ = 0` は `μ = ν` でも成立する（`σ^y σ^z = -σ^z σ^y` で対角も消える）。

### 次にやること（Lean 側）

1. `004/001`（`Z_m, Y_m` は線型独立）— `Z_Y_generate_algebra` と `matrixUnitBasis` が使える。
2. `004/009` の `hat Z, hat Y` と `007`（その反交換関係）— `siteProd_anticomm_of_single_site` がそのまま効く。
3. `004/002`（`V_1 V_2` を `Z, Y, ε` で表す）— `V_1, V_2` の定義自体がまだ未形式化。
   `matExp` と `sigmaZ`/`sigmaX` で定義するところから。
4. `ε = (√-1)^M Z_1 Y_1 ⋯ Z_M Y_M`（積）の完全形。順序つき積（`List.prod` / `Finset.noncommProd`）の整備が要る。

## 完了（2026-07-25）: Phase 3 着手 — Lean 4 + mathlib4 の基盤構築と最初の formalization

実体は `lean/`。セットアップ手順・人手証明との対応規約・表現方針の根拠は `lean/README.md` に集約した。
**このセッションでは commit / push をしていない**（`lean/` 配下は作業ツリーに未コミットで存在）。

### 環境（バージョン固定済み）

- elan を新規導入（`~/.elan`）。`lean/lean-toolchain` = `leanprover/lean4:v4.32.1`。
- mathlib4 を **同名タグ `v4.32.1`** に固定（`lean/lakefile.toml` の `rev`、`lean/lake-manifest.json`）。
  toolchain とタグを揃えないとビルド済みキャッシュが効かないので、更新時は必ず両方同時に変える。
- `lake exe cache get` → `lake build` 成功（2405 jobs）。`.lake/` はリポジトリ直下 `.gitignore` で除外済み。

### `Mat(2,ℂ)^{⊗M}` の表現 — **行列表現を採用（最重要の設計判断）**

| | Lean での型 | 実装名 |
| --- | --- | --- |
| 採用 | `Matrix (Fin M → Fin 2) (Fin M → Fin 2) ℂ` | `Ising2D.TensorPow` |
| 比較 | `⨂[ℂ] (_ : Fin M), Matrix (Fin 2) (Fin 2) ℂ` | `Ising2D.AbstractTensorPow` |

**両者の ℂ-代数同型を証明済み**（`Ising2D.tensorPowAlgEquiv`）。同型写像は
`⨂ₜ x ↦ [(s,t) ↦ ∏ᵢ (xᵢ)_{s(i)t(i)}]`（= Kronecker 積）。構成は `PiTensorProduct.liftAlgHom` +
`Basis.piTensorProduct` と行列標準基底の突き合わせ。したがってどちらの表現で述べた命題も移送できる。

採用根拠（実際に両方書いて確認した事実）:

1. **抽象テンソル冪には `NormedRing` インスタンスが無く `NormedSpace.exp` が使えない**
   （`infer_instance` が失敗することを確認）。`V_1, V_2` が `exp` を含む本プロジェクトでは致命的。
   行列表現なら `Mathlib.Analysis.Normed.Algebra.MatrixExponential`（`Matrix.exp_units_conj` 等）が直接使える。
2. `<centralizer_is_scalar>`（`002/003`）が mathlib の `Matrix.center_eq_scalar_image` に帰着して数行で済む。
   人手証明の 4 ステップ（基底展開→積公式→係数比較→結論）が丸ごと既存で賄える。
3. 添字型 `Fin M → Fin 2` がスピン配置そのものなので、サイト局所演算子 `σ^x_k` 等を
   Kronecker 積の再帰なしに書ける。`Fin (2^M)` を使うと `finFunctionFinEquiv` の添字変換が散らばる
   （必要なら `Matrix.reindex finFunctionFinEquiv` で移せる）。
4. 行列式・跡・固有値・`Matrix.reindex` が全部使える（`008` の対角化 `P_μ, D_μ` で必要）。

### 形式化した命題（`sorry` 0。`lean/scripts/check-no-sorry.sh` で機械確認）

- `<tensor_basis>`（`002/000`）→ `Ising2D.tensorPowBasis` / `matTensorPowBasis`。
  mathlib の `Basis.piTensorProduct` に完全に帰着（自前で積んだ部分は「テンソル冪への特殊化」のみ）。
- `<conjugation_is_ring_homomorphism>`（`000/045`）→ `Ising2D.Conjugation.T_mul/T_one/T_add/T_comp/TMonoidHom`。
  mathlib の `MulSemiringAction (ConjAct Rˣ) R` に帰着（加法性まで込みで環準同型が出る）。
  原文の `Matrix.inv` 記法版も `matrix_conj_mul/one/comp` として併記。
- `<scalar_identity_commutes>`（`002/001`）→ `Ising2D.scalar_identity_commutes`。
- `<centralizer_is_scalar>`（`002/003`）→ `Ising2D.centralizer_is_scalar`（抽象側へ移送した版も併記）。
- 補助: 行列単位の積公式 `E_IJ E_KL = δ_JK E_IL`（`Ising2D.E_mul_E`）、`I = Σ_P E_PP`（`one_eq_sum_E`）、
  `exp(U A U⁻¹) = U (exp A) U⁻¹`（`matExp_units_conj`）。

### 形式化で表面化した原文の要修正点

- **`002/000`（`<tensor_basis>`）のステートメントが不正確**。
  (a) 「各 `(i_1,…,i_m)` について `e_{i_1}⊗⋯⊗e_{i_m}` **は基底である**」は誤り。基底なのは**族全体**。
  (b) 添字 `m` を「`V` の次元」と「テンソル冪の階数」に二重使用している（独立な量なので分離が必要）。
  Lean 側では修正版（基底の添字集合 `ι`、階数 `M` を分離し、族が基底）を形式化してある。
- **`000/045` Step 3 の正則性仮定は冗長**。合成則 `T_A ∘ T_B = T_{AB}` は
  `Matrix.mul_inv_rev`（mathlib では特異行列込みで成立）から仮定なしに従う。

### 次にやること（Lean 側）※ 1–3 は上の「Phase 3 継続」で完了済み

1. ~~`000/046`（交換子と反交換子の恒等式）~~ → 完了。
2. ~~`004/000` の記号定義と `006`（Z,Y の反交換関係）~~ → 完了。
3. ~~`004/014`（`Z, Y` が環として生成）~~ → 完了。
4. leanblueprint の導入検討は Phase 2（構造化TeX 移行）の完了状況を見てから。
5. mathlib に無いことが分かっているもの: `Real.arccosh`（自前定義が必要）。
   `Ad(exp X) = exp(ad X)` は `005/003, 007` の級数展開ルートで回避可能。

## 完了（2026-07-25）: Phase 2 T3/T4b — 章見出し・文書順・記号表を構造化TeXへ移行

`main.typ` にしか無かった「章題」「文書順」「インライン記号表」を `structured-latex/content/` へ移した。
これで証明本体で main.typ にしか無い情報は無くなった（残るは作業メモのみ。非移行と確定）。

- **schema に `heading` ブロックを追加**（`structured-latex/schema.mjs` / `schema.d.ts`）。
  `kind: "heading"` + `level`（1 が最上位。Typst の `=` が 1、`==` が 2）+ 必須 `title`。
  本文（statement/proof/notes）は持てない。ビューア側の契約
  （`realtime-web-preview/domain-model/src/block.ts`）も `kind` による discriminated union に更新し、
  `frontend/.../ui/heading-view.tsx` で描画。タイトルの `tex` を KaTeX で描く `TitleView` を追加
  （従来はブロックタイトルの LaTeX ソースが生文字列で表示されていた）。
- **文書順の正準表現＝ブロック配列の並び**（`content/*.mjs` をファイル名昇順 → 各ファイル内は配列順）。
  旧 `main.typ` の `#include` 順と完全一致することを機械照合済み（130 include / 130 sourcePath、差分0）。
  `sourceOrdinal` は「parts 章内でのソースファイル通し番号」であり文書順ではない。
  002章（000,001,**003,002**）と 008章（017 の直後に **036**、031 の後は 034,035,033,032,037,044,041,042,
  038,039,040,043）を実文書順へ並べ替え。008 の content 2ファイルは連番範囲で命名できなくなったため
  `008_TV1_hatZ_hatY_part{1,2}.mjs` へ改名。
- **記号表**: main.typ のインライン `#definition("記号の定義")` は `parts/004_転送行列/000`
  （`def_transfer_matrix_symbols`）との重複だった（相違は双対関係注記の旧版 `sinh(K)sinh(K*)=1` のみで、
  P1-1 で `sinh(2K)sinh(2K*)=1` に訂正済み）。重複ブロックは作らず、インライン側にのみ在った
  σ_k^y, σ_k^z, I_{(Mat(2,C))^{⊗M}}, Z_m/Y_m の p_m/q_m 対応を既存ブロックへ補記して集約。
- **非移行（確定）**: main.typ 末尾の作業メモ（`= 全体のノリ` / `= メモ` / 「次回やること」と
  埋め込み SageMath スニペット）は証明本体でないため移さない。
- 検証: `node structured-latex/tools/validate-content.mjs` → 142ブロック/14ファイル（見出し10・ラベル72・
  ref142 全解決）。`pnpm -r build` / `pnpm -r typecheck` / `biome check` 通過。KaTeX 全1647式 0エラー。
  `GET /api/document` で見出し10件が文書順に配信されることを確認。

## 完了（2026-07-22）: Phase 1 方針B — per-μ γ₂≠0 限定でフェルミオン定義域を厳密化

`docs/tasks/2026-07_toolchain-and-rigor` Phase 1 を Typst 上で完了。方針は **大域非臨界仮定（方針A）を採らず、per-μ の `γ_2(θ_μ)≠0` 条件で限定**。041/042 は削除せず γ₂=0 モードのカバレッジを保持。`typst compile main.typ` は exit 0（警告は既存の cetz deprecation と 002 linebreak の2件のみ、新規由来の警告・未解決 ref なし）。**push はしていない**（ブランチ worktree-cozy-sparking-token に未コミットで保持）。

変更/追加ファイルと要点:
- `parts/004_転送行列/000`: 双対注記を `sinh(2K_i)sinh(2K_i^*)=1` に訂正（旧 `sinh(K_i)sinh(K_i^*)=1` は誤り。K_i^*=-1/2 log(tanh K_i) と整合するのは 2K_i 版）。
- `008/023`（`<arg_of_gamma_2_mu>`）: 前提「γ₂(θ_μ)≠0 なる μ」を追加。末尾 `<0` を `|γ_2(θ_μ)|²=(s_2^*)²·((c_1cosθ_μ-s_1c_2)²+sin²θ_μ)` 経由で B>0 を明示して正当化し、負の実数ゆえ arg=π で claim を閉じた（従来は dangling）。
- `008/024`: 前提「γ₂(θ_μ)≠0」を追加（arg は非零でのみ定義、relation_of_gamma_2 で両者同値を明示）。
- `008/029`（`<def_fermi>`）: ψ_μ, ψ_μ^† を **γ₂(θ_μ)≠0 なる μ にのみ定義**と本体で限定。#note で「γ₂(θ_μ)=0（021 より μ=±M かつ臨界 c_1=s_1c_2、= 043 の Ising 臨界点 sinh2K_1 sinh2K_2=1）では正規化 1/γ_2(-θ_μ) が不能で **ψ_μ は存在しない**」を明記。臨界の μ は 041/042 場合2で hatZ,hatY 経由で直接処理。
- `008/030`,`031`,`037`: ステートメントを γ₂(θ_μ)（031 は γ₂(θ_ν) も）≠0 の μ,ν に限定。037 の X の和も 032 と同じ限定和に更新。特定される ν が限定和の添字集合に属することを明示。
- `008/032`（`<def_Vprime>`）: V' の和を `sum_(mu in {1..M} : γ_2(θ_mu)≠0)` に限定。除外 μ（臨界 μ=M）は 041 Step1 より γ(θ_μ)=0 ゆえ寄与なしを note で明示（041 の旧「規約」依存を解消）。
- `008/041`: 冒頭 #note の「係数0で項を落とす規約」を撤去し「032 の定義で和は γ₂≠0 の ν のみ」に変更。X を限定和に。Step 3 の場合分け「(i) γ(θ_ν)=0」を撤去（限定和では常に γ₂(θ_ν)≠0 ⟹ ψ_ν,ψ_{-ν} 定義済み、Step 2 対偶で δ=0）。Step 2 見出しの結論を γ_2(θ_ν)=0（ゆえに γ(θ_ν)=0）に。
- `008/044`（新規, `<A_theta_is_identity_when_gamma2_zero>`）: 小補題「γ₂(θ_μ)=0 ⟹ A(θ_μ)=I」を証明追加（γ₂(θ_μ)=0 ⟹ γ₂(-θ_μ)=0 [022] かつ det [034]+γ₁≥1 [035] で γ₁=1 ⟹ A=I）。main.typ に 037 と 041 の間で #include。042 場合2の A=I 裏打ちを 027（proof 無し）から本補題へ張り替え。026 の「TODO: 証明」コメントと 027 の A=I も本補題を #ref するよう更新（044 は 016/022/034/035/036 のみ依存、026/027 非依存ゆえ循環なし）。
- `038`/`039`: ステートメント不変。042（全 μ∈cal(M) で両場合カバー）+ 013（全 μ の DFT）経由で臨界含め全 x で成立を維持（compile・ref 解決で確認）。

未着手/TODO 保持:
- `021`（`<gamma_2_theta_is_0>`）と `043`（`<critical_condition_c1_eq_s1_c2>`）の proof は本 Phase では TODO 保持（方針Bの厳密性には非必須）。
- SageMath 数値再検証（X-1）は横断タスクとして継続（今回の変更はステートメント限定と補題追加が主で、030/037/038/039 の数値結論は不変のはず）。

## 進行中（2026-06-27）: 臨界点と γ₂(θ_M)=0 / V' 定義の穴のトレース

- 新規 claim `008/043`（`<critical_condition_c1_eq_s1_c2>`）: `c_1 = s_1 c_2 ⟺ s_1 s_2 = 1`（= Ising 臨界条件 sinh2K_1 sinh2K_2=1）。**proof は TODO**。数値確認済み（c_1=s_1c_2 の曲線上で sinh2K_1 sinh2K_2=1.0000）。
- これにより `γ_2(θ_M)=0`（θ_M=2π、021 `<gamma_2_theta_is_0>` で μ=±M かつ c_1=s_1c_2）⟺ **臨界点**。すなわち ψ_M が def_fermi で未定義になる特異点は臨界点そのもの。
- **「臨界点を除かないと議論できない」最初の箇所のトレース**:
  - 026（A(θ) 固有値・固有ベクトル）: γ₂=0/≠0 で場合分け済み、全 μ で OK（γ₂=0 では A=I）。
  - **027（P_μ, D_μ）が最初に明示的に `γ_2(θ_μ)≠0` を要求**（正規化 c=1/(2√M γ₂(-θ_μ)) に 1/γ₂）。臨界では μ=M で破れる。
  - 029（def_fermi）: ψ_μ を P_μ 経由で定義 → ψ_M が臨界点で未定義。
  - 030/031/037: 「μ∈cal(M) 全体」と称するが proof は ψ/P_μ 経由 → 実質 γ₂≠0 のモードのみ（臨界では μ=M を暗黙除外、ステートメントが過剰に広い）。
  - **032（V' 定義）で和 Σ_{μ=1}^M が μ=M を含むため、臨界点では V' という対象自体が大域的に未定義** = ここから議論が成立しない。038/039 はこれを継承。
- 対処方針（未着手）: 032 の和を「γ_2(θ_μ)≠0 の μ」に限定し非臨界の主張として閉じる / 臨界ゼロモードを別扱い。自由エネルギー導出の方針に依存。

## 完了済み（2026-06-21）: 013 符号バグ修正

数値検証（SageMath）で 013 の符号バグが判明し修正した。`typst compile main.typ` は exit 0（既存 cetz deprecation と 002 linebreak の2件のみ）。

- バグ内容: `<def_hatZ_hatY>`（004/009）の定義では `hat(Z)_mu^((-))` は全 j で重み +1（uniform）。superscript `(-)` のとき `minus.plus` の下側 = +1。ところが `013` が `c_j := cases(-1 if j=1, 1 else)` と置き j=1 を -1 にしていて定義と矛盾していた。
- 数値確認: 正しい復元は `Z_m = (1/M) sum_mu hat(Z)_mu^((-)) exp(+i m 2π μ/M)`（c_m なし）で誤差 1e-16。c_m 版は m=1 で `-Z_1` を返し誤差 2.0（誤り）。
- 修正: `004/013`（`<recover_Z_Y_from_hatZ_hatY>`）から c_j/c_m を全廃し hat(Z)^((-)) を uniform として Y 側と完全対称に再導出。`008/038`（`<T_V_eq_T_Vprime>`）Step2 の `c_m/M` を `1/M` に統一（c_m 定義削除）。`grep c_m|c_j` で 013/038 に残存なし（031 の c_mu はフェルミオン正規化因子で無関係）。
- 038 の定理自体は元々正しく結論 `T_((V))=T_((V'))` は不変。修正は誤った符号規約依存箇所のみ。042/030/037/def_fermi は正しい uniform 版を使用しており未変更。
- 038/039 は数値検証で全空間成立を確認済み（セクター '-'、hat(Z)^((-)) uniform）。`T_V(psi)=e^gamma psi` 全空間 1e-15、037 と整合。

## 次回やること（優先度順）

### 0. 構造化テキストのリアルタイム Web プレビュー（記載当時は未着手・別ツール）

汎用ツールとしてリポジトリ直下 `realtime-web-preview/` に切り出した。要件は
`realtime-web-preview/docs/requirements.md`。本プロジェクトの `structured-latex/` は
その入力ソースのリファレンス実装という位置づけ。ビューア等は未実装、技術スタック未決定。

> **その後（2026-08-01）**: 実装され稼働している。さらに structured-latex システムの
> モジュール `structured-latex/live-preview/` へ吸収され、`realtime-web-preview/` は削除された。
> 要件の現在地は `structured-latex/live-preview/docs/requirements.md`。
> 本プロジェクトの `structured-latex/content` が既定の入力ソースである点は変わっていない。

### 1. 038 `T_V = T_{V'}` の proof（完了 2026-06-21）

`038_claim_T_V_eq_T_Vprime.typ` の `#proof[TODO]` を完成。`typst compile main.typ` は exit 0（警告は既存の cetz deprecation と 002 の linebreak の2件のみ、新規由来の警告・未解決 ref なし）。

証明構成（環準同型 + 生成元一致）:
- Step1: 合成則 `<conjugation_is_ring_homomorphism>`（新規 000/045）で `T_(V) = T_V`（`V := (V_1^pm)^(1/2) V_2 (V_1^pm)^(1/2)`）。`T_(V), T_(V')` ともに単位的・乗法的・線型。
- Step2: `<recover_Z_Y_from_hatZ_hatY>`（新規 004/013, DFT逆変換）+ `<T_V_eq_T_Vprime_on_hatZ_hatY>`（新規 008/042）で各 `Z_m, Y_m` 上で一致。
- Step3-4: 一致元の集合が部分多元環をなし、`<Z_Y_generate_algebra>`（新規 004/014）より全空間。

新規ファイル: 000/045（共役写像は環準同型）, 000/046（交換子と反交換子 `[ab,c]=a[b,c]_+-[a,c]_+b`）, 004/013（DFT逆変換）, 004/014（Z,Y が環を生成）, 008/041（gamma_2=0 のとき T_(V') が hatZ,hatY を固定）, 008/042（T_(V) と T_(V') が hatZ,hatY 上で一致）。
ラベル付与した既存: 010(`def_T_g`),015(`def_T_V`),018(`def_theta_mu`),027(`diagonalization_P_D`),030(`commutation_V_psi`),033(`def_gamma_theta_mu`,`lambda_eq_exp_gamma`),034(`det_A_theta`),035(`gamma1_geq_1`),002/000(`tensor_basis`),004/000(`def_transfer_matrix_symbols`)。

gamma_2=0 障害の処理: gamma_2(theta_mu)=0 の mu ではフェルミオン未定義で P_mu 経路が使えない。041 で T_(V') が `[X,hatZ_mu]=[X,hatY_mu]=O` 経由で hatZ,hatY を固定と直接証明（鍵: gamma_2=0 ⇔ sin theta=0 かつ c_1 cos theta=s_1 c_2、mu≡±nu mod M ⇒ cos,sin 保存 ⇒ gamma_2(theta_nu)=0 ⇒ gamma(theta_nu)=0 で X の該当項が消える。普遍反交換子 `<anticommutator_of_hat_Z_and_hat_Y>` 使用）。042 で gamma_2≠0 は P_mu 可逆経由、gamma_2=0 は 041 + A(theta_mu)=I で統合。

【未解決の基盤上の注意】032 の V' 定義 `sum_(mu=1)^M psi_mu^dagger psi_(-mu)` は mu=M（gamma_2=0）で psi_M が未定義。041 では「係数 gamma(theta_M)=0 ゆえ当該項を省く」規約を note で明示し Step1 で coefficient=0 を別証。完全厳密化するなら 032 の和を「gamma_2(theta_mu)≠0 の mu に限定」へ書き換えるのが望ましい（今回は既存 proof を壊さない方針で規約対応）。

### 2. 039 `V = cV'` の proof（完了 2026-06-21）

`039_claim_V_eq_Vprime.typ` の `#proof[TODO]` を完成。**009（クリフォード群、TODO）には依存しない**方針に変更（中心性で証明）。`typst compile main.typ` は exit 0（既存の cetz deprecation と 002 linebreak の2件のみ、新規由来の警告・未解決 ref なし）。

証明構成（中心性経由、クリフォード群を経由しない）:
- 新規中心補題 `parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ`（`<centralizer_is_scalar>`）: `Mat(2,CC)^(⊗M)` の中で全元と可換な元は `c·I` に限る。行列単位 `E_(ij)` の積公式 `E_(ij)E_(kl)=δ_(jk)E_(il)` を `<tensor_basis>` でテンソル積に持ち上げ、`W=Σw_(IJ)E_(IJ)` を全 `E_(KL)` と可換 ⟹ 対角一定・非対角0 ⟹ スカラー。`002/001`（`<scalar_identity_commutes>`、逆向き）と対。main.typ に 001 の直後で #include 追加。
- 039 本体: `W := V'^(-1)V`（可逆）。`<T_V_eq_T_Vprime>`（Step1 の `T_((V))=T_(V)` 含む）+ `<mat_conj>` から全 x で `VxV^(-1)=V'xV'^(-1)`、`V=V'W`・`V^(-1)=W^(-1)V'^(-1)`（`<conjugation_is_ring_homomorphism>` の逆元公式）を代入し `Wx=xW`。中心補題で `W=cI`、可逆ゆえ `c≠0`、よって `V=cV'`、`c∈CC^×`。
- 039 のステートメントの `V` は `<def_T_V>` 由来の `V=(V_1^pm)^(1/2)V_2(V_1^pm)^(1/2)` と同一視（claim 本文と note に明記）。

## 完了済み（2026-05-30）

### structured-latex 残りファイルの変換

`structured-latex/content/` 以下へ残りの `parts/**/*.typ` の変換を追加済み。`node structured-latex/tools/validate-content.mjs` は 123 blocks で通過。

### 032/037 V' 符号修正と SageMath 検証

005（P_μ 正規化）の修正により、新しい反交換関係 $[ψ†_μ, ψ_ν]_+ = δ^M_{μ+ν,0} I$ で 031 が成立することは数値検証済み。しかし、現状の $V' := exp(-Σ_{μ∈M} γ(θ_μ)(ψ†_μ ψ_μ - 1/2))$ では:

$
"ad"(X)(ψ†_μ) = -2γ(θ_μ) ψ†_{-μ}
$

となり、$ψ†_μ$ は $"ad"(X)$ の固有ベクトルでない（$ψ†_{-μ}$ に写る）。よって 037 の Claim「$T_{(V')}(ψ†_μ) = e^{-γ}ψ†_μ$」は成立しない。

修正案:
$
V' := exp(+ sum_{μ=1}^M γ(θ_μ) (ψ†_μ ψ_{-μ} - 1/2))
$

- $ψ†_μ ψ_μ → ψ†_μ ψ_{-μ}$（反交換関係 $[ψ†_μ, ψ_ν]_+ = δ^M_{μ+ν,0}$ と整合）
- 和を $μ ∈ \{1, ..., M\}$ に半分（モードの二重計上を回避）
- 符号は $T_V$ と一致させるため $+$（030 で $T_V ψ†_μ = e^{+γ}ψ†_μ$）

これにより `[ψ†_μ ψ_{-μ}, ψ†_ν] = δ^M_{ν-μ,0} ψ†_μ` で、$ψ†_ν$ が固有ベクトルになる。

実施済み:
- `032_definition_Vprimeの定義.typ`: `V' = exp(+Σ γ(ψ†_μ ψ_{-μ} - 1/2))` に修正
- `037_claim_T_Vprimeのpsiへの作用.typ`: `T_(V')(ψ†_μ) = e^(+γ)ψ†_μ`, `T_(V')(ψ_μ) = e^(-γ)ψ_μ` に修正
- `sagemath/check/037_claim_T_Vprimeのpsi/`: `M=2,4`、`K1,K2` 7組で PASS
- `structured-latex/content/008_TV1_hatZ_hatY_20_40.mjs`: 032/037 の符号を同期
- `typst compile main.typ`: 警告のみで成功

### main.pdf の追跡停止

`exact-solution-of-2d-ising-model/main.pdf` は生成物として Git から削除し、`.gitignore` に追加した。

## 完了済み（2026-05-02）

### 005 P_μ 正規化の修正

- 026: claim 末尾に `<eigenvector_of_A_theta>` ラベル追加
- 027: $P_μ$ の自由定数を $c = 1/(2√M γ_2(-θ_μ))$ に固定
- 029: フェルミオン定義を新 P_μ に合わせて更新（note の簡約形に符号 $ε_μ$ 追加）
- 030: proof を $P_μ$ 抽象的に扱う形に簡素化（A = P D P^{-1} 構造を直接利用）
- 031: ステートメントを $δ^M_{μ+ν,0}$ に統一、proof で $c_μ c_ν$ 因子を頭で因子分け、係数 1 を導出
- 037: 反交換関係参照を更新、proof 構造の破綻を明示（remark + 中断 NOTE）
- SageMath: `sagemath/check/031_claim_psiの反交換関係/` で 3 ケース全 PASS（M=100、7 パラメータ）
- typst compile: エラーなし

## 完了済み（2026-04-04）

- 032: claim → definition に変更（`032_definition_Vprimeの定義.typ`）
- 033: `gamma(theta_mu)` の定義 + `lambda_pm = e^{+-gamma}` の claim/proof
- 034: `det A(theta_mu) = 1` の claim/proof（036 の行列分解を利用）
- 035: `gamma_1(theta_mu) >= 1` の claim/proof
- 036: `A(theta_mu) = B_1 B_2 B_1` の行列分解 claim/proof
- 037: `T_{V'}` の psi への作用 claim/proof（→ 005 で構造的問題が判明）
- 038, 039: claim のみ（proof TODO）

## 未完 TODO の根拠（005 行列空間の内積・ノルム・収束と ad 展開公式）

### `exp_conjugation_proof_002_theorem_Ad_exp_lie`（一般 Lie 群上の $\mathrm{Ad}(\exp X)=\exp(\mathrm{ad}X)$）

`todo()` を残した。根拠（一次情報）:

- `grep -rn "Lie群\|リー群\|\\mathrm{Lie}" structured-latex/content/` の結果、ヒットは
  `005_exp_conjugation_proof.mjs` 内の**この主張自身と、その直前の概要文だけ**である。
  多様体・Lie 群・Lie 環・$\mathrm{Lie}(G)$・$\mathrm{Aut}(G)$ の Lie 群構造を
  **定義したブロックはリポジトリに 1 件も存在しない**。すなわち主張の記号が意味をもつ土台が未整備で、
  証明以前に statement が定義されていない状態である。
- 原本 `_old/typst/parts/005_.../001_theorem_リー群上のAd(exp(X))=exp(ad(X)).typ` も
  proof は `TODO:` のみで、移行漏れではない（`verify-no-lost-proofs.mjs` も同判定）。
- **本論はこの一般版に依存しない。** 本プロジェクトで必要なのは行列環 $\mathrm{Mat}(n,K)$ 上の
  $e^{X}Ye^{-X}=e^{\mathrm{ad}_X}(Y)$ だけであり、これは新規ブロック
  `exp_conjugation_proof_010_theorem_matrix_exp_conjugation`（labels: `matrix_exp_conjugation`）で
  **完全に証明済み**。その旨をこのブロックの statement 本文にも明記した。

埋めるための条件: 多様体・Lie 群・Lie 環・指数写像の定義ブロックを整備し、
$\mathrm{Aut}(G)$ が Lie 群で $\mathrm{End}(\mathfrak{g})$ がその Lie 環であることを示すこと。

### 同章で完成させたもの（参考）

- `exp_conjugation_proof_003_definition_M_n_C_convergence`（内積・ノルム・収束、TODO 3 件）→ 完成。
  Frobenius 内積 $\langle A,B\rangle=\mathrm{tr}(A^{*}B)$ を新規定義（labels: `def_frobenius_inner_product`）。
  ノルム・収束・完備性は 002 章で既に定義・証明済み（`def_matrix_norm` / `matrix_norm_triangle_inequality` /
  `matrix_norm_submultiplicativity` / `matrix_completeness`）なので**重複定義せず参照で結んだ**。
  非可算集合 $\mathbb{R}/\mathbb{C}$ の完備性へ移行する箇所を statement (5) で明示。
- 新規 `exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms`（labels: `frobenius_inner_product_axioms`）:
  Hermite 内積の公理・Cauchy--Schwarz・そこからの三角不等式を証明。
- `exp_conjugation_proof_004_theorem_ad_binomial`（labels: `ad_binomial`）→ $m$ の帰納法で完成
  （Pascal の法則を Step 1 で明示）。原本 note の「未証明につき使用禁止」は撤回した。
- 新規 `exp_conjugation_proof_010_theorem_matrix_exp_conjugation`（labels: `matrix_exp_conjugation`）:
  $\|Q_N-P_N\|\le 2\|Y\|E(a)R_{\lfloor N/2\rfloor}(a)\to 0$ という評価で、二重級数の一般論を使わずに証明。

### 隣接 TODO（2026-07-26 に解消済み）

`exp_conjugation_proof_008_theorem_exp_ad_series`（labels: `brianhall_exc14`）、
`exp_conjugation_proof_009_theorem_exp_conjugation_main`（labels: `brianhall_3.35`）の
「未証明につき使用禁止」注記、および `008_TV1_hatZ_hatY_part1.mjs` の `exp_X_Y_exp_-X` の
「暫定」proof は、いずれも `matrix_exp_conjugation` を根拠に完全証明へ書き換えて解消した。
詳細は本ファイル冒頭の「完了（2026-07-26）: `todo()` 以外の形で残っていた未完 4 箇所」を見よ。
なお `exp_conjugation_proof_002`（一般 Lie 群版）は上記の根拠により **`todo()` のまま残置**である。

---

## 完了（2026-07-26・追補2）: `exp(X) A exp(-X)` の級数展開（`<exp_X_Y_exp_-X>`）を Lean で形式化

`Definition016_TV.lean` / `Definition030_Fermi.lean` で仮定に持ち上げてある `T_V_hatZ_hatY` を
閉じるための土台。**既存 Lean ファイルは変更せず**（`Ising2D.lean` の import 行追加と
`scripts/check-no-sorry.sh` の targets 追記のみ）、新規 2 ファイルで 2 本立てにした。

- 抽象版 `lean/Ising2D/Abstract/ExpConjugation.lean`（`Ising2D.Abstract`）
- 具体版 `lean/Ising2D/Part008/Claim006_ExpConjugation.lean`（`Mat(2,ℂ)^{⊗M}`、抽象版の系）

### 証明の骨格（リー環を使わない・級数展開ルート）

左乗法 `L_X : A ↦ X A` と右乗法 `R_X : A ↦ A X` は**線型作用素として可換**（結合律だけで出る）。
`ad X = L_X - R_X` なので、可換な作用素の指数法則から `exp(ad X) = exp(L_X) ∘ exp(-R_X)`。
`(L_X)^n = L_{X^n}`, `(R_X)^n = R_{X^n}` と `L`, `R` の連続線型性から
`exp(L_X) = L_{exp X}`, `exp(R_X) = R_{exp X}`。よって `exp(ad X)(A) = exp(X) A exp(-X)`。
**`L` が代数準同型であることすら使っていない**（冪の式と連続線型性だけ）。右乗法は反同型だが
`(R_X)^n = R_{X^n}` は左乗法と同形なので、反対環 `Aᵐᵒᵖ` を経由する必要が無い。

### 導出して確定させた係数（後段で必ず使う）

`ad X z = α y`, `ad X y = β z` で `s^2 = αβ` のとき

```
exp(X) z exp(-X) = cosh(s) z + α sinhc(s) y
exp(X) y exp(-X) = cosh(s) y + β sinhc(s) z
```

`sinhc(s) := sinh(s)/s`（`s = 0` では `1`。`Ising2D.Abstract.sinhc`）。`sinh(s)/s` のままだと
`s = 0` で 0 割りになるので分けて定義した。冪級数 `sinhc(s) = Σ_k s^{2k}/(2k+1)!` も証明済み
（`Abstract.hasSum_sinhc`）。

原文 `<extract_taylor_coefficient_of_Z_Y>` の (h1.z) `cosh(K_1)Ẑ_μ + i e^{-iθ_μ} sinh(K_1)Ŷ_μ` は
`s = K_1`, `α = i e^{-iθ_μ}K_1`, `β = -i e^{iθ_μ}K_1`（`αβ = K_1^2 = s^2`）の場合として
上式から出る。**すなわち原文の cosh/sinh の形は正しい。**

### 次に必要なもの（`T_V_hatZ_hatY` を無条件にするために残っているのはこれだけ）

`<commutator_of_H_and_Z_Y>`（1 重交換子 `[i K_1 H_1^{(±)}/2, Ẑ_μ^{(±)}]` 等の具体計算）。
これを `Ising2D.matExp_conj_two_dim_z` / `..._y` に代入すれば
`<extract_taylor_coefficient_of_Z_Y>` の 4 式がそのまま出て、
`TV_hatZ_hatY_of_action` の仮定 `hT1`, `hT2` と `TV_psiDag_of_action` の `hT` が外せる。

### 原文について気づいたこと（穴ではない）

`<exp_X_Y_exp_-X>` の statement は `exp(X)` の正則性を述べるが、逆行列が `exp(-X)` である
ことは `<matrix_exp_conjugation>` (3) に委ねている。Lean 側は `Ising2D.matExpUnits` が
`exp X` を単元として与え逆元が定義から `exp(-X)` なので、この点に穴は無い
（`Ising2D.matExpUnits_conj_eq_tsum`）。

### 実装上の注意（次に触る人へ）

`Matrix` にはノルムの標準的な選び方が無いため、抽象版（ℂ 上の完備ノルム環が前提）を
`TensorPow M` へ特殊化するには `open scoped Matrix.Norms.Operator`（`l^∞` 作用素ノルム）で
局所的に instance を入れる必要がある。**公開する定理の statement にはこの instance を
持ち込まない**ため、mathlib の `Matrix.exp_add_of_commute` と同じ形で
「statement は instance 無しで書き、証明だけ scoped instance 付きの補題へ委ねる」構成にし、
照合のため `set_option backward.isDefEq.respectTransparency false` を使っている。
`open scoped ... in by ...`（tactic への `in`）では instance が入らないので、
**scoped instance を要する補題は独立した宣言として `open scoped ... in theorem` で書くこと。**

---

## 完了（2026-07-27）: 章 013「偶セクターの半整数運動量モード」の Lean 形式化

`structured-latex/content/013_even_sector_modes.ts` の数学的主張 7 本をすべて Lean で形式化した
（`sorry` ゼロ、`lake build` 成功、`scripts/check-no-sorry.sh` exit 0）。
新規ファイルは具体版が `lean/Ising2D/Part013/`、抽象版が
`lean/Ising2D/Abstract/AntiperiodicFourier.lean`。詳細は
[lean/docs/ch013-formalization.md](lean/docs/ch013-formalization.md)。

### 抽象版で判明した本質（README 4 節の「何が本質的か」への答え）

**整数運動量と半整数運動量は、同じ抽象版の別の特殊化である。**

- `e^{-iθ~}` は 1 の原始 `2M` 乗根 `ξ` であり、**半整数運動量とはその奇数周波数
  `ξ^{j(2μ-1)}` のこと**。整数運動量は `ζ = ξ^2`（原始 `M` 乗根）の偶数周波数。
- 本文が「仕組みは 1 つの等式 `e^{-iMθ~_μ} = -1` に集約される」と書いている等式の正体は
  **`ξ^M = -1`**。証明は「`(ξ^M)^2 = 1` かつ原始性から `ξ^M ≠ 1`、体だから `-1`」の 3 行で、
  指数関数も円周率も複素数であることも効いていない。
- 指数和 `antiperiodic_exp_sum` は、定数位相 `ξ^k` を括り出すだけで**整数運動量の `exp_sum` と
  同じ直交性補題**（`Abstract.sum_zpow_primitiveRoot`）に帰着する。
  本文の `(-1)^l` はその定数位相を `k = lM` で評価した `ξ^{lM} = (ξ^M)^l` にすぎない。
- **対の添字が `μ+ν ≡ 0` から `μ+ν ≡ 1` へずれる理由は、
  奇数 + 奇数 = `(2μ-1)+(2ν-1) = 2(μ+ν-1)` の `-1` のただ 1 点**。
- 添字の周期性 (2) と交換関係 (A)〜(D) は、**既存の抽象版そのまま**
  （`Abstract.transform_periodic` と `Abstract.CliffordTriple.lie_sum_*`）の特殊化で出る。
- **「`(+)` セクターで 008 章が壊れる」の正体は `Dz ≠ Dz'`**（`hat(Z)^{(±)}` と `hat(Z)^{(∓)}` の
  反交換子が違う）の 1 点。`check(Z)` は族が 1 つ（`z = z'`）なのでこの差が構造的に存在しない。
- 逆変換だけは既存の `Abstract.inverse_dft_abstract`（`M` 乗根版）の特殊化にならないので
  `Abstract.inverse_dft_antiperiodic` を新設した（証明の骨格は同一）。

### 本文の誤り・穴

**見つからなかった。** 数値検証（`sagemath/check/046_claim_even_sector_modes/`、`M = 2,3,4,5`）とも
すべて整合する。`why_008_applies_only_to_minus_sector` の第 2 式は 008 章の原文 (5) の
**訂正版**（008 章原文は符号・係数を誤っている）を採用しており、Lean と一致する。

### 次に触る人へ

- `lean/README.md` への統合（形式化済み命題の表・2 本立ての表への追記）は未実施。
  素材は `lean/docs/ch013-formalization.md` にある。
- 014 章以降（`periodicity_of_check_fermi`、`Ǎ(θ~)` の対角化、`ψ̌`、`V = cV'`、固有値）は未着手。
  013 章で用意した `Ising2D.checkZ` / `checkY` / `checkPhase` / `CheckIndex` と
  4 本の交換関係・3 本の反交換関係がその土台になる。
- `deltaMod` を含む `if` を `dvd_neg` で書き換えるときは `rw` ではなく `simp only [dvd_neg]` を使う
  （`Decidable` インスタンスに依存するため `rw` は motive not type correct で落ちる）。
# 論文構成の分類軸（2026-08-30）

複素行列版の主題は「高校生でも読める具体的な行列計算として2次元イジング模型の厳密解を積み上げる」である。「実数解析への脱出を伴う／有限複素行列だけで閉じる」および「可算／非可算」は章・節境界に使わない。章境界は対象の意味がイジング模型に依存するかで定め、解析や極限は必要な入力として具体的に説明する。

機械可読棚卸しは全302件について、二章分類、イジング固有語彙、説明粒度、直接依存、強連結成分を縮約した章内トポロジカル順を保存する。数学的道具立てからイジング章への前提依存は生成時に拒否する。状態と次の一歩は `docs/tasks/paper-organization-state.md`、再生成規則は `docs/tasks/paper-organization-runbook.md` を正本とする。

# 論文構成再編 tick（2026-09-02）

旧残余ブロックから `(V^{(+)})^{-1}` の正定値性と `\mathrm{tr}(V^{(+)})>0` を独立した主張へ分け、Lean の `VPlusInv_posDef`・`trace_VPlus_pos` との対応を同期した。候補逆行列の全固有値正値性は独立した SageMath 検査で確認した。現行の章内依存順は正定値性59、`\mathrm{tr}(V^{(+)})>0` 60、可逆性61、逆行列の正定値性62、残余の `\mathrm{tr}((V^{(+)})^{-1})>0` 63である。次回は順63だけをレビューし、順64以降へは進まない。

# 論文構成再編 tick（2026-09-03・第二転送行列による共役写像の線型性）

第二の転送行列 `V_2` による共役写像の複素線型性を独立一項として確定した。直接入力は一般の `T_g` の複素線型性、`V_2` の可逆性、半整数運動量と添字集合である。Lean の `linearity_of_T_V2` へ本文と同じ格子幅・添字仮定を加え、SageMath の検査名を本文ラベルへ同期した。前回確定済みの半指数行列特殊化と合わせ、「二つの転送因子による共役写像の線型性」の二項節を閉じた。レビューで検出した数作用素の冪等性から反交換関係と数作用素の定義への依存欠落も、数式内 `\blkref` を意味的前提として固定して復旧し、合成作用のLean説明へ二つの線型性を明記した。次回は合成共役写像 `T_{(V^{(+)})}` の定義と、それが `V^{(+)}` による共役へ一致する主張の二項だけを扱う。

# 論文構成再編 tick（2026-09-03・外部入力本文の同期）

remote defaultで、Pauli行列の積にある `i\cdot(-i)=1` の省略説明が可換律と直前の計算による二段へ展開され、一因子の反可換性ではクロネッカー積の積・多重線型性の根拠が既存ラベル参照へ置き換わった。主張、計算結果、直接依存、確定済みの章・節境界はいずれも不変であることを差分と再生成で確認し、両ブロックを入力とする確定節の本文 fingerprint を現行本文へ同期した。前回tickの第二転送行列による共役写像の線型性の成果はそのまま保持した。

## 2026-09-05: 構成再編の進捗が論文本文から判別できないことを検出

人間から「論文が以前と全く変化していない」と指摘された。調べた結果は次のとおり。

- 構成再編は 2026-08-30〜09-03 に 30 個の節境界（全305件中76件）を確定していたが、成果は
  状態台帳と機械可読棚卸しにしか現れていなかった。本文の章立ては節境界が全件確定するまで
  書き換えないため、論文本文を見ても進捗が判別できない。

対応として、構成ページへ生成時の版と再編の現在地（確定件数・残件数）を載せた。進捗はリポジトリ横断の
[ゴール台帳](../docs/ゴール台帳.md) の該当ゴールが正本で、
`bash scripts/verify-complex-matrix-ising-paper-artifacts.sh` で判定する。

次の一手は、残り229件の節境界確定を続けることである。

## 2026-09-05: 対称化転送行列 W の実対称正定値性を節として確定

再編ループの定期起動が止まっているあいだ、次の一単位を手元で進めた。章内依存順71の
「対称化転送行列 W は実対称正定値であり可逆」の一項だけを扱った。

証明が $W=BV_2B$ と $B=V_1^{1/2}$ を根拠なしの地の文で使っていたので、対称化転送行列の定義と
平方根因子の定義への参照を入れ、依存グラフへ現れるようにした。そのうえで、直接入力（W と
平方根因子の定義、エルミート正定値の定義、エルミート行列の指数関数の正定値性、二つの生成子の
実対称性、転送行列の記号）、Lean の合同変換・可逆性の各補題、SageMath の対称性・実性・
最小固有値正値性の検査を照合し、一項の節として確定した。節は31個、配置済みは305件中77件。

節を閉じる根拠は、直後の順72（Rayleigh 上限）が単位球面上の上限という実数固有の道具を新たに
入力へ加えることである。この依存方向と新規入力集合も棚卸し生成時に固定検査する。

あわせて、姉妹プロジェクト側の「根拠の位置を行末へ統一」する編集で、レビュー済み本文の指紋8件と
自動抽出の依存辺（クロネッカー積の規則と線型性、cosh/sinh の基本性質、指数の積と零行列の指数、
固有空間への制限・同一視・射影子の性質）がずれていた。各差分が表示の変更だけで数学的内容と
参照を変えていないことを確認し、指紋を同期して依存辺を明示的な意味的前提として復旧した。

次の一単位は Rayleigh 上限の定義一項だけとし、実数への脱出箇所を明示する。

## 2026-09-05: Rayleigh 上限の定義を実数への脱出点として節に確定

章内依存順72の「単位球面上の二次形式の上限 c(M)」の定義一項を確定した。

本文の有界性の根拠が「半正定値の Cauchy--Schwarz を使うまでもなく」という散文で、実際に引く
ブロックが定まらないうえ、通常のベクトルの Cauchy--Schwarz はこの論文にブロックとして存在しない。
そこで、各成分が |x_i| <= ||x|| = 1 を満たすことを二段で示し、成分表示の二重和を有限和の三角不等式で
押さえる形へ書き換えた。これで各行が定義または初等的な不等式を一つだけ引く。

上限の存在がこの論文で実数へ脱出する箇所であることを本文へ明記し、節の記録にも脱出理由として
残した。節を閉じる根拠は、直後の順73が半正定値 Cauchy--Schwarz を新たな入力に加えることで、
この依存方向も棚卸し生成時に固定検査する。節は32個、配置済みは305件中78件。

次の一単位は作用素評価 ||Wx|| <= c(M)||x|| の一項だけとする。

## 2026-09-05: 上限による作用素評価の一項を節に確定

章内依存順73の「||Wx|| <= c(M)||x|| とその冪」を確定した。後置きしていた半正定値
Cauchy--Schwarz と上限の評価の参照を、適用した各行の末尾へ移し、ノルムの定義も数式内から
ブロックへ接続した。正の数で割る操作と平方根を取る操作は含意の鎖として開き、非負性の条件を
根拠に書いた。冪の主張は基底段と帰納段に分けた。

節を閉じる根拠は、直後の順74で出力がベクトルの評価から行列のトレースの評価へ切り替わることで、
依存方向も棚卸し生成時に固定検査する。節は33個、配置済みは305件中79件。

次の一単位はトレースの挟み込みの一項だけとする。

## 2026-09-05: トレースの挟み込みを三つの境界候補として棚卸し

章内依存順74のトレースの挟み込みを見たところ、一ブロックに三つの主張が束ねられていた。標準基底に
よる表示から偶奇に分けて示す上からの評価、モーメント列の対数凸性、対数凸性の望遠鏡積から得る
下からの評価である。一ブロック一主張へ揃えるには三分割と形式化の同期が要るので、Runbook に従い
本文は変更せず、三つを境界候補として状態台帳へ記録した。次回は先頭二項（上からの評価と対数凸性）
だけを扱う。

## 2026-09-05: トレースの挟み込みを三主張へ分割し、先頭二項を節に確定

前回境界候補として記録した分割を実施した。「tr(W^n) <= 2^M c(M)^n」と「モーメント列の正値性と
対数凸性」を独立した主張へ切り出し、残った本体（下からの評価）は二つをブロック参照で引く形にした。
証明中で Step 番号によって相互参照していた箇所が、ブロック参照へ置き換わった。

切り出した対数凸性の主張が W の性質を参照していなかったため、依存グラフ上でイジング章の先頭へ
来ていた。対称化転送行列の定義と実対称正定値性への参照を主張へ入れ、依存順を正した。

先頭二項を節として確定した。節は34個、配置済みは307件中81件（分割で全体が305件から307件になった）。
次の一単位は挟み込み本体の一項だけとする。

## 2026-09-05: トレースの挟み込み本体を節に確定

分割後に残った本体（下からの評価）の一項を確定した。後置きの散文で置かれていた対角成分の評価の
根拠を適用行の末尾へ移し、ブロックの無い実数ベクトルの Cauchy--Schwarz を引いていた行を、
半正定値版を P=I と二つのベクトルへ適用する形へ書き換えた。これで全ての不等号がブロックのある
根拠を引く。節は35個、配置済みは307件中82件。次の一単位は分配関数の挟み撃ちの一項だけとする。

## 2026-09-05: 分配関数の挟み撃ちを節に確定し、上界の記述の不整合を直した

章内依存順77の分配関数の挟み撃ちを確定した。一文にまとめていた二段の適用を、下からの評価と
上からの評価の二つの鎖へ開いた。

あわせて、上限の定義で有界性の根拠を作用素ノルム ||W|| から成分の絶対値の有限和へ書き換えた影響で、
後続のセクター分解の主張が古い上界を引いたままになっていたので、現行の評価へ合わせた。同じ日の
自分の変更が後続の記述と食い違った例なので、上限の定義を触るときは参照元も確認する。

節は36個、配置済みは307件中83件。次の一単位は上限のセクター分解の一項だけとする。

## 2026-09-05: 上限のセクター分解を四つの境界候補として棚卸し

章内依存順156の上限のセクター分解は、定義一つ（セクター上限とその整合性）と主張三つ（ε との
可換性、セクター射影子による表示、最大値としての分解）を一ブロックに束ねていた。四分割と形式化の
同期が要るので、Runbook に従い本文は変更せず境界候補として記録した。次回は先頭二項だけを扱う。

## 2026-09-05: セクター上限の定義と可換性を切り出して節に確定

上限のセクター分解の四分割のうち先頭二項を実施した。セクターごとの上限の定義（値の集合が空でなく
上に有界であることの確認を含む）と、対称化転送行列が全スピン反転行列と可換で二つの固有空間を保つ
ことを、独立した項目へ分けた。証明中で「(1) より」と番号で指していた箇所がブロック参照になった。

分割した二項は、依存関係だけなら章のかなり手前へ移動できてしまい、以後の項目の依存順が一つずつ
ずれた。読む順序を変えないため、提示順の先行項目を宣言して本文の並びを分割前の位置に保った。
以後、後半の項目を分割するときも同じ手当てが要る。

節は37個、配置済みは309件中85件。次の一単位は、残るセクター射影子による表示と最大値としての分解の
二項を分けることとする。

## 2026-09-05: 数学的道具立ての冒頭二項を節に確定（定期起動と衝突しない側で進めた）

定期起動が16:07に再開し、状態台帳の「次の一歩」であるセクター分解の残り二項へ向かったので、
このセッションは同じファイルを触らない数学的道具立て側へ移った。章内依存順1「集合と代数構造の
記号」と順2「複素数の定義」を最初の節として確定した。

この二項の説明粒度の状態表示が「展開または分割を要する」のままなのは、後続への案内参照を
持つためで、案内は判定済みだから節の確定を妨げない。節の記録にその判断を書いた。実数の台集合を
既知として置く箇所なので、脱出理由も記録した。

節は38個、配置済みは309件中87件。以後、定期起動と並行して作業するときは、台帳の「次の一歩」は
定期起動に渡し、こちらは別の章・別のファイルの単位を取る。

## 2026-09-05: 行列の積の定義を、引用の意味と一致させた

数学的道具立ての章内依存順3のラベル `mat_mult` は、本文の20箇所以上から「行列の積の定義」として
引かれていたのに、実体は Typst の行列構成子 `mat(...)` を使った「行列の分解」で、その記号は本文の
どこにも定義がなく、証明も無かった。引用の意味に合わせて、成分による積の定義そのものをこの
ラベルの内容にした。原文が述べていた列ごとの作用は、列に並べた行列という記法を主張の中で定義した
うえで次のブロックへ移し、成分計算の四段で証明を付けた。

積の定義が複素数の定義を引くのは、本文の並びでは後ろだが依存順では先行する前提なので、後続案内
ではなく前方の前提として登録した。節は39個、配置済みは309件中89件。

## 2026-09-05: 共役写像の主張から抽象語を外して節に確定

数学的道具立ての章内依存順5は「T_B は線型写像である」と述べており、抽象語彙の自動検査に
「抽象線型写像」として引っかかっていた。この論文は高抽象度の道具を持ち込まない方針なので、主張を
「和とスカラー倍を保つ」という二つの等式へ書き換えた。証明はもともと二つを別々に示していたので、
各行の根拠はそのまま使える。節は40個、配置済みは309件中90件。

## 2026-09-05: 複素数に付随する四つの定義を一節に確定

数学的道具立ての章内依存順6から9（実数からの包含、-1 倍、二乗して -1 になる複素数、実部と虚部）は
互いに独立で、複素数の定義と記号の規約だけを引く。四項を一節にまとめ、順10の単位円から幾何の枝が
始まることを節を閉じる根拠にした。本文は変更していない。節は41個、配置済みは309件中94件。

## 2026-09-05: 単位円・円弧と、角度表現の四項を節に確定

数学的道具立ての章内依存順10–11（単位円と円弧）と、順12–15（角度の同値関係、代表元を与える整数の
存在と一意性、切断、角度表現）を、それぞれ一節として確定した。

角度表現の定義が、同値関係と切断を記号だけで使っていて、どのブロックの記号か本文から追えなかった
ので、両方の定義への参照を入れた。依存グラフにも現れるようになった。定義の内容は変えていない。

節は43個、配置済みは309件中100件。

## 2026-09-05: 双曲線関数と平方根の二節を確定

数学的道具立ての章内依存順17–19（双曲線余弦・双曲線正弦の定義、積の公式、基本性質）と、
順20–22（非負実数の平方根の存在と一意性、記号、負数への拡張）を、それぞれ一節として確定した。
平方根の存在は実数の連続性に依存するので、脱出理由として記録した。本文は変更していない。
節は45個、配置済みは309件中106件。

## 2026-09-05: 極座標の同値類の依存を補って一項節へ配置

道具章の極座標表現の同値類を読むと、式で角度の同値関係を使う一方、その定義への参照がなく、
既存の角度節の境界記述も相互非依存と誤判定していた。参照と零半径・正半径の場合の説明を補い、
角度の同値関係だけを再利用して半径を加える独立した定義として一項節へ配置した。
角度節の最終出力と、後続が再利用する先行定義とを区別して境界根拠を修正した。

LLMによる検証は、現行の二つの同値関係、角度表現の切断・演算、直後の双曲線関数定義を読み、
極座標定義が切断・演算を使わず、双曲線関数も極座標定義を使わないことを判断するものとした。
プログラミングによる検証では対象・全外部入力・直後の定義の本文 fingerprint、完全な直接依存、
章内の順序、単一の節末出力を固定する。集合記号の説明粒度の未解決は別に明記した。
道具章の全件配置は継続中であり、イジング章と状態台帳の次の一歩は変更していない。

独立したCodexのLLMによる検証で、同値関係の三性質と商集合の説明不足、平面との対応を先取りする表現を指摘された。対象と角度の入力を本文粒度未解決に改め、出力を半径・角度の対の商集合へ限定した。節配置と本文完成は区別している。

独立Codexの最終再レビューで節配置上の未解消指摘なしを確認した。プログラミングによる検証は
棚卸し再生成、npm run check、SageMathラベル対応118件、Lean全2994ジョブのビルド、主要定理の
sorry非依存検査が成功した。配置は道具章37/109件、全体107/309件・46節である。

## 2026-09-05: 単位円への正規化を二項節へ配置

非零実数対の正規化の存在一意性と、それで定める単位円への写像を一つの節に配置した。
LLMによる検証では、正の平方根による半径と成分の除算から一意の単位円上の対を得る主張、
その対で写像を定める定義、および両項を使わず円弧長を追加入力とする直後の逆正弦を読んで
境界を判断した。正規化の適用行ごとの参照不足と複数の四則演算の圧縮は、本文粒度未解決として
明記した。円弧長は直後の定義の入力であり、この二項節の入力には算入していない。
プログラミングによる検証では二項の連続性・内部依存・節末出力、対象と全外部入力の本文、
対象と直後の全直接依存、直後の本文・相対順を固定した。本文そのものは変更していない。

独立CodexのLLMによる検証で円弧長本文の固定漏れを検出し、節の外部入力とは別の境界比較条件に
追加した。最終再レビューでは未解消指摘なし。プログラミングによる検証は棚卸し再生成、
npm run check、SageMathラベル対応118件、Leanビルドとsorry非依存検査が成功した。
道具章39/109件、全体109/309件・47節となった。前の極座標節の公開版a60b256bdは公開検査PASS。

## 2026-09-05: 逆正弦から逆正接の公式までの七項を節へ配置

円弧長による逆正弦と全単射性から正弦・余弦を定める枝、および引数の範囲から逆正接を定める枝を、
逆正接の正弦・余弦公式で合流させる七項節を配置した。LLMによる検証は各関数の制限定義域と
二枝の合流を本文で判断した。独立Codexが検出した末尾公式の引数範囲への欠落参照と、後続の
極座標演算の同値類への欠落参照を補った。直後の極座標演算は三角関数を使わず別の入力へ切り替わる。

逆正弦の性質と円弧長の外部命題の本文内説明、末尾公式の二主張への分割と適用行の根拠は未解決である。
円弧長の粒度判定は既存の単位円節にも同期し、本文完成とは扱わない。プログラミングによる検証では
対象と比較側の全直接入力を含めた本文・全直接依存・種別・粒度の固定値、内部依存、連続性、唯一の
節末出力、直後の相対順を検査する。前の正規化の公開版f8ae70f58は公開検査PASS。

独立Codexの最終レビューでは説明文の入力区分だけが残り、極座標同値類を節自身の外部入力ではなく
後続比較だけの入力と明記して解消した。プログラミングによる検証は棚卸し再生成、npm run check、
SageMathラベル対応118件、Leanビルドとsorry非依存検査が成功した。道具章46/109件、全体116/309件・48節。

## 2026-09-05: 極座標同値類の積と逆元の二項節

演算定義から代表元独立性・結合律・単位元・非零部分の閉性と逆元へ進む二項を節へ配置した。
LLMによる検証では全証明を読み、直後の複素数の乗法群がこの二項を使わず、実数対の複素積と
実数包含へ入力を切り替えることを判断した。本文は変更していない。
演算定義の妥当性が後続で初めて示される提示、モノイド性・非零部分の群・逆元公式の混在、
一般集合Sでの逆元一意性、各適用行のラベル不足を個別に未解決として記録した。
プログラミングによる検証では対象と後続比較の全直接入力について、本文・直接依存・種別・粒度を
固定し、二項の連続性・内部依存・節末出力と直後の相対順を固定する。
前の逆正弦の公開版da936017cは公開検査PASS。

独立CodexのLLMによる検証で未解消指摘なし。プログラミングによる検証は棚卸し再生成、
npm run check、SageMathラベル対応118件、Leanビルドとsorry非依存検査が成功した。
道具章48/109件、全体118/309件・49節となった。

## 2026-09-05: 複素数の逆元と四則演算の性質の二項節

乗法群と体の性質を二項節へ配置した。LLMによる検証では二項の本文と全入力を読み、
後続の極座標への写像が平方根・逆正接・極座標同値類へ入力を切り替える境界を判断した。
体の証明冒頭を現行の加法・積の定義に合わせ、後続写像の題の向きと欠落参照を修正した。
複数の演算則の同時適用、一般集合での逆元一意性、各行の参照不足は本文未解決として残す。
独立CodexのLLMによる検証で節配置の未解消指摘なし。プログラミングによる検証では対象と
比較入力の本文・全直接依存・種別・粒度、内部依存、連続性と節末を固定した。
棚卸し再生成、npm run check、SageMathラベル対応118件、Leanビルドとsorry非依存検査、
PDF生成が成功した。道具章50/109件、全体120/309件・50節。前の公開版7c585c084は公開検査PASS。

## 2026-09-05: 複素数と極座標同値類の対応の三項節

二方向の写像から積保存・全単射の主張へ進む三項を配置した。LLMによる検証では本文と全入力を
読み、後続の座標射影が両写像を使わず同値類へ入力を切り替えることを確認した。
直交座標への写像の題と参照を補い、主値区間だけの三角関数では任意角度で写像を定義できない
不足を本文にも明記した。もう一項の本文変更は後続射影への同値類の参照追加である。
全実数への拡張、周期性、加法定理、π移動公式、代表元独立性、単射性は定義・証明の未完であり、
説明粒度だけの不足とは扱わない。極座標側に加法がないので体同型の原稿TODOも現状の目標にはしない。
定義・補題の追加と主張分割後の内部依存・閉包の再判定を条件として、独立CodexのLLMによる検証で
節配置の未解消指摘なし。プログラミングによる検証は棚卸し再生成、npm run check、ラベル対応118件、
Leanビルド・sorry非依存、PDF生成が成功した。道具章53/109件、全体123/309件・51節。
前の複素数四則演算の公開版997420805は公開検査PASS。

## 2026-09-05: 射影から絶対値の性質までの三項節

射影、絶対値・偏角、絶対値の六性質の三項を配置した。LLMによる検証では全本文と比較入力を読み、
成分計算の絶対値の性質から、未完の同型性を新たに使う積の偏角へ入力が切り替わると判断した。
本文変更は絶対値・偏角の欠落三参照と、積の偏角の写像・切断・絶対値の性質・極座標積の参照補完。
定義と六性質の分割、平方比較等の同居、各行参照と演算の分解、加法の定義場所の古い説明が未解決。
第一射影の代表元独立性だけが末尾で初めて示され、第二射影の説明は未提示であることを区別した。
独立CodexのLLMによる検証で節配置の未解消指摘なし。プログラミングによる検証は全比較入力を含む
本文・依存・種別・粒度と境界固定、棚卸し再生成、npm run check、ラベル対応118件、Leanビルドと
sorry非依存検査、PDF生成が成功。道具章56/109件、全体126/309件・52節。
前の写像の公開版eca492cb9は公開検査PASS。

## 2026-09-05: 積の偏角の一項節

LLMによる検証で積と商の本文および全入力を読み、角度の和の切断から、両側の逆元を追加して
角度の差を切断する商へ入力が切り替わる一項節を確定した。商は積の偏角公式を直接使わない。
後のπ条件で積の公式を再利用する点は比較専用として固定した。独立Codexの指摘により、商と
π条件の欠落参照を補い、π条件の本文・全直接依存・種別・粒度と相対順も固定した。
同型性の未完と逆写像の積保存の具体化などは本文未解決のまま残す。
独立CodexのLLMによる検証で節配置の未解消指摘なし。プログラミングによる検証では
棚卸し再生成、npm run check、ラベル対応118件、Leanビルドとsorry非依存検査、PDF生成が成功。
道具章57/109件、全体127/309件・53節。前の絶対値の公開版b6f198c28は公開検査PASS。

## 2026-09-05: 商の偏角の一項節

LLMによる検証で商とπ条件の本文および全入力を読み、逆元を使う角度差の切断から、
逆元を使わず積の公式へ戻るπ条件へ入力が切り替わる一項節を確定した。本文変更なし。
両項の証明へ未完の同型性が影響することを記録し、π条件の粒度を前節の比較固定にも同期した。
独立CodexのLLMによる検証で未解消の節配置指摘なし。プログラミングによる検証では全比較入力を含む
本文・全直接依存・種別・粒度・相対順の固定、棚卸し再生成、npm run check、ラベル対応118件、
Leanビルドとsorry非依存検査が成功した。道具章58/109件、全体128/309件・54節。
前の積の公開版8526a5348は公開検査PASS。

## 2026-09-05: 積の偏角がπになる条件の一項節

LLMによる検証でπ条件と自乗の全本文を読み、積公式への代入から、同型性と極座標積を使う
直接計算へ入力が切り替わる一項節を確定した。自乗の写像・極座標積・切断の参照を補った。
自乗の零の場合を維持し、対象と比較側に及ぶ未完入力の影響を区別した。
独立CodexのLLMによる検証で節配置の未解消指摘なし。プログラミングによる検証では
対象と比較入力の全固定条件、棚卸し再生成、npm run check、ラベル対応118件、Leanビルドと
sorry非依存検査、PDF生成が成功した。道具章59/109件、全体129/309件・55節。
前の商の公開版8c3881aa2は公開検査PASS。

## 2026-09-05: 自乗の偏角の一項節

LLMによる検証で自乗と逆数の全本文を読み、二倍の角度の切断から、両側の逆元を追加する
負の角度の切断へ入力が切り替わる一項節を確定した。逆数の写像・切断・非零性への参照を補った。
自乗の零の場合と逆数に必要な非零仮定を区別し、両項の未完入力と本文課題を維持した。
独立CodexのLLMによる検証で節配置の未解消指摘なし。プログラミングによる検証では
対象と比較入力の全固定条件、棚卸し再生成、npm run check、ラベル対応118件、Leanビルドと
sorry非依存検査、PDF生成が成功した。道具章60/109件、全体130/309件・56節。
前のπ条件の公開版24cfee54eは公開検査PASS。

## 2026-09-05: 逆数の偏角の一項節

LLMによる検証で逆数と平方根定義および全入力を読み、逆元から負の角度を切断する計算と、
半径の平方根・半角・逆方向写像への入力切替を境界とした。平方根定義の六参照を補った。
半角の値域[0,π)は現在の三角関数の定義域を超え、逆方向写像も未完のため、平方根写像の定義自体が
未完であることを本文に明記した。逆数の非零仮定と未完入力への依存は維持している。
独立CodexのLLMによる検証で節配置の未解消指摘なし。プログラミングによる検証では
対象と比較入力の全固定条件、棚卸し再生成、npm run check、ラベル対応118件、Leanビルドと
sorry非依存検査、PDF生成が成功した。道具章61/109件、全体131/309件・57節。
前の自乗の公開版7005e867bは公開検査PASS。

## 2026-09-05: 複素平方根の定義と極座標展開の二項節

LLMによる検証で定義・展開・交換条件の全本文と全入力を読み、一本の平方根の展開から
同型性・極座標積・三角公式を追加する積の比較へ入力が切り替わる二項節を確定した。
本文変更は展開の射影参照と交換条件の欠落五参照。平方根と逆方向写像の定義未完の影響、
代表元独立性と零・正の計算の分割、比較側の記号の未導入と導入前使用、平方根積法則、
未整備三角公式と同様計算の省略を未解決として残す。
独立CodexのLLMによる検証で節配置の未解消指摘なし。プログラミングによる検証では
対象と比較入力の全固定条件、棚卸し再生成、npm run check、ラベル対応118件、Leanビルドと
sorry非依存検査、PDF生成が成功した。道具章63/109件、全体133/309件・58節。
前の逆数の公開版b63f29fa2は公開検査PASS。

## 2026-09-05: 平方根の積と自乗の平方根の符号の三項節

LLMによる検証で交換条件と二乗復元が符号式へ合流する三項節を確定した。
後続の逆数平方根で追加する逆元・逆数の偏角・零での関数値も比較専用入力として固定した。
本文変更は二乗復元の三参照と逆数平方根の欠落参照。未完の定義と証明への依存、
記号導入・非零性・平方根1の計算・各行参照等の課題を明記し、補完後の配置再判定を条件とした。
独立CodexのLLMによる検証で節配置の未解消指摘なし。プログラミングによる検証では
対象と比較入力の固定条件、棚卸し再生成、npm run check、ラベル対応118件、Leanビルドと
sorry非依存検査、PDF生成が成功した。道具章66/109件、全体136/309件・59節。
前の平方根展開の公開版c752f4c37は公開検査PASS。

## 2026-09-05: 逆数の平方根と平方根の逆元の二項節

LLMによる検証で前項の公式と非零性を後項が使う二項の鎖、およびEuler表示での指数関数への
入力切替を確定した。本文変更は平方根の逆元の偏角参照とEuler表示の三参照・定義未完の明記。
平方根側の未完入力の影響と計算分割、比較側の複素指数の意味付け・全実数上の三角関数・
Euler公式自体の導出と偶奇性を未解決とし、補完後の依存と配置の再判定を条件とした。
独立CodexのLLMによる検証で節配置の未解消指摘なし。プログラミングによる検証では
固定条件、棚卸し再生成、npm run check、ラベル対応118件、Leanビルドとsorry非依存検査、
PDF生成が成功した。道具章68/109件、全体138/309件・60節。前の公開版498e4f233は公開検査PASS。

## 2026-09-05: 正弦と余弦の指数関数による表示の一項節

LLMによる検証でEuler表示と行列共役の三性質、および全直接入力を読み、関数の表示から
正則行列の共役への入力切替を境界とした。複素指数・全実数上の三角関数・Euler公式等の
定義と証明は未完として維持し、追加後の配置再判定を条件とした。本文変更なし。
比較側には三性質と積の逆元公式の分割、加法保存との接続、各行参照の課題を記録した。
独立CodexのLLMによる検証で未解消指摘なし。プログラミングによる検証では固定条件、棚卸し
再生成、npm run check、ラベル対応118件、Leanビルドとsorry非依存検査が成功した。
道具章69/109件、全体139/309件・61節。前の公開版3cb7fce0cは公開検査PASS。

## 2026-09-05: 行列共役の積・単位元保存と合成の一項節

LLMによる検証で共役の三性質と交換子の全本文・全直接入力を読み、正則性と共役写像を使う
保存則から、それらを使わない恒等式への入力切替を確定した。本文変更なし。
三性質と逆元公式の分割、加法保存との接続、各行の演算法則の根拠を未解決とし、比較側の
二定義と恒等式の分割・零の挿入等の課題も記録した。独立CodexのLLMによる検証で指摘なし。
プログラミングによる検証では固定条件、棚卸し再生成、npm run check、ラベル対応118件、
Leanビルドとsorry非依存検査が成功した。道具章70/109件、全体140/309件・62節。
前の公開版499ac416aは公開検査PASS。

## 2026-09-05: 交換子を反交換子で表す行列恒等式の一項節

LLMによる検証で交換子の展開から二つの反交換子へ閉じる一項と、実関数へ切り替わる境界を
確定した。比較側の双曲線関数へ非負平方根の参照を補った。五群の主張と逆関数の定義の分割、
指数対数と微分規則、各行参照を未解決とし、イジング導入注記に混在する積分の性質は一般形の
切り出し後に分類・依存・配置を再判定する。注記全体を道具章の入力へ加えていない。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、ラベル対応118件、Leanビルドとsorry非依存検査、PDF生成が成功した。
道具章71/109件、全体141/309件・63節。前の公開版067de77a8は公開検査PASS。

## 2026-09-05: 双曲線関数の加法公式と逆双曲線正弦の一項節

LLMによる検証で双曲線関数の五群から正弦・余弦の微分を使う評価への入力切替を確定した。
比較側の正弦評価へ二参照を補い、主張の半角範囲と証明の全非負引数での定義域超過を区別した。
両項の解析事実の一般形への切り出し、微分・零での値・数値範囲の根拠と主張分割を未解決とする。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、ラベル対応118件、Leanビルドとsorry非依存検査、PDF生成が成功した。
並行lambda台帳の更新を取り込んだ後、棚卸しとnpm run checkを再実行して成功した。
道具章72/109件、全体142/309件・64節。前の公開版0d8c1502bは公開検査PASS。

## 2026-09-05: 正弦の近似と積分の対数評価の三項節

LLMによる検証で正弦の近似と積分計算の二枝が両側評価へ合流し、次のトレースで有限和へ
切り替わる境界を確定した。本文変更は対数積分と両側評価の欠落参照、および有界差を定数差と
述べた表現の訂正の二項。零の場合を保ち、数値根拠・積分の定義可能性・主張分割・平方根の
積商法則・微分規則と一般形の解析前提の不足を未解決として補完後の再判定を条件とした。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、ラベル対応118件、Leanビルドとsorry非依存検査、PDF生成が成功した。
道具章75/109件、全体145/309件・65節。前の公開版a6ca7f8b0は公開検査PASS。

## 2026-09-05: トレースの定義と冪等行列の像の次元の三項節

LLMによる検証で定義・基本性質から冪等行列の像の次元へ閉じる三項と、複素共役へ切り替わる
境界を確定した。基本性質と冪等行列へ参照を補い、既存の比較用入力hash三箇所も同期した。
四主張の分割、有限和の帰納法と同時適用、像・核の部分空間性、零次元を含む基底の存在と
個数・結合、可逆な基底変換と表現行列の前提不足を具体計算へ接続する課題として記録した。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、ラベル対応118件、Leanビルドとsorry非依存検査、PDF生成が成功した。
道具章78/109件、全体148/309件・66節。前の公開版862da78f8は公開検査PASS。

## 2026-09-05: 複素共役から共役転置と正定値行列への二項節

LLMによる検証で複素共役から行列の定義群へ閉じ、反復交換子で入力が切り替わる境界を確定した。
本文変更は共役転置の行列積・実数包含と反復交換子の行列積の参照。既存の比較用hashも同期した。
長方形への共役転置の拡張、通常転置の記号導入、正の実数と実対称の包含の説明、比較側の
正整数冪の定義・演算法則・複数法則同時適用・主張分割を未解決へ記録した。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、ラベル対応118件、Leanビルドとsorry非依存検査、PDF生成が成功した。
並行lambda更新を取り込んだ後、棚卸しとnpm run checkを再実行して成功した。
道具章80/109件、全体150/309件・67節。前の公開版5c3032496は公開検査PASS。

## 2026-09-05: 反復交換子の二項係数による展開の一項節

LLMによる検証で有限和の帰納法から実数列の収束・剰余への入力切替を確定した。本文変更なし。
対象の正整数冪・演算法則と主張分割、比較側の部分和・極限・剰余の定義群、Archimedesの原理、
等比和と上限・極限法則の前提不足を未解決として記録し、零引数も保持した。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、ラベル対応118件、Leanビルドとsorry非依存検査が成功した。
道具章81/109件、全体151/309件・68節。前の公開版5d1c1d627は公開検査PASS。

## 2026-09-05: 非負実数の指数級数の収束と剰余の一項節

LLMによる検証で実数列の収束と剰余から等間隔平均への入力切替を確定した。零行列指数へ
指数定義の参照を補い、定義後へ移る順序と比較専用入力を固定した。平均収束の本文から
イジング固有の導線を外し、一様連続性と線型性を含む一般的な外部解析前提を明示した。
上限と極限法則、連続度の有限性、定義・主張分割と各行参照の不足を未解決として記録した。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、ラベル対応118件、Leanビルドとsorry非依存検査、PDF生成が成功した。
並行CA更新を取り込んだ後、棚卸しとnpm run checkを再実行して成功した。
道具章82/109件、全体152/309件・69節。前の公開版e7e145a4bは公開検査PASS。

## 2026-09-05: 等間隔点の平均の積分への収束の一項節

LLMによる検証で連続度による誤差評価から収束へ閉じ、クロネッカー積の有限成分の定義へ
入力が切り替わる境界を確定した。本文変更なし。対象の外部解析前提・上限の有限性と
主張分割、比較側の添字集合の元数・全単射と二定義の分割、各行参照を未解決へ記録した。
M=1と末尾の空和を保持し、既存V1節の同じ外部入力の粒度固定も同期した。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、ラベル対応118件、Leanビルドとsorry非依存検査が成功した。
道具章83/109件、全体153/309件・70節。前の公開版828fc61eaは公開検査PASS。

## 2026-09-05: 成分で定めるクロネッカー積と積の規則の二項節

LLMによる検証で成分定義から各因子の積と作用へ閉じ、後続線型性は行列積を使わず成分と
複素数の演算法則へ戻る境界を確定した。本文変更は積の規則と線型性への欠落参照の二項。
既存の外部入力hashとV1の粒度固定も同期した。三主張と多重添字和の補題の分割、添字変更、
同時適用、各行参照、比較側の成分加法・スカラー倍の定義と数ベクトル計算の省略を未解決へ記録した。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、ラベル対応118件、Leanビルドとsorry非依存検査、PDF生成が成功した。
並行lambda更新を取り込んだ後、棚卸しとnpm run checkを再実行して成功した。
道具章85/109件、全体155/309件・71節。前の公開版22cbc8797は公開検査PASS。

## 2026-09-05: クロネッカー積の和とスカラー倍の展開の一項節

LLMによる検証で分配律による成分展開から、成分添字を入れ替える転置への入力切替を確定した。
本文変更なし。対象の成分ごとの和・スカラー倍の定義、行列と数ベクトル・特例の分割、
同時適用と同様計算、比較側の転置の定義と主張の分割・各行参照を未解決として記録した。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、ラベル対応118件、Leanビルドとsorry非依存検査が成功した。
道具章86/109件、全体156/309件・72節。前の公開版a521474d8は公開検査PASS。

## 2026-09-05: クロネッカー積の成分添字と転置の一項節

LLMによる検証で添字の入れ替えによる転置から、線型性と基底の前提を加える境界を確定した。
比較側の基底の生成について、包含の向きを逆に述べていた説明を訂正し既存hash三箇所も同期した。
対象の定義と主張の分割、比較側の生成族元数の下限の未証明の一般命題を具体計算へ接続する根拠、
主張分割、有限展開の帰納法と数ベクトル計算の省略、各行参照を未解決として記録した。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、ラベル対応118件、Leanビルドとsorry非依存検査、PDF生成が成功した。
道具章87/109件、全体157/309件・73節。前の公開版bfbe0b6beは公開検査PASS。

## 2026-09-05: クロネッカー積で作る行列と数ベクトルの基底の一項節

LLMによる検証で標準基底から任意の因子基底への展開が閉じ、後続の可換性では基底を使わず
複素行列の積と交換子へ入力が切り替わる境界を確定した。比較本文を複素行列へ具体化して
欠落参照を補完し、既存hash三箇所を同期した。生成族元数の下限の未証明前提、三主張の分割、
帰納法と数ベクトル計算の省略、比較側の演算定義と法則・同時適用を未解決として記録した。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、ラベル対応118件、Leanビルドとsorry非依存検査、PDF生成が成功した。
並行する実行手順の更新を取り込んだ後、棚卸しとnpm run checkも再実行して成功した。
道具章88/109件、全体158/309件・74節。前の公開版594eb7bc5は公開検査PASS。

## 2026-09-05: 単位行列のスカラー倍と可換性の一項節

LLMによる検証で交換子と行列積の計算が閉じ、絶対値・非負平方根・実数列を使うノルム定義へ
入力が切り替わる境界を確定した。比較本文には実数包含の参照を補った。演算法則と同時適用、
比較側の定義分割と実数列の前提を未解決に記録した。極限一意性は後続に証明が存在するため、
定義時点の接続が未提示であることと区別した。独立CodexのLLMによる検証で指摘解消済み。
プログラミングによる検証では固定条件、棚卸し再生成、npm run check、PDF生成、
ラベル対応118件、Leanビルドとsorry非依存検査が成功した。
道具章89/109件、全体159/309件・75節。前の公開版02fa1dfb0は公開検査PASS。

## 2026-09-05: 成分の平方和によるノルムと収束の定義の一項節

LLMによる検証でノルムの定義を閉じ、共役転置・行列積・トレースを加える内積定義への境界を確定した。
共役転置の和・積保存の誤参照を既存の内積の性質の証明冒頭へ訂正すると、共役転置はその後へ移る。
本文変更はその共役転置と、行列積の参照と案内を補った内積定義の二項。移動対象と全直接入力は
比較専用に固定した。未完前提・所属・主張分割と計算省略を記録し、収束の説明は差のノルムと正確に記した。
独立CodexのLLMによる検証で指摘解消済み。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、PDF生成、ラベル対応118件、Leanビルドとsorry非依存検査が成功した。
道具章90/109件、全体160/309件・76節。前の公開版c078a5621は公開検査PASS。

## 2026-09-05: 共役転置とトレースによる内積の定義の一項節

LLMによる検証で二変数関数の定義を閉じ、行列空間の表記だけを受け取って交換子と逆行列を使う
二写像への入力切替を確定した。比較本文の行列積への参照を補った一項だけ本文を変更した。
内積の性質やノルムとの一致は定義から区別し、比較側の定義群と逆行列一意性証明の分割、
成分演算の法則への接続と各行参照を未解決として記録した。独立CodexのLLMによる検証で指摘なし。
プログラミングによる検証では固定条件、棚卸し再生成、npm run check、PDF生成、
ラベル対応118件、Leanビルドとsorry非依存検査が成功した。
道具章91/109件、全体161/309件・77節。前の公開版95e098817は公開検査PASS。

## 2026-09-05: 交換子と共役による複素行列上の写像の一項節

LLMによる検証で二写像の定義と逆行列一意性から、絶対値・平方根・ノルムの有限和の評価へ
入力が切り替わる境界を確定した。本文変更なし。定義群と証明の分割、比較側の四主張と補題、
実数列の前提と数ベクトルの計算省略を記録した。極限一意性と実数から複素数への包含の演算保存、
Cauchy–Schwarzの零の場合の証明が現存することを区別した。独立CodexのLLMによる検証で指摘解消済み。
プログラミングによる検証では固定条件、棚卸し再生成、npm run check、ラベル対応118件、
Leanビルドとsorry非依存検査が成功した。
道具章92/109件、全体162/309件・78節。前の公開版f2c363902は公開検査PASS。

## 2026-09-05: ノルムと内積の性質および共役転置の三項節

LLMによる検証でノルムの基本性質から内積の性質、その冒頭の複素共役の補題から共役転置への
依存鎖を確定した。末尾が使うのは内積の公理全体ではなく冒頭の補題である。後続劣乗法性は
内積・共役転置を使わず有限列の不等式と行列積へ戻る。本文変更は内積の性質と劣乗法性への
欠落参照の二項。既存比較snapshotのhashと全依存も同期した。主張分割、実数の包含と平方根の所属、
極限前提・計算省略・同時適用、実行列の積への接続を未解決へ記録した。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、PDF生成、ラベル対応118件、Leanビルドとsorry非依存検査が成功した。
道具章95/109件、全体165/309件・79節。前の公開版7b0050ffaは公開検査PASS。

## 2026-09-05: 行列積のノルム評価と右からの乗算の連続性の二項節

LLMによる検証で劣乗法性を行列列の差へ適用する二項の依存鎖を確定した。末尾は右因子を固定した
乗算の連続性に限る。後続の数ベクトル評価は末尾を使わず第一列へ置く行列を作る別枝である。
本文変更は連続性と数ベクトル評価への欠落参照・列の所属の二項。実行列の積への接続、有限和と
平方根の同時適用、実数列の極限法則、零の列の除去と各行参照を未解決に記録した。
独立CodexのLLMによる検証で指摘なし。プログラミングによる検証では固定条件、棚卸し再生成、
npm run check、PDF生成、ラベル対応118件、Leanビルドとsorry非依存検査が成功した。
道具章97/109件、全体167/309件・80節。前の公開版782fc6ebfは公開検査PASS。

## 2026-09-05: 行列ノルムによる数ベクトルの評価の一項節

LLMによる検証で第一列へ置く行列とノルムの一致から作用の評価を得る一項を確定した。
後続は行列作用の評価を使わず、成分のCauchy列と実数の完備性へ入力が切り替わる。本文変更なし。
n=1の空の列範囲と既存の成分による収束証明を保ち、実数の前提、有限和・添字の場合分けと
主張分割を未解決に記録した。独立CodexのLLMによる検証で指摘なし。
プログラミングによる検証では固定条件、棚卸し再生成、npm run check、ラベル対応118件、
Leanビルドとsorry非依存検査が成功した。並行する記録更新を取り込んだ後も棚卸しとcheckが成功した。
道具章98/109件、全体168/309件・81節。前の公開版9afeee2dfは公開検査PASS。

## 2026-09-05: 行列級数の絶対収束と指数級数の収束の二項節

LLMによる検証で、行列の完備性・絶対収束判定から指数級数の収束と上界への二項を確定した。
後続は数ベクトル作用と行列単位を使う線型写像の反復級数へ入力が切り替わる。
指数級数と各点収束の二項だけに行列積・実数包含・平方根の適用参照を補った。
行列冪の再帰は後続定義に存在するが提示順が未整備であり、実数の完備性・極限法則、
定義群と複数主張の分割、有限和の帰納と各行参照を未解決に記録した。
独立CodexのLLMによる検証で、零次と正次数の分離は本文に明示済みと訂正し、
N=0の空和への適用説明と区別した後、配置上の未解消指摘なしとなった。
プログラミングによる検証では固定条件、棚卸し再生成、check、PDF生成、ラベル対応118件、
Leanビルドとsorry非依存検査が成功した。道具章100/109件、全体170/309件・82節。
前の公開版032ad0ac2は公開検査PASS。

## 全研究の初回監督（2026-09-05T21:10:47+09:00）

共通契約の四項目で方向を評価した。
LLMによる検証: 行列ノルムによる数ベクトル評価を一節へ配置した成果と現行の道具章を読むと、イジング固有語彙を使わない入力から評価の出力を追えるように整理している。これはREADMEの具体的計算を依存順に読めるというゴールへの寄与である。論文再編全体や厳密解の完成を意味しない。
次の対象候補: 状態台帳が指定するセクター射影子による対称化転送行列の表示と、二つのセクター上限の最大値への分解を、前提と出力が区別できる形で再編する。
研究再開の判断は不要。

## 2026-09-05: 指数級数の数ベクトル作用と線型写像の各点収束の一項節

LLMによる検証で行列単位の評価から反復級数の各点収束・極限の線型性へ閉じる一項を確定した。
後続は存在・一意性を受け取る指数定義である。旧直後の正定値性へ実際に使う指数定義・
積公式・零行列指数等の参照を補い、それらの後へ移した。本文変更は正定値性と指数定義の二項。
移動項と全直接入力を比較専用で固定し、本節の入力へ混ぜていない。冪の再帰の提示順、
矩形共役転置、両側逆元・非零性、正の実数包含、定義と複数主張の分割を未解決に記録した。
独立CodexのLLMによる検証で配置上の未解消指摘なし。プログラミングによる検証では
棚卸し・固定条件・check・PDF・ラベル対応118件・Leanビルド・sorry非依存検査が成功。
道具章101/109件、全体171/309件・83節。前の公開版7520664b9は公開検査PASS。

## 2026-09-05: 行列と行列への線型写像の指数の定義の一項節

LLMによる検証で収束・一意性から二種類の指数を定める一項を確定した。後続は行列の場合を
使う対角成分の計算であり、比較本文一項へ成分演算等の参照を補った。非負実数の級数定理は
任意の複素成分へ適用できず、複素指数の定義と収束への接続を未完と記録した。
零の部分和成分と差の絶対値の極限も区別し、既存利用側の入力hash・粒度固定を同期した。
独立CodexのLLMによる検証で未解消指摘なし。プログラミングによる検証では棚卸し・
固定条件・check・PDF・ラベル対応118件・Leanビルド・sorry非依存検査が成功した。
道具章102/109件、全体172/309件・84節。前の公開版f54cad7dcは公開検査PASS。

## 2026-09-05: 対角行列の指数の成分表示の一項節

LLMによる検証で対角の冪・部分和・成分極限の一項を配置し、後続可換指数積がその出力を
使わず二項展開と剰余評価へ移る境界を確定した。比較本文一項へ成分演算・平方根と
反復交換子の準備に実在する二項係数・Pascalの計算の参照を補い、実前提として分類した。
対角の複素指数の定義と収束への接続は未完のまま明示し、二因子の積の収束と右固定乗算は
区別した。独立CodexのLLMによる検証で配置上の未解消指摘なし。
プログラミングによる検証では棚卸し・固定条件・check・PDF・ラベル対応118件・
Leanビルド・sorry非依存検査が成功した。道具章103/109件、全体173/309件・85節。
前の公開版07e46ac1eは公開検査PASS。

## 2026-09-05: 指数の積公式とエルミート行列の指数の正定値性の三項節

LLMによる検証で積公式と零での値の二枝が末尾の正定値性へ合流する三項を確定した。
後続共役公式は正定値性を使わず反復交換子へ移る。零行列のサイズと複素所属、
実数級数等への参照と、共役公式の成分演算等の参照を二本文内で補い、既存固定条件も同期した。
正定値性の矩形共役転置・片側逆元・非零性・実数包含の不足と、共役公式に現存する
両側逆元・零次四場合・添字の逆写像・二因子の同時収束を区別して記録した。
独立CodexのLLMによる検証で配置上の未解消指摘なし。プログラミングによる検証では
棚卸し・固定条件・check・PDF・ラベル対応118件・Leanビルド・sorry非依存検査が成功した。
道具章106/109件、全体176/309件・86節。前の公開版9001defb0は公開検査PASS。

## 2026-09-05: セクター射影表示と上限最大値分解の四分割を継続

停止差分を引き継ぎ、射影後の転送行列の等式を最大値分解から切り出した。後続の偶セクター本文と上限比較の定義参照、SageMathの二つの残差の対象、Leanの未形式化・仮定付きの対応名を同期した。二主張と全外部入力・直接後続の本文fingerprint・直接依存・二章分類、相互非依存と提示順、対応資料を棚卸し生成時のプログラミングによる検証へ固定した。独立LLMによる検証が指摘した既存の正規化・直交分解・各行根拠の説明不足、射影表示の行単位SageMath未実施とLean未形式化を未解決として記録した。最終節境界は候補であり、四分割を論文証明の全面完成とは扱わない。

プログラミングによる検証ではラベル再生成・棚卸し再生成・npmの論文検査、118件のSageMathラベル対応、既存7例の数値検査、Lean buildとsorry非依存検査、PDF生成が成功した。数値検査は一般証明や行単位の証明対応を保証しない。

独立Codexの最終LLMによる検証で今回の四分割と対応同期に未解消指摘なし。再レビューで検出された数式内参照の依存辺二本も明示Map・期待集合・生成JSONへ復旧した。プログラミングによる検証はmain取込後も成功し、再レビュー担当も18項目の固定条件と資料6ファイルのhash一致を確認した。最終レビュー記録は /tmp/math-sector-split-final-review.md。

同時進行のセクター分割を取り込み、生成器の別項目の手動レビューと記録の追記を両方保持して
競合を解消した。統合後は道具章106/109件、全体178/310件・87節となる。
道具章の対象・比較の数学的内容と依存境界は独立レビュー時から変わっていない。

## 2026-09-05 全研究監督の今回評価

READMEは高校生が具体的な複素行列計算を積み上げて読めることを要求する。指数収束・正定値性・対角指数・可換指数積の本文に、行列積や成分演算、平方根、実数包含、二項係数の実前提が追加され、未説明入力と配置境界が区別された。単なる棚卸し件数の増加ではなく、入力を先に辿れる本文差分を前進と評価する。 追加取得したセクター分割では、射影表示の半指数置換と可換性の移動を別行へ分け、最大値分解とは独立した主張にした。四分割は反映済みだが、正規化・直交分解の説明と射影表示の行単位SageMath・Leanは未解決である。

runbookに最終目的と構成整理の残余を区別する節を追加。反映済みの四分割と未解決の説明・形式化を分け、対角の複素指数入力も未完のまま追跡する。一単位上限と所有担当の終了範囲は維持。
反映済みの四分割を繰り返さず、stateに残る最大値分解の正規化・直交分解の説明、射影表示の行単位対応と最終節境界を次の評価対象にする。道具章の複素スカラー指数の定義・収束の未完も区別して保持する。所有担当の継続作業の範囲を越える新規証明は採用しない。

内容はLLMによる検証。

今回監督の追加照合: さらに1b9dbebefは零指数の行列サイズと複素所属、実数級数の参照、指数共役の演算・ノルム前提を本文へ補った。正定値性の不足を節の確定と分離する点は同じである。

## 2026-09-06: 全行列と可換な行列のスカラー表示の節を確定

行列単位の係数比較で閉じる一項と、実対称半正定値行列の二次式へ切り替わる境界を確定した。
出力は本文どおり M>=1 の 2^M 次に限定した。対象と比較の二本文へ実入力の参照を補い、
本文fingerprint定数と全直接依存・比較専用入力の固定条件を同期した。
独立CodexのLLMによる検証で未解消の配置指摘なし。基底判定の前提、転置の適用範囲、
実行列の演算への接続等は本文未解決として保持する。
プログラミングによる検証は棚卸し・check・PDF・ラベル対応118件・Leanビルド・sorry非依存が成功し、
停止後の同一会話・同一worktreeの復旧とmain取込後にも棚卸しとcheckが成功した。
道具章107/109件、全体179/310件・88節。直前の公開版21d7f0009は公開検査PASS。
## 2026-09-06: 半正定値双線型形式の不等式の節を確定

実対称半正定値行列の二次式を正の係数と零の係数に分ける一項を、Cauchy–Schwarz の
不等式で閉じる節として確定した。直後の end 写像定義はクロネッカー積と有限基底へ入力が
切り替わる比較対象として固定した。対象の通常転置と実行列演算への接続、比較側の End(F) を
F 上の C-線型自己写像全体として定める説明と基底上の線型拡張の根拠は本文未解決として保持する。
独立CodexのLLMによる検証で配置・分類・依存・固定条件に未解消指摘なし。
プログラミングによる検証は棚卸し・checkが成功した。
道具章108/109件、全体180/310件・89節。直前の公開版b822621b2は公開検査PASS。

## 2026-09-06: 双曲線関数のテイラー展開の節を確定

双曲線正弦の奇数次級数表示と双曲線余弦の偶数次級数表示の一項を、直後の可逆行列定義へ
入力が切り替わる節として確定した。実数入力と双曲線関数定義への参照を本文へ補った。
添字集合・階乗・無限和の定義と証明、対象ラベル、下流三箇所からの直接依存は未整備であり、
補完後に依存と閉包を再判定する条件を棚卸しへ記録した。可逆行列定義側にも行列積・複素数の
体・集合記号への参照を補い、対象・比較と全直接入力の固定条件を同期した。
独立CodexのLLMによる検証で配置・分類・依存・109件の一意被覆に未解消指摘なし。
プログラミングによる検証は棚卸し・check・PDF・ラベル対応118件・Leanビルド・
sorry非依存検査が成功した。道具章109/109件、全体181/310件・90節。
直前の公開版1c68e17deは公開検査PASS。

## 2026-09-06: セクター射影表示と上限最大値分解を別の一項節へ確定

イジング章の既存棚卸し二項だけを扱った。`WP^{(\pm)}=V^{(\pm)}P^{(\pm)}` は平方根因子の
セクター制限と射影子の移動へ閉じ、`c(M)=\max(c_+(M),c_-(M))` はこの表示に依存せず、
Rayleigh 上限・射影子の直交分解・`W` のセクター不変性へ閉じる。入力集合と出力が独立なので、
提示順だけを依存辺へ混ぜず、それぞれを一項節として確定した。直後の臨界条件は
フェルミオンと `\gamma_2` の零点へ入力を切り替える。

最大値分解には、異なるセクターに属する任意の実ベクトルの直交性、ノルム平方の分解、交叉項の消去、
零・非零を分けた正規化を追記した。単位ベクトル上の上限を任意ベクトルへ適用していた欠落は
これで解消した。Lean の最大値分解は既存。射影表示の行単位SageMath検査とLean形式化は未完で、
節配置・本文粒度の確定とは区別して保持する。次回は射影表示一項の行単位SageMath対応だけを扱い、
複数の未形式化入力を要するLean接続と、上限最大値分解以後の独立境界へは進まない。

構造確定済みは全310項中181項、91節。

独立CodexのLLMによる検証では、初回の6件と再レビューの3件を本文・固定条件へ反映した後、
分類・依存・節境界・数学的正しさ・説明粒度・台帳同期に未解消指摘なしとなった。
## 全研究監督（2026-09-06 08:42 JST）

実行識別子 `b013b1ef-3353-4c55-9b5b-3ba050b3e1a3`。前回読解終点以後、可換行列のスカラー表示、半正定値不等式、双曲線関数のテイラー展開、セクター射影表示と最大値分解を一項節へ整理した。LLMによる検証では、最大値分解の正規化・直交分解・交叉項消去の欠落が本文で解消され、提示順と意味的依存を分けた点を最終目的への前進と評価した。段取り変更なし。次はセクター射影表示の行単位SageMath対応。
## 全研究監督（2026-09-06 09:03 JST）

実行識別子 `baf83161-2942-4174-9560-e403b2d537fe`。開始成果以後に統合済みの数学本文差分はない。

## 2026-09-06: セクター射影表示の行単位 SageMath 対応を完了

イジング章の既存項目「セクター射影後の転送行列の表示」一項だけを扱った。`BP=CP` と、
`WP=BV_2BP` から `CV_2CP=V^{(\pm)}P` までの八段を、既存の最終残差とは独立した
九つの SageMath ファイルへ対応させた。`M=2,3,4`、結合定数七組、両セクターについて
九等式の全126例を実行し、最大相対残差 `5.476×10^{-16}` は許容値 `10^{-9}` 以下だった。
プログラミングによる検証は有限個の浮動小数点計算であり、一般証明とは扱わない。

Lean 接続には、`RestrictsOnSector` の根拠となる `V_1` の固有空間への制限、章011の実行列
`W` と複素 `TensorPow` 上の転送行列の同一視、既存の `Vsym` と `epsProj` へつなぐ最終定理という
三つ以上の形式化単位が要る。本文や Lean を大規模に変更せず境界候補を記録し、次回は既存項目
「`V_1` の固有空間への制限」一項の本文と Lean 仮定の照合だけを行う。上限最大値分解、臨界条件、
数学的道具立ての分類・節境界には進まない。

独立CodexのLLMによる検証では、九等式の数学的正しさと一対一対応、数値残差、`RDF` / `CDF` による
`ℝ/ℂ` への脱出、Lean未形式化境界、棚卸しと固定ハッシュに未解消指摘なしだった。

## 2026-09-06: V1 の固有空間制限の形式化境界を三単位へ確定

イジング章の既存項目「`V_1` の固有空間への制限」一項だけを扱い、本文と Lean の
`RestrictsOnSector` を照合した。作用等式の出力と、偶セクター `(η,ηsign)=(1,-1)`、
奇セクター `(-1,1)` という複号対応は一致する。一方、本文が入力に持つ `M>=2` と `V_1` の
Jordan–Wigner 行列表示は Lean に無く、Lean は求める作用等式自体を仮定している。
`TensorPow` と `mulVec` は本文の数ベクトル空間と行列作用を具体化するため別単位を要しない。

仮定を解消する境界は、`V_1` の Jordan–Wigner 行列表示、そこから固有空間制限を導く定理、
下流の二仮定を除いて `M>=2` を渡す同期の三単位である。今回は本文・Leanを変更せず、生成検査へ
根拠ファイルのハッシュ、現状、三境界、次回の一単位を固定した。次回は既存項目
「`V_1` の Jordan–Wigner 行列表示」の Lean 行列等式だけを扱う。

## 全研究監督（2026-09-06 11:12 JST）

実行識別子 `1228498e-80ac-4400-8fb0-62d858946eca`。LLMによる検証で、セクター射影表示の九等式は126有限例・最大相対残差 `5.476×10^-16` で有限校正層まで進み、続く照合でLeanの `RestrictsOnSector` 解消がJordan–Wigner行列表示・固有空間制限定理・下流仮定除去の三単位を要すると確定した。段取り変更なし。次はJordan–Wigner行列表示一項のLean行列等式。研究再開の許可は出していない。

## 2026-09-06: V1 の Jordan–Wigner 行列表示を Lean で形式化

2次元イジングモデル章の既存項目「`V_1` の Jordan–Wigner 行列表示」一項だけを扱った。
本文ラベル `V1_in_Z_Y_epsilon` に対応して、`M>=2` の下で非境界項、周期境界項、全サイトの
有限和を順に証明し、`V1pauli_eq_jordanWigner` で行列指数関数の等式へ閉じた。具体的な
Pauli 表示と Jordan–Wigner 表示の一致なので必要十分版は置かず、一般的な内容は既存の
サイトごとの積と各因子の複素線型性に分離した。`V_2` の表示と後続の固有空間制限には進んでいない。

次回は、形式化済みの表示を入力に、`M>=2` と `ηsign=-η` の下で `V_1` の固有空間制限を
導く一項だけを扱う。下流の `RestrictsOnSector` 仮定除去はさらに次の独立単位として保持する。

独立CodexのLLMによる検証では、非境界の `-i`、周期境界の `+i`、境界項の負号、有限和から
指数関数への移行、`M=2` の境界処理、必要十分版を置かない判断に問題はなかった。初回レビューの
章別形式化文書と Step 1 対応の同期指摘を修正し、再レビューで未解消指摘なしとなった。
プログラミングによる検証は、ラベル・棚卸し再生成、構造化本文の全検査、366ページのPDF生成、
SageMath対応118件、Lean全2995ジョブ、主要定理のsorryAx非依存が成功した。
## 全研究監督（2026-09-06 14:58 JST）

実行識別子 `f20278ec-3b2b-47ff-a62a-1980a00cd51c`。LLMによる検証で、本文の `V_1` Jordan--Wigner行列表示が `M>=2` の具体Lean等式へ一対一に形式化されたことを前進と評価した。段取り変更なし。次は同じ表示から `ηsign=-η` の偶奇セクター制限を導く一項。

## 2026-09-06: V1 の固有空間制限を Lean 具体版で形式化

2次元イジングモデル章の既存項目「`V_1` の固有空間への制限」一項だけを扱った。
`V1pauli_eq_jordanWigner` を入力に、`W` と二つの生成子が全スピン反転行列の固有空間を保つこと、
固有値 `η` のベクトル上で `ηsign=-η` の生成子作用が一致すること、作用する冪の一致、有限部分和の
一致、指数級数の極限の一意性を本文 Step 3–6 と同じ順で形式化した。冪の一致は一般の射影定理へ
委ねず直接帰納した。偶セクターは `(η,ηsign)=(1,-1)`、奇セクターは `(-1,1)` である。

独立Codexの初回LLMレビューで、射影後の行列等式と一般の冪定理を使った初稿は人手本文との
一対一対応を満たさないと判明したため、ベクトル作用を直接追う具体補題列へ置き換えた。
有限部分和を実際の極限列へ接続する修正まで反復し、最終再レビューで未解消指摘なしとなった。
下流の `RestrictsOnSector` 仮定除去と `M>=2` の受け渡しは次の独立単位として保持し、`V_2`、
実行列 `W` との同一視、射影表示の最終接続、上限最大値分解、臨界条件には進んでいない。

## 2026-09-06: セクター置換から分配関数分解までの Lean 仮定を解消

2次元イジングモデル章の既存項目「セクター置換」と分配関数のセクター分解への接続だけを扱った。
`sector_replacement_of_V1`、`sector_replacement_pow`、トレース接続は `M>=2` と
`ηsign=-η` の導出を直接使う形に揃えた。最終の `partition_function_sector_decomposition` も
`M>=2` を受け取り、偶奇セクターの `hresPlus`・`hresMinus` を外部仮定に持たずに閉じる。

本文、分類、節境界は変更していない。次回は章011の実行列 `W` と複素 `TensorPow` 上の
物理的転送行列の同一視だけを扱い、射影表示の最終 Lean 定理はさらに別単位として保持する。

## 2026-09-06: 章011の実行列と複素物理転送行列を Lean で同一視

2次元イジングモデル章の既存項目「セクター射影後の転送行列の表示」に必要な章間接続のうち、
実行列と複素行列の同一視一単位だけを扱った。物理的な `V₁^{1/2}`、`V₂`、
`W=V₁^{1/2}V₂V₁^{1/2}` を実成分で定義し、既存の章010の成分表示定理を使って、Pauli 表示から作る
複素物理転送行列が実行列 `W` の成分ごとの複素化に一致することを
`physicalSymTransferC_eq_map` で証明した。同じ具体的行列の係数体だけを比較するため必要十分版は置かない。

本文、分類、節境界は変更していない。次回はこの同一視、形式化済みの `V₁` のセクター制限・置換、
既存の `Vsym`・`epsProj` を接続し、射影後の等式を閉じる最終定理一単位だけを扱う。

独立CodexのLLMによる検証では、`K₁/2`、`K₂`、`K₂^*`、`sinh(2K₂)` の対応、章010の
成分表示定理の適用、必要十分版を置かない判断、文書と棚卸しの同期に未解消指摘なしだった。
プログラミングによる検証では、構造化本文の全検査、366ページのPDF生成、SageMath対応118件、
Lean全2996ジョブ、追加三定理を含む主要定理の `sorryAx` 非依存が成功した。

## 2026-09-06: セクター射影後の転送行列表示を Lean で完結

2次元イジングモデル章の既存項目「セクター射影後の転送行列の表示」一項を完了した。
`physicalSymTransferR_map_mul_epsProj_eq_Vsym` は、実行列 `W` の複素化、`K₁/2` の
セクター置換、半指数因子と `V₂` の射影子可換性を接続し、一般の `M>=2` と `η²=1` で
`WP=V^{(±)}P` を示す。射影子移動に必要なのは `BP=CP`、二つの可換性、結合法則だけであり、
任意の半群上の `NecSuf.sandwich_mul_proj_eq` に分離して具体版をその特殊化として導いた。

独立CodexのLLMによる検証で、Lean書換えの不備、可換移動の向き、必要十分版、章011・018の
状態同期、固定ハッシュを順に修正し、最終再レビューは未解消指摘なしとなった。プログラミングによる
検証は、構造化本文全検査、366ページPDF、SageMath対応118件、Lean全2996ジョブ、主要定理の
`sorryAx` 非依存が成功した。本文の数学的主張、分類、節境界は変更していない。次回は既存項目
「`V_2` を `Z,Y` で表す」の Lean 対応だけを扱う。

## 2026-09-06: V2 の Jordan–Wigner 行列表示の既存 Lean 対応を確定

2次元イジングモデル章の既存項目「`V_2` を `Z,Y` で表す」一項だけを扱った。本文の
`V2_in_Z_Y` は、Pauli 表示の `V_2` と
`(2s_2)^{M/2}\exp(iK_2^*\sum_m Z_mY_m)` の等式である。既存の
`I_smul_H2_eq_sum_sigmaX` が `H_2=\sum_m Z_mY_m` から
`iH_2=\sum_m\sigma_m^x` を示し、`V2_eq_V2pauli` が同じ規格化因子を保って行列指数へ
適用しているため、左右の向きを除いて本文と同じ行列等式を既に閉じていた。Lean は任意の自然数
`M` で述べており、本文の `M>=1` を含む。追加の定理や必要十分版は不要と判断し、Lean の対応表と
形式化状況、状態台帳の矛盾だけを同期した。独立CodexのLLMによる検証で、本文ラベルと
Step 0–3 の対応、必要十分版を置かない理由、旧拡張子表記を順に修正し、最終再レビューは
未解消指摘なしとなった。プログラミングによる検証は、構造化本文全検査、366ページPDF、
SageMath対応118件と対象4検算、Lean全2996ジョブ、主要定理の `sorryAx` 非依存が成功した。
本文、分類、節境界は変更していない。

## 2026-09-07: 全スピン反転行列の二つの固有空間を四つの境界候補として棚卸し

2次元イジングモデル章の既存項目「全スピン反転行列 `ε` の二つの固有空間」一項だけを扱った。
現行本文は `F^{(+)}` と `F^{(-)}` の二定義、および各集合が複素部分線型空間であるという二主張を
一ブロックに束ね、具体的な行列作用と抽象線型写像 `end(ε)` を同じ定義で往復している。

Lean は `εx=ηx` をベクトル述語として利用するが、`F^{(+)}` と `F^{(-)}` を部分空間として定義して
いない。SageMath の既存検査は同じ本文ラベルに、別項目の `ε²=I` と固有値候補、および本文に無い
`dim F^{(±)}=2^{M-1}` まで束ねている。本文分割と形式化同期が三単位以上に及ぶため、今回は
本文・Lean・SageMathを変更せず、二定義と二つの部分空間性を四つの境界候補として固定した。
次回は先頭の `F^{(+)}` の定義一項だけを扱い、残る三候補と射影子以後には進まない。

独立CodexのLLMによる検証で、項目側の手動粒度レビューと将来分割フラグ、および形式化資料の
内容固定が欠けていることを検出した。四分割の判断を項目側へも反映し、根拠にした三つの Lean 資料と
SageMath 検査を SHA-256 で固定した。

## 2026-09-07: 全スピン反転行列の固有値が正の固有ベクトル集合を分離

2次元イジングモデル章の既存項目「全スピン反転行列 `ε` の二つの固有空間」から、
`F^{(+)}={f\in\mathbb{C}^{2^M}\mid\varepsilon f=f}` の定義一項だけを独立ブロックへ分離した。
本文は `ε` の具体的な行列作用だけで定義し、抽象線型写像への読み替えは持ち込んでいない。
同じ等式を集合として表す Lean 定義と、全成分 `1` の固定ベクトルを `M=1,\ldots,5` で調べる
SageMath の有限例校正を対応付けた。残る `F^{(-)}` の定義と二つの部分空間性には進んでいない。

独立Codexの初回LLMによる検証で、状態台帳と本ファイルの次の一歩が不整合であること、および
SageMath の説明が一つの固定ベクトルに対する校正範囲を越えていたことを検出した。今回の成果と
保証範囲を明記して解消した。プログラミングによる検証では、構造化本文の全検査、366ページの
PDF生成、対象SageMath検査と本文対応、Lean全2997ジョブ、主要定理の `sorryAx` 非依存が成功した。
次回は残る先頭候補である `F^{(-)}` の定義一項だけを扱い、二つの部分空間性と射影子以後には進まない。

## 2026-09-07: 全スピン反転行列の固有値が負の固有ベクトル集合を分離

2次元イジングモデル章の既存項目「全スピン反転行列 `ε` の二つの固有空間」から、
`F^{(-)}={f\in\mathbb{C}^{2^M}\mid\varepsilon f=-f}` の定義一項だけを独立ブロックへ分離した。
本文は `ε` の具体的な行列作用だけで定義し、抽象線型写像への読み替えは持ち込んでいない。
同じ等式を集合として表す Lean 定義と、最初と最後の標準基底ベクトルの差を `M=1,\ldots,5` で
調べる SageMath の有限例校正を対応付けた。二つの部分空間性は未分割の後続単位として残し、
`ε²=I`、固有値候補、次元公式、射影子以後には進んでいない。次回は先頭の残余候補である
`F^{(+)}` の複素部分線型空間性一項だけを扱う。

独立CodexのLLMによる検証では、本文・Lean・SageMathの定義条件、旧ブロックに残す二主張、
棚卸しの全312項と章内依存順、状態台帳の次回単位を照合し、最終再レビューで未解消指摘なしとなった。
プログラミングによる検証では、構造化本文の全検査、366ページのPDF生成、SageMath対応120件と
対象5校正、Lean全2998ジョブ、主要定義を含む確認対象の `sorryAx` 非依存が成功した。

## 2026-09-08: 全スピン反転行列の正固有空間の複素部分線型空間性を分離

2次元イジングモデル章の既存項目「全スピン反転行列 `ε` の二つの固有空間」から、
`F^{(+)}` の複素部分線型空間性一項だけを独立ブロックへ分離した。本文では零ベクトル、
二つの所属ベクトルの和、複素スカラー倍へ `ε` を作用させ、行列と数ベクトルの積を各成分の
有限和へ展開して三つの閉性を一段ずつ示した。

Lean の具体版では本文と同じ17段の成分計算を個別定理の中へ展開し、それらを台集合とする複素部分加群を
構成した。必要十分版は有限添字と可換半環行列だけを仮定して同じ17段を証明し、具体版がその特殊化で
あることも示した。SageMath では `M=2` の有限例の全4成分について、本文の17段を一ファイルずつ `QQ(i)` 上の
厳密等号として検査した。有限例の検査であり、一般の `M` に対する証明は Lean が担う。

`F^{(-)}` の複素部分線型空間性だけを旧ブロックの境界候補として残した。`ε²=I`、固有値候補、
次元公式、射影子の性質、後続節、数学的道具立ての分類・節境界には進んでいない。次回は
`F^{(-)}` の複素部分線型空間性一項だけを成分表示へ分離し、Lean・SageMath の対象ラベルを同期する。

独立CodexのLLMによる検証では、初回にSageMathが一成分だけへ固定されているのに校正範囲を限定して
いない不一致、再レビューで修正後18ファイルの固定SHA-256未更新を検出した。全4成分の反復検査と
固定値同期を行い、最終再レビューは未解消指摘なしとなった。

プログラミングによる検証では、312ラベルと313項の棚卸しを再生成し、構造化本文350ブロックの
全検査、367ページのPDF生成、SageMath対応121件と対象17検査の全4成分、Lean全2999ジョブ、
主要定理の `sorryAx` 非依存が成功した。

## 2026-09-09: 全スピン反転行列の二乗と固有値候補を分割

2次元イジングモデル章の既存項目「全スピン反転行列の二乗が単位行列であり、その作用の固有値が
`+1` または `-1` に限ること」を二つの独立主張へ分割した。`ε²=I` は Pauli 行列の二乗と
クロネッカー積の積だけで閉じ、固有値候補は分割した二項間では二乗公式だけを入力にする。通常の
行列作用と複素数の体の法則も直接入力として明記した。旧ラベルは下流参照を
保つため二乗公式側に残し、内容を表す個別ラベルを二項へ追加した。

二乗公式は Lean でサイト作用素の有限帰納法、クロネッカー積の因子別計算、各因子の二乗、単位因子の
積を本文と同順に証明し、不要な行列構造を除いた必要十分版も分離した。SageMath は帰納段三行と
二乗計算四行を一行一ファイルで `M=1,…,5` の有限行列について厳密に確認する。固有値候補は抽象的な
`end` 写像を経由せず、`εf=λf` という通常の行列作用へ統一した。

独立CodexのLLMによる検証で、Lean・SageMathの一対一対応、複素数の体への直接依存、抽象写像の混入、
旧混在検査の正式資料扱い、および固有値候補と相補射影が枝分かれする節境界を検出した。本文・形式化
資料・棚卸しを修正し、二乗・固有値候補と相補射影を前後から分ける節境界候補を保持した。次回は
固有値候補一項だけの Lean・SageMath 対応とこの節境界の確定を行い、次元公式、射影子の内容、
数学的道具立ての分類・節境界には進まない。

継続レビューでは、本文だけが `r=1` を帰納法の初項とし、Lean の具体版・必要十分版が空積 `m=0` を
初項としていた不一致を検出した。本文へ `P_0=I` を明示して `r=0,…,M` の有限帰納法に揃え、
SageMath の帰納段三本と接頭積検査も `M=1,…,5` の `r=0` から確認するよう同期した。SageMath 概要の
定理名、新規 Lean 二ファイルの形式化資料登録、変更資料の固定 SHA-256 も修正し、最終LLMレビューは
未解消指摘なしとなった。プログラミングによる検証では、315ラベルと315項の棚卸しを再生成し、
構造化本文352ブロックの全検査、368ページのPDF生成、SageMath対応123件と対象7検査、Lean全3002ジョブ、
新しい具体版・必要十分版を含む主要定理の `sorryAx` 非依存が成功した。

## 全研究監督（2026-09-09 08:56 JST）

実行識別子 `14463f52-84b8-4534-b5be-d8a596acfbad`。LLMによる検証では、全スピン反転行列の二乗公式を固有値候補から分離し、本文・七つの有限校正・Lean具体版・Lean必要十分版へ閉じた成果を前進と判断した。二乗公式の本質は乗法と単位を保つ写像および各因子の対合性で、固有値候補には複素数上の零積と非零固有ベクトルが別に必要である。段取り変更なし。次は固有値が正負一に限る一項だけ。

## 2026-09-10: サイトごとの Pauli 行列族を複合定義から分離

2次元イジングモデル章の複合定義から、サイトごとの三種類の Pauli 行列を
`(\sigma_k^a)_{1\leq k\leq M,\ a\in\{x,y,z\}}` という一つの添字つき行列族として分離した。
定義には `M\geq1`、サイト添字、行列種の添字と所属行列空間を明示した。残余複合定義は
新定義を明示参照するため、旧ラベルを使う後続項目の意味を保つ。

既存項目では `\sigma^z` の基底作用だけを新ラベルへの直接参照へ移した。`V_1,V_2`、単位行列、
Jordan–Wigner 行列、全スピン反転行列、双対結合定数、双曲線関数の略記には進んでいない。
棚卸しは全316項となり、現行章内依存順10–13を新定義、残余複合定義、`\sigma^z` の基底作用、
`V_1` の二表示の一致として固定した。次回は残余複合定義から「第一の転送行列 `V_1` と周期規約」
一単位だけを分離する。

## 2026-09-10: 第一の転送行列と周期規約を複合定義から分離

2次元イジングモデル章の残余複合定義から、第一の転送行列 `V_1` と周期規約だけを一つの定義へ
分離した。`M\geq2`、`K_1\in\mathbb{R}_{>0}`、`\sigma_{M+1}^z:=\sigma_1^z`、行列指数関数への
参照と所属行列空間を新定義へ集約した。残余複合定義は新定義を明示参照するため、旧ラベル経由の
後続参照が持つ意味は保たれる。

棚卸しは全317項となり、現行章内依存順10–14をサイトごとの Pauli 行列族、第一転送行列、
残余複合定義、`\sigma^z` の基底作用、`V_1` の二表示の一致として固定した。順15–17の三項は
旧ラベル経由の依存を維持する。`V_2`、単位行列、Jordan–Wigner 行列、全スピン反転行列、
双対結合定数、双曲線関数の略記、別の節境界には進んでいない。次回は残余複合定義から
「第二の転送行列 `V_2`」一単位だけを分離する。

## 2026-09-10: 第二の転送行列を複合定義から分離

2次元イジングモデル章の残余複合定義から、第二の転送行列 `V_2` だけを一つの定義へ分離した。
`M\geq1`、`K_2,K_2^*\in\mathbb{R}_{>0}`、行列指数関数への参照と所属行列空間を新定義へ
集約した。奇数の `M` にも前係数の意味が定まるよう、`2\sinh 2K_2` の正値性を先行主張から導き、
`(2\sinh 2K_2)^{M/2}` を非負平方根の `M` 乗として明示した。双対結合定数の定義と双対関係、
双曲線関数の添字つき略記は残余複合定義に残した。
残余から新定義を明示参照するため、旧ラベルを直接使う後続参照の意味は保たれる。

棚卸しは全318項となり、現行章内依存順10–15をサイトごとの Pauli 行列族、第一転送行列、
第二転送行列、残余複合定義、`\sigma^z` の基底作用、`V_1` の二表示の一致として固定した。
順16–18の二次転送行列の恒等式、`V_2` の二表示の一致、分配関数の Pauli 行列表示は旧ラベル
経由の依存と既存の節境界を維持する。単位行列、Jordan–Wigner 行列、全スピン反転行列、
双対結合定数、双曲線関数の略記、別の節境界には進んでいない。次回は残余複合定義から
「Jordan–Wigner 行列族 `Z_m`」一単位だけを分離する。

独立Codexの初回LLMによる検証で、前係数の平方根と正値性の根拠不足、および既存の偶セクター節を
順67〜71ではなく順67〜70と記した範囲表記漏れを検出した。本文へ先行二項の参照と前係数の定義を
補い、直接依存・外部入力・本文 fingerprint と節範囲を棚卸しへ同期した。再レビューで検出した
射影子性と一般生成子・実対称性の順序表記も現行の章内依存順へ直し、最終再レビューは未解消指摘なし。
プログラミングによる検証では、318ラベルと318項の棚卸し再生成、構造化本文355ブロックの全検査、
370ページのPDF生成、SageMath対応照合、Lean全3005ジョブ、`sorry`・`admit`非使用検査が成功した。

## 2026-09-10: Jordan–Wigner 行列族 Z_m を複合定義から分離

2次元イジングモデル章の残余複合定義から、Jordan–Wigner 行列族 `Z_m` と周期規約だけを
一つの定義へ分離した。`M\geq1`、`1\leq m\leq M`、空積となる
`Z_1=\sigma_1^z`、`Z_{M+1}=Z_1`、元原稿の記号 `p_m`、所属行列空間を新定義へ集約した。
残余複合定義は新定義を明示参照するため、旧ラベルを使う後続項目の意味を保つ。

既存項目では `Z_m,Y_m` の線型独立性だけを新定義と残余複合定義への二つの直接参照へ移した。
`V_1` の Jordan–Wigner 行列表示は旧ラベルへの直接参照を保ち、残余複合定義から新定義への
推移的依存で `Z_m` の意味へ接続する。既存の `V_2` のパウリ行列表示から分配関数へ閉じる節と、
数学的道具立ての分類・節境界は変更していない。

独立CodexのLLMによる検証で、生成規則に対する棚卸しJSONの再生成漏れと、本ファイルの次回単位の
同期漏れを検出して修正した。プログラミングによる検証では、319ラベルと319項の棚卸し再生成、
構造化本文356ブロックの全検査、370ページのPDF生成、SageMath対応124件、Lean全3005ジョブ、
`sorry`・`admit`非使用検査が成功した。次回は残余複合定義から Jordan–Wigner 行列族 `Y_m`
一単位だけを分離し、単位行列、全スピン反転行列、双対結合定数、双曲線関数の略記、
別の節境界には進まない。

## 2026-09-11: Jordan–Wigner 行列族 Y_m を複合定義から分離

2次元イジングモデル章の残余複合定義から、Jordan–Wigner 行列族 `Y_m` と周期規約だけを
一つの定義へ分離した。`M\geq1`、`1\leq m\leq M`、空積となる
`Y_1=\sigma_1^y`、`Y_{M+1}=Y_1`、元原稿の記号 `q_m`、所属行列空間を新定義へ集約した。
残余複合定義は新定義を明示参照するため、旧ラベルを使う後続項目の意味を保つ。

既存項目では `Z_m,Y_m` の線型独立性と `V_1` の Jordan–Wigner 行列表示を、両行列族の
新定義への直接参照へ移した。残余複合定義への参照は、前者ではサイト作用素、後者では
全スピン反転行列と結合定数の根拠として保つ。既存の `V_2` のパウリ行列表示から分配関数へ閉じる節と、
数学的道具立ての分類・節境界は変更していない。

棚卸しは全320項となり、現行章内依存順10–17をサイトごとの Pauli 行列族、第一転送行列、
第二転送行列、`Z_m`、`Y_m`、残余複合定義、`\sigma^z` の基底作用、`V_1` の二表示の一致として
固定した。次回は残余複合定義から全スピン反転行列 `\varepsilon` の定義一単位だけを分離し、
単位行列、`\varepsilon` の Jordan–Wigner 行列による表示、双対結合定数、双曲線関数の略記、
別の節境界には進まない。

独立CodexのLLMによる検証では、線型独立性と `V_1` の表示に残っていた旧複合定義への直接参照、
生成済み棚卸しの節範囲表記、状態台帳と本ファイルの依存記述の不一致を検出した。新しい `Z_m`・
`Y_m` 定義への直接参照と生成規則を同期し、最終再レビューは未解消指摘なしとなった。
プログラミングによる検証では、320ラベルと320項の棚卸し再生成、構造化本文357ブロックの全検査、
371ページのPDF生成、SageMath対応124件、Lean全3005ジョブ、`sorry`・`admit`非使用検査が成功した。

## 2026-09-11: 全スピン反転行列を複合定義から分離

2次元イジングモデル章の残余複合定義から、全スピン反転行列
`\varepsilon:=\sigma_1^x\cdots\sigma_M^x` の定義だけを一つの独立項へ分離した。
サイトごとの Pauli 行列族を直接参照し、所属行列空間と積の順序を明示した。残余複合定義には
Jordan–Wigner 表示を残し、新定義を明示参照させたため、旧ラベルを直接使う後続項目は
新定義へ推移的に接続する。後続項目の直接参照、既存の節境界、数学的道具立ての分類は変更していない。

独立CodexのLLMによる検証では、数学的正しさ、定義の自己完結性、旧ラベルの意味保存、依存関係、
変更範囲、生成物と状態台帳の同期、次回単位に未解消指摘なしとなった。プログラミングによる検証では、
321ラベルと321項の棚卸し再生成、構造化本文358ブロックの全検査、371ページのPDF生成、
SageMath対応124件、Lean全3005ジョブ、`sorry`・`admit`非使用検査が成功した。
次回は全スピン反転行列の Jordan–Wigner 表示一単位だけを分離し、単位行列、双対結合定数、
双曲線関数の略記、別の節境界には進まない。

## 2026-09-11: 全スピン反転行列の Jordan–Wigner 表示を複合定義から分離

2次元イジングモデル章の残余複合定義から、
`\varepsilon=i^M(Z_1Y_1)\cdots(Z_MY_M)` という全スピン反転行列の Jordan–Wigner 表示だけを
独立した主張へ分離した。本文では `Z_m,Y_m` のクロネッカー積表示を因子ごとに掛け、
`\sigma^z\sigma^y=-i\sigma^x` と `(\sigma^x)^2=I` から
`Z_mY_m=-i\sigma_m^x` を得た後、サイト番号の昇順の有限積と
`i^M(-i)^M=1` を一段ずつ計算した。右辺が和ではなく積であることも主張に明記した。

新しい主張は `Z_m,Y_m` と全スピン反転行列の定義を直接参照する。残余複合定義は
新しい表示主張を明示参照するため、旧ラベルを使う後続項目は新しい三定義へ推移的に接続する。
初回レビュー時点では既存 Lean の `Z_mul_Y_same` と `xString_succ_eq` だけを根拠にしていたが、
これは局所積と再帰形までで、順序つき積全体を覆っていなかった。本文へサイト作用素の接頭積と
`Z_mY_m` の接頭積について空積から始める二つの有限帰納法を明記し、Lean に
本文と同じ向きの `zyPrefixProduct_eq_neg_i_pow_smul_xString` と
`epsilon_eq_i_pow_smul_zyPrefixProduct` を追加した。必要十分版
`prefix_eq_pow_smul_of_local_smul` は局所因子の一定スカラー倍だけへ抽象化し、具体版がその特殊化で
あることを `zyPrefixProduct_eq_neg_i_pow_smul_xString_of_necSuf` で記録した。SageMath は本文の
44等号を一ファイル一等号へ分け、Gaussian有理数体上で `M=1,\dots,5` の厳密等号を確認する。
継続レビューで検出した、Lean具体版の等式の向き、必要十分版の欠落、SageMathの複数等号集約、
直前に導いた `Z_m,Y_m` の展開を指さない式変形根拠を、本文・Lean二版・SageMathへ同期して修正した。
単位行列、双対結合定数、双曲線関数の略記、別の節境界、数学的道具立ての分類・節境界には進んでいない。

棚卸しは全322項となり、現行章内依存順10–19をサイトごとの Pauli 行列族、第一転送行列、
第二転送行列、`Z_m`、`Y_m`、全スピン反転行列、その Jordan–Wigner 表示、残余複合定義、
`\sigma^z` の基底作用、`V_1` の二表示の一致として固定した。次回は残余複合定義にある
二次の単位行列の重複記法を、既存の Pauli 行列項への参照へ置き換える一単位だけを扱う。
`2^M` 次の単位行列、双対結合定数、双曲線関数の略記、別の節境界には進まない。

### 独立レビュー指摘の修正

補助記号 `P_r,Q_r` は定義時に `\mathrm{Mat}(2^M,\mathbb C)` への所属を明記した。本文中の独立表示
`P_r=\sigma^x\boxtimes\cdots\boxtimes I` が従来の44等号に含まれていなかったため、`M=1,\dots,5` と
全 `r=0,\dots,M` を Gaussian 有理数体上で厳密検算する一ファイルを追加し、対象を45等号へ直した。

Lean具体版では、第一帰納法、`Z_mY_m=-i\sigma_m^x` の局所積、第二帰納法、終端の係数計算を、本文の
各等号に対応する `calc` とコメントへ展開した。必要十分版は `CommSemiring`・`Semiring`・`Algebra` を
要求せず、`K,A` のモノイド、`K` の `A` への作用、作用と `A` の積の左右の両立だけを仮定する。
具体版ファイルは必要十分版をimportせず、特殊化定理を
`ClaimGlobalSpinFlipJordanWignerRepresentationFromNecSuf.lean` へ分離した。次回単位は変更していない。

最終レビューで、補助添字 `r` の所属集合、Pauli 行列積と `Z_m,Y_m` の各展開に対するLean具体版の
等号対応、第二帰納法のスカラー作用三法則の分離、生成済み棚卸し、45本目のSageMath実行ログが未完で
あることを検出した。`r\in\{0,1,\dots,M\}` を明記し、Lean具体版を本文と同順の個別 `calc` へ
展開した。第二帰納法の本文とSageMath検査も一ステップ一定理へ分けたため、検査対象は本文47等号となる。
47検査と47実行ログを一対一に揃え、全ログの成功を確認した。最終再レビューは未解消指摘なし。
プログラミングによる検証は322ラベルと322項の棚卸し再生成、構造化本文359ブロックの全検査、
373ページのPDF生成、SageMath対応125件、Lean全3007ジョブ、`sorry`・`admit`非使用検査が成功した。

## 2026-09-11: 二次の単位行列の重複記法を既存定義への参照へ置換

2次元イジングモデル章の残余複合定義から、二次の単位行列
`I_{\mathrm{Mat}(2,\mathbb C)}` を再掲していた一覧項目だけを削除した。記号と成分表示は既存の
「Pauli 行列の積」項で既に定義されており、残余複合定義の先頭段落から同項を直接参照するため、
意味と直接依存は変わらない。棚卸しの項目数、章内依存順、既存の節境界も変更していない。

`2^M` 次の単位行列、双対結合定数、双曲線関数の略記、別の節境界には進んでいない。次回は
`2^M` 次の単位行列の重複記法を既存のクロネッカー積項への参照へ置き換える一単位だけを扱う。

独立CodexのLLMによる検証は未解消指摘なし。プログラミングによる検証は322ラベルと322項の
棚卸し再生成、構造化本文359ブロックの全検査、373ページのPDF生成、SageMath対応125件、
Lean全3007ジョブ、`sorry`・`admit`非使用検査が成功した。

## 2026-09-11: 2^M 次の単位行列の重複記法を既存主張への参照へ置換

2次元イジングモデル章の残余複合定義から、
`I_{\mathrm{Mat}(2,\mathbb C)}\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb C)}
=I_{\mathrm{Mat}(2^M,\mathbb C)}` を再掲していた一覧項目だけを削除した。この等式は既存の
「クロネッカー積の積の規則」(2) で証明済みであるため、残余複合定義の先頭段落から同項を
直接参照して意味を保った。棚卸しの項目数、章内依存順、既存の節境界、数学的道具立ての
分類・節境界は変更していない。

双対結合定数と双曲線関数の略記には進んでいない。次回は第一の双対結合定数
`K_1^*:=-\tfrac12\log(\tanh K_1)` の定義を残余複合定義から分離する一単位だけを扱い、
同じ一覧項目にある双対関係、第二の双対結合定数、双曲線関数の略記、別の節境界には進まない。

## 全研究監督: check Y周期性の未統合成果を分離（2026-09-23 03:06）

実行識別子 `105ce5c8-a9c4-4ed5-b3c2-56273c96e46e`。LLMによる検証では、remote defaultに前回監督以後の研究成果はない。check Y添字周期性の17ファイルの差分は本文・SageMath・Lean・PDF検査を通ったが、必須独立レビューが終了コード78で起動できず未コミットのため前進へ数えない。既存段取りは妥当で変更せず、次は保持中のcheck Y周期性だけを正規レビューまで閉じることで、共役添字恒等式へは進まない。

2026-11-02: 「V₂ の可逆性」の証明で、スカラー行列の可逆性と指数表示の二つの表示式に根拠を式の行末へ付けた。
