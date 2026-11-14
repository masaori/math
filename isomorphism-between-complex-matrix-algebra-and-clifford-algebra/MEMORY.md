# MEMORY — 複素行列環とクリフォード代数の同型

## 次回やること

- 状態台帳（`docs/tasks/proof-state.md`）の「次の一歩」の先頭の未着手の行を、runbook（`docs/tasks/proof-runbook.md`）に従って進める。

## 未解決問題・確認事項

- なし（番号の無い有限集合の上の和は、2026-11-01 の研究管理が台帳に行として足した）。

## 完了済み

- 2026-11-14: 台帳の「Lean：複素行列環の章と、同型の証明の章のうち生成作用素の行列と反交換関係の具体版と必要十分版」の行を書き切った。本文 50 ブロックを lean/…/ComplexMatrixAlgebra/ と Isomorphism/CreationOperatorMatrices/ に具体版・必要十分版・導出版で形式化した（lean/README.md の「必要十分版が示したこと（章『複素行列環』…）」）。本文の二か所で一行に二つの定義を開いていた行を割った。次は台帳の Lean の次の行（行き Φ の構成とクリフォード代数の中の局所的な等式）。行列環は `matricesComplexAlgebra hX`、行列単位は `matrixUnit`、生成と消滅の作用素の行列は `creationMatrix`・`annihilationMatrix`、P_M は `PowerSet M`（有限であることは `isFiniteSet_powerSet M`）。

- 2026-11-13: 「Lean：数学的道具立ての節『二次形式』と、クリフォード代数の章の具体版と必要十分版」の行を書き切った。本文の 27 ブロック（二次形式の節 11、クリフォード代数の章 16）を、具体版 lean/…/MathematicalToolkit/QuadraticForm/QuadraticForm.lean・CliffordAlgebra/DefinitionAndUniversalProperty/CliffordAlgebra.lean・CliffordAlgebra/SplitQuadraticSpace/Generators.lean と、必要十分版（NecSuf/ の同じ名前の三ファイル）と、導出版（QuadraticFormFromNecSuf・CliffordAlgebraFromNecSuf・GeneratorsFromNecSuf）に形式化した。前提「V・基底 b・二次形式 q」は structure QuadraticSpaceWithBasis、分裂した二次空間の前提は SplitData に置いた。導出版では、具体版と必要十分版の T(V)・I_q が命題としてしか等しくないので、各主張を T(V)・ι・I を変数にした形に書き直して具体版のものを入れた。分裂した二次空間の節は W^* が別の部分型でクリフォード代数が別の集合になるので、普遍性で互いに逆向きの準同型を作り、必要十分版の主張を引き戻した。必要十分版で分かったこと: 章「クリフォード代数」のどの主張も q が二次形式であることを使わない。a + (-a) = 0 を使うのは γ(v)² の計算・反交換子・普遍性の存在の三つだけで、分裂した二次空間の節は章の前半の仮定のほかに K の性質を足さない。別のエージェントのレビュー 1 回（必須 5・任意 6）で、本文 claim_square_of_clifford_generator の「0 + x = x（加法の単位元）」の行が右の単位元しか持たない環の公理から一ステップでは出ないので、加法の交換法則と加法の単位元の二行に割った（Lean の行も割った）。ほかに必要十分版の仮定の束ね方（a + (-a) = 0 を使う主張だけに置く、W^* の性質を章の仮定から作る）・導出版の運び方・説明の誤りを直した。lake build（警告なし）・check-no-sorry（1615 宣言）・npm run gen・check・build:pdf（276 ページ、未解決参照 0 件、組めない文字 0 件）通過。SageMath は行列の計算を含まないので不要。

- 2026-11-13: 台帳の「Lean：数学的道具立ての節『テンソル代数』の代数の構造と普遍性の具体版と必要十分版」の行を書き切った。本文 56 ブロックを lean/…/TensorAlgebra/ の六ファイルに形式化し、必要十分版五ファイルと導出版二ファイルを置いた。本文の二か所の根拠の引き方を直した。lake build・check-no-sorry・npm run check・build:pdf 通過。次は台帳の Lean の次の行（節「二次形式」とクリフォード代数の章）。
- 2026-11-13: 台帳の「Lean：数学的道具立ての節『テンソル代数』の土台の具体版と必要十分版」の行を書き切った。本文 21 ブロックを lean/…/TensorAlgebra/ の四ファイルと IndexShift.lean に形式化し、必要十分版（NecSuf/…/TensorAlgebra/ の四ファイル）と導出版 TensorAlgebraFromNecSuf.lean を置いた。テンソルの積を定めるには係数の乗法の交換法則が要ると分かった（lean/README.md の「必要十分版が示したこと（節『テンソル代数』の土台）」）。本文の参照を一か所直した。次の行（代数の構造と普遍性）は TensorPowers・tensorMul・DirectSumOfFamily をそのまま使う。
- 2026-11-13: 台帳の「Lean：数学的道具立ての節『テンソル積』の具体版と必要十分版」の行を書き切った。本文 26 ブロックを lean/…/TensorProduct/ の五ファイルに形式化し、必要十分版（NecSuf/…/TensorProduct/ の四ファイル）と導出版 TensorProductFromNecSuf.lean を置いた。必要十分版で、座標による構成が k 重テンソル積であることに係数の乗法の交換法則が要ると分かった（lean/README.md の「必要十分版が示したこと（節『テンソル積』）」）。worktree では lake が PATH に無いので ~/.elan/bin を足し、lake exe cache get の後に lake build する。
- 2026-11-13: 台帳の「Lean：数学的道具立ての節『両側イデアルと商代数』の具体版と必要十分版」の行を書き切った。本文 37 ブロックを lean/…/IdealAndQuotientAlgebra/ の五ファイルに形式化し、必要十分版（合同の -1_ℂ を K の元 n に替える）と導出版を置いた。本文は不変。lake build・check-no-sorry 通過。次は台帳の Lean の次の行（節「テンソル積」）。
- 2026-11-13: 台帳の「Lean：数学的道具立ての節『有限集合の上の和』『ℂ-代数』の具体版と必要十分版」の行を書き切った。本文 25 ブロックを lean/…/FiniteSetSum/（Numbering・Reindexing・SumOverFiniteSet・DoubleSum）と ComplexAlgebra/（Definitions・Homomorphisms）に形式化し、必要十分版・導出版を置いた。本文の二か所で項の等しい線型結合が等しいことの根拠を claim_linear_combinations_with_equal_terms_are_equal の参照に直した。lake build・check-no-sorry・npm run check・build:pdf 通過。
- 2026-11-13: 台帳の「Lean の設定と、節『環』『ℂ-線型空間』の具体版と必要十分版」の行を書き切った。lean/ を立て（v4.32.1、lake exe cache get が要る）、具体版・必要十分版・導出版を置いた。規約は lean/README.md。本文に「項ごとに等しい二つの ℂ の中の番号順の和は等しい」を足した。次は台帳の Lean の次の行（節「有限集合の上の和」「ℂ-代数」）。
- 2026-11-13: 台帳の系「複素行列版イジングの Jordan–Wigner 行列への接続」の行を書き切った。P_M で直接添字づけたクロネッカー積とその積の規則、c_m と c_m^T のクロネッカー積の形、U=⊠K による共役で c_m+c_m^T→Z_m、(−i)c_m+ic_m^T→Y_m、Ω=κ_{U,U'}∘Φ_Y が直交基底を Jordan–Wigner 行列へ送る同型であること。SageMath 通過。記述の行はこれで全部済み、残りは Lean の行。
- 2026-11-12: 台帳の系「奇数次元」の行を書き切った。V'=V⊕ℂ^vec、q'((v,t))=q(v)+t·t、j=Cl(in'_1)、g=γ'(in'_2(1))、符号の因子 χ_i とその番号順の積 ε、中心の元 z=j(ε)g（すべての元と交換し z^2=1）、二つの ℂ-代数の直積、Φ'（普遍性による）、冪等元 e_±、Ψ'、系（Φ' と Ψ' が互いに逆）を置いた。SageMath 一つ通過。次は系「複素行列版イジングの Jordan–Wigner 行列への接続」。
- 2026-11-12: 台帳の「系『一般の偶数次元の非退化な二次空間』の後半」の行を書き切った。ℂ の平方根の存在（ℝ の完備性へ脱出）、正規直交基底、座標を係数にした線型結合の写像 L_{b,u}、等長写像 θ:Y→W⊕W* と逆 θ'、等長写像が誘導する準同型 Cl(θ)、系（Φ∘Cl(θ) と Cl(θ')∘Ψ が互いに逆）を置いた。SageMath 一つ通過。次は系「奇数次元」。
- 2026-11-12: 台帳の「系『一般の偶数次元の非退化な二次空間』の前半」（直交基底の存在）の行を書き切った。基底の各元に一つの元の倍を足した族が基底であること（足す元自身の係数が 0 のとき）を唯一の取り替えの補題にし、「第 k 元まで直交化された基底」を k の帰納法で延ばして、非退化な二次形式に B_q(e_i,e_j)=0（i≠j）・q(e_i)≠0 の基底があることを示した。部分空間へ移る経路は採らず notes/isomorphism.ts に理由を置いた。SageMath 一つ通過。次は同じ系の後半。
- 2026-11-12: 台帳の「主定理の系のうち基底と行列の番号付け」の行を書き切った。部分集合の組の番号付け p_M、番号付けによる行列の添字の付け替え ν_e・μ_e と、2 進の番号付けによる Mat_{P_M}(ℂ) と Mat_{{1,…,2^M}}(ℂ) の同型の系、行列単位にあたる元の族 b_m=𝓔_{S_m,T_m} が Cl(V,q) の基底であることの系を置いた（基底の系は Φ の像の成分で係数を取り出し、Ψ∘Φ=id で戻す）。SageMath 三つ通過。
- 2026-11-12: 台帳の「同型の証明の章の書き方と SageMath の検算の直し」の行を書き切った。y^S_t・z^T_t・ž^T_k・x_i を独立の定義にし、a_{T,≤m}・a†_{U,≤m}・P_{≤m}・Q^{T,U}_m の定義の中の等式を六つの主張に出した。消滅の因子が a_i を左へ渡す主張の Q_m を a_{T,≤m} に揃えた。部分積と族の制限の積の一致、零との積が零であることを数学的道具立ての主張にして引いた。地の文の等号の鎖を整列した式変形にし、代入 f:=・p:=,q:= と e_{S,T}（→ 𝓔_{S,T}）の記号の衝突を解いた。SageMath の四つの検算（φ の実装と in_1/in_2 の否定の対照、平方の否定の対照、2 進の番号付けの二通りの構成、非自明な件数）を直した。次は主定理の系のうち基底と行列の番号付けの行。
- 2026-11-12: 台帳の「数学的道具立てとクリフォード代数の章の書き方の直し」の行を書き切った。後方参照 3 件を解き、1 ブロック 2 定義の 4 か所を分け、T(V) と双対基底が基底であることを独立のブロックにし、族の直和のスカラー倍を ∗_D に改めて T(V) の乗法 ·_{T(V)} との衝突を解き、一行二法則と地の文の等号の鎖を整列した式変形にし、どこからも引かれない前の組を固定した主張を notes へ移した。次は同型の証明の章の書き方と SageMath の検算の直しの行。
- 2026-11-12（研究管理）: 主定理までの本文を読み、数学的な誤りと暗黙の同一視が無いことを確かめた。書き方の点（後方参照 3 件、代入の文字と双対基底 f などの記号の衝突、定義の中の等式、地の文の等号の鎖、参照元の無い主張）と SageMath の対照の不足を、章ごとの直す行二つとして台帳の先頭に足した。一般の偶数次元の系を二行に、Lean の 8 行を節の単位の 12 行に割り直し、runbook に Lean の具体版の書き方（本文の構造を Lean の structure で書き mathlib の一般論で置き換えない）を書いた。
- 2026-11-12: 「帰り Ψ と主定理」の行を書き切った。Ψ(F):=Σ_S 1∗(Σ_T F_{S,T}∗(a†_S P)a_T) を定義し、ℂ-代数の準同型であること、Φ∘Ψ=id、Ψ(c_i)=a†_i・Ψ(c_i^T)=a_i から Ψ∘Φ=id を示し、主定理（Φ は全単射で逆写像は Ψ。ラベル theorem_clifford_algebra_of_split_quadratic_space_is_isomorphic_to_matrix_algebra）を記述と SageMath（M=1,2,3、ZZ、行列への像）まで済ませた。Lean は未着手。次は主定理の系のうち基底と行列の番号付けの行。
- 2026-11-12: 「クリフォード代数の中の二つの大域的な等式」の行を書き切った。P a_T a†_U P=δ_{T,U}P を、番号が m 以下の部分の積を真空の因子で挟んだ元 Q^{T,U}_m の三つの場合の漸化式（符号が現れない）と m の帰納法で示した。1 の分解 Σ_S 1∗((a†_S P)a_S)=1 を、(a†_{S,≤m}P_{≤m})a_{S,≤m}=∏_{i≤m}u^S_i と、部分集合ごとに因子を選んだ積の 2 進の番号付けの順の和が因子の和の積になる一般の ℂ-代数の主張で示した。SageMath 三つ（M=1,2,3、ZZ）通過。次は帰り Ψ と主定理。
- 2026-11-12: 「クリフォード代数の中の局所的な等式」の行を書き切った。a†_S・a_T・P を番号順の積で定め、a_i P=0、P a†_i=0、a†_i a†_T（i∉T なら ς(N_i(T))∗a†_{T∪{i}}、i∈T なら 0）、a_T a_i（同じ形）を、符号を番号の帰納法で運ぶ補題と、番号順の積から一つの因子を取り出す分解で示した。SageMath は Φ による像で確かめた。次は「クリフォード代数の中の二つの大域的な等式」の行。
- 2026-11-12: 「行き Φ の構成」の行を書き切った。c_i·c_i=0 と c_i^T·c_i^T=0、φ((x,g)):=Σβ^w_k(x)∗c_k+Σg(w_k)∗c_k^T とその線型性、φ(v)·φ(v)=q(v)∗1（2 で割らない。平方が零で反交換する元の線型結合の平方が零であることを部分和の帰納法で示した）、Φ の存在と一意性と Φ(a†_i)=c_i・Φ(a_i)=c_i^T を示した。次は「クリフォード代数の中の局所的な等式」の行。
- 2026-11-11: 節「分裂した二次空間の生成元の関係」を書き切った。一般の γ(x)γ(y)+γ(y)γ(x)=B_q(x,y)∗1、分裂した二次空間の設定と a†_i:=γ(in_1(w_i))・a_i:=γ(in_2(f_i))、三つの反交換関係、a†_i a†_i=0 と a_i a_i=0 を示した（反交換関係の i=j から 2 で割らない）。次は「行き Φ の構成」の行。
- 2026-11-11: 節「クリフォード代数の定義と普遍性」を書き切った。章のファイル clifford-algebra.ts を置き、I_q・Cl(V,q)・γ の定義、γ の線型性、γ(v)γ(v)=q(v)∗1、γ(V) が生成すること、クリフォード代数の普遍性（ラベル claim_universal_property_of_clifford_algebra）を示した。補題として準同型が零へ移す元の全体が両側イデアルであることを足した。次は「分裂した二次空間の生成元の関係」の行。
- 2026-11-11: 節「二次形式」を書き切った。写像 q:V→ℂ の偏極 B_q、二次形式・非退化性・等長写像の定義、偏極の等式と対称性、W⊕W^* 上の q_W((w,f)):=f(w) とその偏極の値 f(w')+f'(w)、q_W が二次形式であることを示した。次は「クリフォード代数の定義と普遍性」の行。
- 2026-11-11: 節「テンソル代数」の代数の構造と普遍性を書き切った。T(V) を基底の座標による構成の族の直和と畳み込みの積で作り、ℂ-代数であること、埋め込み ι とその線型性、ι(V) が T(V) を生成すること、テンソル代数の普遍性（ラベル claim_universal_property_of_tensor_algebra）を示した。次は節「二次形式」。
- 2026-11-11: 節「テンソル代数」の土台を書き切った。番号付けた ℂ-線型空間の族の直和（有限個を除いて零の族、成分ごとの演算、ℂ-線型空間であること、成分への埋め込み写像 emb_k とその線型性）と、テンソルの積 m_{k,l}:T_k×T_l→T_{k+l} を、つなげた組 cat_{k,l} を通した k+l 重線型写像を k 重・l 重テンソル積の普遍性に二段で当てて定め、純テンソルの積と双線型性を示した。次は節「テンソル代数」の代数の構造と普遍性。
- 2026-11-11: 研究管理 11/11 の読解で見つかった書き方の八点を直した（直和の基底の主張の移動、k 重線型写像の定義から組の集合と成分を置き換えた組を別のブロックへ、n 進の番号付けの定義から X_{n,k} と n^k を別のブロックへ、全射の段と番号順の積の主張の鎖を一行一根拠に、直和の基底の一次独立の参照、証明の無い文と不要な段落の削除）。次は節「テンソル代数」の土台。
- 2026-11-11: 節「テンソル積」を閉じた。直和の基底、写像 {1,…,k}→{1,…,n} の全体の n 進の番号付け、ℂ^X が ℂ-線型空間であること、ℂ の中の番号順の積、基底の座標による k 重テンソル積の構成 (ℂ^X, τ) と、それが k 重テンソル積の普遍性をもつこと（ラベル claim_construction_is_k_fold_tensor_product）を示した。次は台帳の先頭の未着手の行。
- 2026-11-11（研究管理）: 本文の読解で書き方の八点（直和の基底の主張が文書の後ろのブロックを引いていること等）を見つけ、直す行を台帳の先頭に足した。主定理の経路で要るのに台帳に無かった補題（代数の元を掛ける写像の線型性、準同型の合成、準同型が番号順の積を移すこと、ι(V) が T(V) を生成すること）を使う節の行に書き足し、1 の分解の証明の見込みを書いた。runbook に、添字の整数の積・冪にも構造の添字を付けない規則を足した。
- 2026-11-11: 台帳の「直和の基底」を二行に割り、線型結合を前の n 項と後ろの n' 項に分けられること（ラベル claim_splitting_linear_combination_into_first_and_last_terms）を部分和の帰納法で示した。次は直和の基底。
- 2026-11-11: 双対基底は一次独立であること（ラベル claim_dual_basis_is_linearly_independent）を、λ_j から b_j での値を経て 0_ℂ へ着く鎖で示した。次は直和の基底。
- 2026-11-11: k 重テンソル積の普遍性による定義（ラベル def_k_fold_tensor_product）を、線型空間 T と k 重線型写像 τ の組で、任意の k 重線型写像 h が線型写像 h̄ で h̄∘τ=h とただ一つに分解するものとして置いた。次は双対基底の一次独立。
- 2026-11-11: 台帳の分け方を直した。一行を一つの定義・主張にしていたため、証明の積み上げの一回の作業が平均3.5分で終わっていた（直前80回）。残りの39行を、下流で引かれる結果ごとの節に束ねた22行（記述14行・Lean 8行）にし、runbook の「一回の作業の大きさ」を節単位にして、行を一つの主張へ割ることを禁じた。同日に定期実行のあける時間を一度変えたが、代表の指示で120分に戻した。二つの定期実行の指示文には、目的（主定理と系を記述・SageMath・Lean で証明し終えること）と、一回で一つの節を書き切り行を一つの主張へ割らないことを書き、研究管理には済んだ行と未着手の行の数を毎日数えて報告させることにした。
- 2026-11-11: k 重線型写像の定義（ラベル def_k_multilinear_map）を、組を写像 {1,…,k}→V として書き、一つの成分を置き換えた組 v[r↦x] についての加法・スカラー倍の保存で置いた。次は k 重テンソル積の普遍性による定義。
- 2026-11-11: 射影との合成が元の準同型になる商代数からの準同型はただ一つであること（ラベル claim_homomorphism_from_quotient_algebra_composing_with_projection_is_unique）を、代表をとって ψ∘π_I=φ=φ̄∘π_I で値を比べる鎖で示し、商代数の普遍性と名付けた。次は k 重線型写像の定義。
- 2026-11-11: 誘導される写像が ℂ-代数の準同型であること（ラベル claim_induced_map_is_algebra_homomorphism）を、代表をとって射影が演算を保つことと φ̄∘π_I=φ で φ の演算の保存へ移す鎖で示した。次は射影との合成が φ になる準同型の一意性。
- 2026-11-11: 誘導される写像と射影の合成が元の準同型であること（ラベル claim_induced_map_composed_with_projection_is_original_homomorphism）を、誘導される写像の定義の代表に a 自身をとる二行の鎖で示した。次は誘導される写像が ℂ-代数の準同型であること。
- 2026-11-11: 両側イデアルの元を零へ移す準同型が商代数の上に誘導する写像 φ̄:A/I→B（ラベル def_map_induced_on_quotient_algebra）を定義し、代表のとり方によらないことを剰余類の同値と前の主張で本文に示した。次は φ̄∘π_I=φ。
- 2026-11-10: 台帳の「商代数の普遍性」を五行に割り、両側イデアルの元を零へ移す準同型は合同な元に同じ値をとること（ラベル claim_homomorphism_vanishing_on_ideal_takes_equal_values_on_congruent_elements）を、φ(a) から φ(x)+_B φ(a') を経て φ(a') へ着く鎖で示した。次は誘導される写像の定義。
- 2026-11-10: 商集合への射影は両側イデアルの元を零へ移すこと（ラベル claim_projection_onto_quotient_set_sends_ideal_elements_to_zero）を示した。x≡_I 0_A を合同の定義で示し、剰余類の同値と零元の定義 0_{A/I}:=π_I(0_A) で π_I(x)=0_{A/I} を導いた。次は商代数の普遍性。
- 2026-11-10: 商代数への射影が ℂ-代数の準同型であること（ラベル claim_projection_onto_quotient_algebra_is_algebra_homomorphism）を示した。射影が加法・乗法・スカラー倍を保つ三つの主張と、単位元の定義 1_{A/I}:=π_I(1_A) で四つの等式を確かめた。次は射影は両側イデアルの元を零へ移すこと
- 2026-11-10: 商集合の上の演算の組が ℂ-代数であること（ラベル claim_quotient_algebra_is_complex_algebra）を示し、I を法とする商代数と名付けた。スカラー倍と乗法の両立は代表をとって A の両立の条件を移す鎖で示した。次は射影が ℂ-代数の準同型であること。
- 2026-11-10: 商集合の上の演算の組が ℂ-線型空間であること（ラベル claim_quotient_set_operations_form_complex_vector_space）を示した。加法の四条件は環であることの主張を引き、スカラー倍の四条件は代表をとって U_vec(A) の公理を移す鎖で示した。次は商代数が ℂ-代数であること。
- 2026-11-10: 研究管理 11/10 の読解で見つかった書き方の三点（合同が加法と両立することの鎖の最後の行の割り方、代表のとり方によらないことの三つの証明での同値の当て方、係数の一意性の主張文の使わない仮定の文）を直した。次は商集合の上の演算の組が ℂ-線型空間であること。

- 2026-11-10（研究管理）: 台帳の未着手の先頭に本文の書き方を直す行を一つ足し、テンソル積の二行を八行に割った（存在を V の基底の座標で ℂ^X として構成し、自由線型空間と線型空間の商を使わない。双対基底の一次独立・直和の基底・写像の集合の番号付け・ℂ^X が線型空間であることを足した）。runbook に構成の方針を一行足した。

- 2026-11-10: 商集合の上の演算の組が単位元をもつ環であること（ラベル claim_quotient_set_operations_form_unital_ring）を、代表をとって射影が加法・乗法を保つことで π_I の中へ畳み、U_ring(A) の七つの公理を移す鎖で示した。次は商集合の上の演算の組が ℂ-線型空間であること。

- 2026-11-10: 商集合への射影がスカラー倍を保つこと（ラベル claim_projection_onto_quotient_set_preserves_scalar_multiplication）を、商代数の演算の定義の代表に a 自身をとる二行の鎖で示した。次は商集合の上の演算の組が単位元をもつ環であること。
- 2026-11-10: 商集合への射影が乗法を保つこと（ラベル claim_projection_onto_quotient_set_preserves_multiplication）を、加法の主張と同じく商代数の演算の定義の代表に a,b 自身をとる二行の鎖で示した。次は射影がスカラー倍を保つこと。
- 2026-11-10: 台帳の「商代数が ℂ-代数であること」を六行に割り、商集合への射影が加法を保つこと（ラベル claim_projection_onto_quotient_set_preserves_addition）を、商代数の演算の定義の代表に a,b 自身をとる二行の鎖で示した。次は射影が乗法を保つこと。
- 2026-11-10: 商代数の演算の定義（ラベル def_quotient_algebra_operations）を置いた。代表を射影の全射性でとり、π_I の値で加法・乗法・スカラー倍・零元・単位元を定め、代表によらないことは三つの主張を引いた。次は商代数が ℂ-代数であること。
- 2026-11-09: 商集合の上のスカラー倍が代表のとり方によらないこと（ラベル claim_quotient_scalar_multiplication_does_not_depend_on_representatives）を、乗法の主張と同じ形で、合同がスカラー倍と両立することを引いて示した。次は商代数の演算の定義。
- 2026-11-09: 商集合の上の乗法が代表のとり方によらないこと（ラベル claim_quotient_multiplication_does_not_depend_on_representatives）を、加法の主張と同じ形で、合同が乗法と両立することを引いて示した。次はスカラー倍が代表のとり方によらないこと。

- 2026-11-09: 「商代数の演算の定義」を四行に割り、商集合の上の加法が代表のとり方によらないこと（ラベル claim_quotient_addition_does_not_depend_on_representatives）を、射影の定義・剰余類の同値・合同が加法と両立することで示した。次は乗法が代表のとり方によらないこと。

- 2026-11-09: 合同がスカラー倍と両立すること（ラベル claim_congruence_modulo_two_sided_ideal_is_compatible_with_scalar_multiplication）を、差を λ∗_A x に組み替える五行の鎖と両側イデアルがスカラー倍で閉じていることで示した。次は商代数の演算の定義。

- 2026-11-09: 合同が乗法と両立すること（ラベル claim_congruence_modulo_two_sided_ideal_is_compatible_with_multiplication）を、差を (x·_A b)+_A(a'·_A y) に組み替える十行の鎖と両側イデアルの左右から掛ける条件・加法で閉じる条件で示した。次は合同がスカラー倍と両立すること。

- 2026-11-09: 合同が加法と両立すること（ラベル claim_congruence_modulo_two_sided_ideal_is_compatible_with_addition）を、差を x+_A y に組み替える八行の鎖と両側イデアルが加法で閉じていることで示した。次は合同が乗法と両立すること。

- 2026-11-09: 研究管理 11/9 の読解で見つかった書き方の五点（スカラー倍で閉じることの根拠を U_ring(A) に、生成元で一致する準同型の根拠に環の準同型・線型写像の定義、c_ic_j^T+c_j^Tc_i の一行一根拠、証明末尾の「この議論は〜」の文の削除、逆順の積の和の変数 V→Y）を直した。次は合同が加法と両立すること。

- 2026-11-09（研究管理）: 台帳の未着手の先頭に本文の書き方を直す行を一つ、Φ の存在と Ψ∘Φ の前に経路の行を十足した（φ(v)·φ(v)=q(v)I と生成元の自分自身との積を 2 で割らずに示す行を含む）。runbook に、証明の末尾に使わない仮定を並べない規則を足した。


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
