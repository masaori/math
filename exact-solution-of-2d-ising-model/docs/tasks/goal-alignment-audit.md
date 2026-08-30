# ゴール基準適合性の点検（本文 `structured-latex/content/`）

対象: `structured-latex/content/` の全 14 ファイル（約 18,900 行、ブロック約 90 個）
基準: [README.md](../../README.md) の 1〜4 節（ゴール／使わない道具／新しい道具の判断基準／一般化について）
実施日: 2026-07-26
点検時点の `origin/main`: `c4b43f5`（「クリフォード代数の読み物ノートを追加」）
**本点検では修正を一切行っていない。** 各項目の対処方針は依頼者が決める。

---

## 総括

README のゴール設定より前に書かれた本文には、基準に反する記述が広い範囲で残っている。
特に次の 2 つは「本文の骨格そのものが抽象的な土台の上に立っている」類の問題で、
局所的な書き換えでは済まない。

1. **抽象テンソル積の一般論が土台になっている。** README 2 節が名指しで禁じた
   「基底のテンソル積が基底」の定理が本文にあり、そこから 004〜008 章の全域が依存している。
   具体的なクロネッカー積を定義したブロックは本文に存在しない。
2. **群の一般論（自己同型群・核・像・中心・完全列）一式が本文にある。** 008 章。
   これが実際に効いているのは「共役写像 T が定数倍を除いて単射」という 1 つの主張の中の
   1 箇所だけで、その 1 箇所は群論を経由せずに書ける。

加えて、**「テンソル積代数の積の定義」「テンソル積の第 j 因子についての C-線型性」という
根拠が全編で 20 箇所以上使われているが、それを定義・証明したブロックが本文に無い**
（README 3 節 4「暗黙に使われている未定義の概念を残さない」への違反）。

以下、優先度 A（本文の骨格に関わる）と優先度 B（局所的・末端の記述）に分けて列挙する。

---

## 優先度 A: 本文の骨格に関わるもの

### A-1. 抽象テンソル積の一般論が本文の定理として置かれている

| 項目 | 内容 |
| --- | --- |
| ブロック id | `linear_space_general_001_theorem_tensor_product_basis` |
| ラベル | `tensor_basis` |
| ファイル | `002_linear_space_general.mjs`（先頭） |
| 内容 | 「テンソル冪の基底は基底のテンソル積の族」。任意の体 `K`、任意の `n` 次元 `K`-線型空間 `V`、テンソル冪 `V^{⊗m}` について基底を主張し、`dim_K V^{⊗m} = n^m` を述べる |

**何が基準に反するか**: README 2 節「テンソル積について（重要）」が
「抽象的なテンソル積の一般論（**基底のテンソル積が基底、など**）は本文に出さない」と
明示的に禁じている、まさにその主張である。さらに任意の体 `K` 上で述べており
README 4 節「主張は複素行列について具体的に述べる」にも反する。

**なぜ骨格か**: このブロックは以下から参照されており、切り離せない。

- `centralizer_is_scalar`（全元と可換な元はスカラー / 002 章）
- `Z_Y_linearly_independent`（Z_m, Y_m の線型独立性 / 004 章）
- `def_end_iso`（Mat(2,C)^{⊗M} と End(F) の同型 / 004 章）
- `Z_Y_generate_algebra`（Z, Y が全体を生成 / 004 章）

### A-2. `Mat(2,C)^{⊗M}` という抽象テンソル積の記法が本文全域を占めている

| 項目 | 内容 |
| --- | --- |
| 該当ファイル | `002`, `004`, `006`, `007`, `008`（part1/part2）— `\otimes` の出現は合計約 450 箇所 |
| 代表ブロック | `transfer_matrix_001_definition_symbols`（ラベル `def_transfer_matrix_symbols`、004 章冒頭の記号定義）で `σ_k^x, σ_k^y, σ_k^z, V_1, V_2, Z_m, Y_m, ε` のすべてを `Mat(2,C)^{⊗M}` の元として導入している |

**何が基準に反するか**: README 2 節が「M 個の 2×2 行列のテンソル積は、**具体的な 2^M × 2^M の
複素行列（クロネッカー積）として専用の記号で定義する**」と要求しているが、
本文にクロネッカー積を定義したブロックが 1 つも存在しない。`⊗` の意味は
「抽象テンソル積」のまま暗黙に使われている。

**補足**: README 8 節が既に残作業として挙げている項目だが、波及範囲が
004〜008 章の全ブロックに及ぶことを記録しておく。

### A-3. テンソル積の積と多重線型性が、定義なしに証明の根拠として使われている

| 項目 | 内容 |
| --- | --- |
| 使われている根拠文言 | 「テンソル積代数の積の定義」「テンソル積上の積の定義」「テンソル積の第 j 因子についての C-線型性」「スカラーのテンソル多重線型性」 |
| 使用ブロック（主なもの） | `linear_space_general_004_lemma_centralizer_is_scalar`（ラベル `centralizer_is_scalar`）、`transfer_matrix_002_claim_Z_Y_linearly_independent`（`Z_Y_linearly_independent`）、`transfer_matrix_003_claim_V1_V2_in_Z_Y_epsilon`（`V1_V2_in_Z_Y_epsilon`）、`transfer_matrix_005b_claim_end_is_algebra_isomorphism`（`end_is_algebra_isomorphism`）、`transfer_matrix_004_definition_eigenspaces_of_epsilon`（`def_eigenspaces_of_epsilon`）、`transfer_matrix_015_claim_Z_Y_generate_algebra`（`Z_Y_generate_algebra`）、`Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site`（`tensor_anticommutation_from_single_site`） |

**何が基準に反するか**: README 3 節 4「入れる場合、その定義は本文にあるか。
『暗黙に使われている未定義の概念』を残さない」。
`(A_1⊗…⊗A_M)(B_1⊗…⊗B_M) = (A_1B_1)⊗…⊗(A_MB_M)` と各因子についての線型性は、
全編で最も多用される計算規則でありながら、定義も証明も本文に無い。
（クロネッカー積として具体的に定義すれば、どちらも成分計算で示せる主張になる。）

### A-4. リー群・リー環 — **点検時点で解消済み（残課題は軽微なもののみ）**

点検作業中に取り込んだ `origin/main`（`c4b43f5`）で、リー群・リー環の経路は
`structured-latex/notes/005_exp_conjugation_lie_route.mjs` へ退避済みになっていた。
本文（`005_exp_conjugation_proof.mjs`）から次の 5 ブロックが除かれている。

| 除かれた旧ブロック id | 旧ラベル | 内容 |
| --- | --- | --- |
| `exp_conjugation_proof_001_definition_Ad_ad_lie` | （なし） | Lie 群・Lie 環・`Lie(G)`・`dφ_e`・`Ad : G → Aut(G)` |
| `exp_conjugation_proof_002_theorem_Ad_exp_lie` | （なし） | 一般 Lie 群での `Ad(exp X) = exp(ad X)`（未証明のまま置かれていた） |
| `exp_conjugation_proof_005_definition_GL_n_C` | （なし） | `GL(n,C)` と「群をなす」 |
| `exp_conjugation_proof_006_definition_matrix_lie_group` | `def_matrix_lie_group` | Matrix Lie 群（Brian Hall Definition 1.4） |
| `exp_conjugation_proof_009_theorem_exp_conjugation_main` | `brianhall_3.35` | Matrix Lie 群 `G` の仮定つきの `e^X Y e^{-X} = Ad_{e^X}(Y)` |

`def_ad_X_matrix` は `exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix`
（`ad_X` と `Ad_g` を複素行列だけで定義する具体版）へ置き換わっている。

**残っている軽微な点**（優先度は B 相当）:

- 本文の地の文に「Lie 群・Lie 環」という語が説明目的で 3 箇所残っている
  （`exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix` の
  「この定義に Lie 群・Lie 環は現れない」、
  `TV1_hatZ_hatY_006_claim_exp_conjugation`（ラベル `exp_X_Y_exp_-X`）の
  「Lie 群・Lie 環の理論を使わずに証明できる」「Lie 群論には依存しない」）。
  いずれも「使っていない」という否定形の言及だが、本文に定義の無い概念名ではある。
- ラベル `brianhall_exc14`（ブロック `exp_conjugation_proof_008_theorem_exp_ad_series`、
  `e^{ad_X}(Y)` の級数展開）に外部文献名が残っている。中身は複素行列についての具体的な主張。

### A-5. 群の一般論一式（自己同型群・準同型・核・像・中心・完全列）が本文にある

| ブロック id | ラベル | 内容 |
| --- | --- | --- |
| `TV1_hatZ_hatY_007_definition_automorphism_groups` | `def_aut_inn_out` | 自己同型群 `Aut(G)`、内部自己同型群 `Inn(G)`、外部自己同型群 `Out(G) = Aut(G)/Inn(G)`、正規部分群、商群 |
| `TV1_hatZ_hatY_007a_definition_group_hom_ker_im` | `def_group_hom_ker_im` | 群準同型・核・像、核が正規部分群であること、単射性と `Ker = {e}` の同値 |
| `TV1_hatZ_hatY_007b_definition_center_of_group` | `def_center_of_group` | 群の中心 `Z(G)` と、それが正規部分群であること |
| `TV1_hatZ_hatY_007c_claim_inn_normal_in_aut` | `inn_is_normal_in_aut` | `Inn(G) ◁ Aut(G)` |
| `TV1_hatZ_hatY_007d_definition_exact_sequence` | `def_exact_sequence` | 群の完全列 |
| `TV1_hatZ_hatY_008_definition_exact_sequence_aut` | `exact_sequence_of_aut` | `1 → Z(G) → G → Aut(G) → Out(G) → 1` が完全列であること（4 箇所すべての完全性を証明） |
| `TV1_hatZ_hatY_009_definition_ring_multiplicative_group` | （なし） | 一般の環 `R = (R, +_R, ·_R)` の乗法群 `R^×` |

いずれも `008_TV1_hatZ_hatY_part1.mjs`。

**何が基準に反するか**: README 2 節「環・体などの一般論に持ち上げた証明 ✗」および
3 節 2「本筋か、脇道か。脇道の一般論なら、具体的な形に落として本文に書く」。
高校生の読者は、Ising 模型の本筋に入る前に群・正規部分群・商群・完全列を通過させられる。

**本筋との関係**: この一式が実際に使われているのは
`TV1_hatZ_hatY_011a_claim_injectivity_of_T`（ラベル `injectivity_of_T_up_to_scalar`、
「共役写像 T は定数倍を除いて単射」）の証明の中の
`Ker(φ) = Z(R^×)` という 1 点だけである。
`exact_sequence_of_aut` の `conversion.notes` 自身が
「この完全列そのものは、本文の他のブロックからは参照されていない」と記録している。
なお、その 1 点は
`g x g^{-1} = g' x g'^{-1} ⟺ (g^{-1}g') x = x (g^{-1}g')` と書き換えて
`centralizer_is_scalar`（全元と可換な元はスカラー）を当てるだけで済み、
群論の語彙を一切使わずに書ける。

### A-6. 多元環（結合多元環・部分多元環）の一般論

| ブロック id | ラベル | 内容 |
| --- | --- | --- |
| `transfer_matrix_015_claim_Z_Y_generate_algebra` | `Z_Y_generate_algebra` | タイトルが「Z, Y は Mat(2,C)^{⊗M} を**環として生成する**」。statement で `Mat(2,C)^{⊗M}` を「C 上の単位的結合多元環」とみなし、「S を含む最小の C-部分多元環」を導入する |
| `TV1_hatZ_hatY_040_claim_V_eq_cVprime`（`008_TV1_hatZ_hatY_part2.mjs`、Step 3） | `V_eq_Vprime` | 「一致する元の集合は部分多元環をなす」として C-部分多元環の議論を行う |

**何が基準に反するか**: README 2 節「環・体などの一般論に持ち上げた証明 ✗」。
「単位的結合多元環」「最小の部分多元環」は、
「和・スカラー倍・積で閉じた最小の集合」と具体的に言い換えられる（内容は変わらない）。

### A-7. exp の土台が抽象的な有限次元ノルム線型空間になっている

| ブロック id | ラベル | 内容 |
| --- | --- | --- |
| `exp_linear_map_001_theorem_exp_series_pointwise_converges` | `exp_converges` | 体 `K`（`R` または `C`）、**有限次元 `K`-ノルム線型空間 `V`** 上の線型写像 `X : V → V` について exp 級数が各点収束すること。証明で基底・座標写像・線型同型・`dim_K V` を使う |
| `exp_linear_map_002_definition_exp_of_endomorphism` | `def_exp` | `exp : End(V) → End(V)`（`V` は抽象的な有限次元線型空間） |

**何が基準に反するか**:

1. README 4 節「主張は複素行列について具体的に述べる。一般の環・体へ持ち上げない」。
   抽象的な `V` と `End(V)` で述べているため、読者は線型空間・基底・次元・
   自己準同型・線型同型の一般論を先に要求される。
2. **未定義概念**（README 3 節 4）: 証明が「ノルム線型空間の公理として…を用いる」と書いているが、
   「ノルム線型空間」を定義したブロックが本文に無い。
   `def_matrix_norm`（`linear_space_general_002b_definition_matrix_norm`）が定義しているのは
   `K^d` と `Mat(n,K)` のノルムだけである。

**本筋との関係**: 本文で必要な exp は `Mat(n,C)` 上のものだけで、
それは `matrix_exp_series_converges`（`exp_linear_map_000b_claim_matrix_exp_series_converges`）
として既に独立に証明済みである。`def_exp` はそこから
`Mat(2,C)^{⊗M}`（`def_end_iso` 経由）と `M(n,C)` の自己準同型（`ad_X` 用）へ適用されている。

### A-8. パウリ群・クリフォード群

| ブロック id | ラベル | 内容 |
| --- | --- | --- |
| `TV1_hatZ_hatY_010_definition_clifford_group` | `def_pauli_group`, `def_clifford_group` | パウリ群 `P_M`、クリフォード群 `C_M`（`R^×` における `P_M` の正規化群）。さらにユニタリ群 `U(2^M)` と `U(1)` による商にも言及 |
| `TV1_hatZ_hatY_010a_claim_V2_not_in_clifford_group` | `V2_not_in_clifford_group` | `V_2 ∉ C_M` |

**何が基準に反するか**: README 2 節（群の一般論・正規化群）と 3 節 1
「これを理解しないと先へ進めないか。そうでないなら入れない」。
本文自身の `conversion.notes` が
「したがって本文では T_g の定義域を R^× のままとし、**クリフォード群は本証明では使わない**」
と明記している。`V_2 ∉ C_M` は「検討したが採用しなかった経路」の記録であり、
README 6 節に従えばノートへ移す対象である。

なお、README 5 節が言及するクリフォード**代数**（読み物としての材料）は
`structured-latex/notes/009_clifford_algebra.mjs` へ既に整理されている。
本項で問題にしているクリフォード**群**の 2 ブロックはそれとは別物で、本文に残っている。

---

## 優先度 B: 局所的・末端の記述

### B-1. 体 `K` を一般のまま置いている（`K := R` または `K := C` の並記を含む）

| ブロック id | ラベル | 抽象度 |
| --- | --- | --- |
| `linear_space_general_002_claim_scalar_identity_commutes` | `scalar_identity_commutes` | 「体 `K`」「`Mat(n,K)`」— 体を一般のまま置いている |
| `linear_space_general_002b_definition_matrix_norm` | `def_matrix_norm` | `K := R` または `C` |
| `linear_space_general_002c_claim_matrix_norm_triangle_inequality` | `matrix_norm_triangle_inequality` | 同上 |
| `linear_space_general_003_claim_matrix_norm_submultiplicativity` | `matrix_norm_submultiplicativity` | 同上 |
| `linear_space_general_003c_claim_matrix_norm_vector_bound` | `matrix_norm_vector_bound` | 同上 |
| `linear_space_general_003d_claim_matrix_completeness` | `matrix_completeness` | 同上 |
| `linear_space_general_003b_claim_matrix_multiplication_continuity` | `matrix_multiplication_continuity` | 同上 |
| `exp_linear_map_000b_claim_matrix_exp_series_converges` | `matrix_exp_series_converges` | 同上 |
| `exp_linear_map_003_theorem_exp_product_formula_commuting_matrices` | `theorem_exp_product` | 同上 |
| `exp_conjugation_proof_004_theorem_ad_binomial` | `ad_binomial` | 同上 |
| `exp_conjugation_proof_010_theorem_matrix_exp_conjugation` | `matrix_exp_conjugation` | 同上 |

**何が基準に反するか**: README 4 節「主張は複素行列について具体的に述べる」。
`K ∈ {R, C}` の 2 択は「任意の体」ほど抽象的ではないが、
すべての主張・証明が `K` のまま書かれており、読者は毎回どちらの場合かを追う必要がある。

**判断材料**: 実数版が本当に要るのは
`theorem_exp_product` を `Mat(1,R) ≅ R` に適用して実数の指数法則
`exp(a)exp(b) = exp(a+b)` を得る箇所（`partition_function_via_transfer_matrix` の Step 1・Step 4）
だけと見られる。

### B-2. 未定義のまま使われている概念・記号

README 3 節 4「暗黙に使われている未定義の概念を残さない」に該当する。

| 記号・概念 | 使用箇所 | 状況 |
| --- | --- | --- |
| 実数の指数関数 `exp : R → R_{>0}` | `calc_formulae_000b_claim_cosh_sinh_basic_properties`（ラベル `cosh_sinh_basic_properties`）ほか多数 | 定義ブロックが無い。当該ブロックは「`exp(x)exp(y)=exp(x+y)`、`exp(0)=1`、`exp(x)>0`、狭義単調増加であることのみを用いる」と**仮定として**明記している |
| `log`, `tanh` | `transfer_matrix_001_definition_symbols`（`def_transfer_matrix_symbols`）の `K_1^* := -½ log(tanh K_1)`、`K_2^*` も同様 | 本文のどこにも定義が無い |
| 実数の非整数冪 `(2 sinh 2K_2)^{M/2}` | 同上（`V_2` の定義）、および `V1_V2_in_Z_Y_epsilon` | `M` が奇数のとき平方根が必要だが、`^{M/2}` の意味を定めた記述が無い |
| 複素指数 `e^{2πijk/M}`, `e^{iθ}` | `transfer_matrix_009_claim_exp_sum`（`exp_sum`）、`def_hatZ_hatY`、`H1_H2_via_hatZ_hatY`、`recover_Z_Y_from_hatZ_hatY` ほか多数 | `def_exp` は `End(V)` 上の exp。複素数の指数がそのどれに当たるかが本文に無い。`exp_sum` の証明は `cos 2πlj + i sin 2πlj` と等比数列の和の公式を根拠なしに使う |
| `π`、弧長 `l(PQ)` | `calc_formulae_012_definition_arc_length`（円弧の定義） | 「**齋藤微積分 命題 2.1.3 (1) を満たす**実数 `l(PQ)` がただ一つ存在し」として外部文献に委ねている。README 1 節は実解析への脱出を最後の熱力学極限だけに限り、脱出箇所を明示するよう求めているが、ここは冒頭の計算公式章で無明示に実解析へ出ている |
| 行列式 `det`、特性多項式 | 初回監査時の `TV1_hatZ_hatY_011a_claim_injectivity_of_T`（`injectivity_of_T_up_to_scalar`）の証明 | 解消済み。未定義の `det(x+tI) ≠ 0` と特性多項式の経路を削除し、明示的な逆行列を持つ行列単位の摂動だけを使う有限行列計算へ置き換えた |
| ユニタリ行列 `U^† U = I`、`U(2^M)`、`U(1)` | `TV1_hatZ_hatY_010_definition_clifford_group`（`def_clifford_group`） | `†`（随伴）の定義が本文に無い |

### B-3. 記号の不整合

| 箇所 | 内容 |
| --- | --- |
| `Z_Y_anticommutation_001_claim_anticommutation_relations_Z_and_Y`（ラベル `anticommutator_of_Z_and_Y`） | 単位元を `I_{(C^2)^{⊗M}}` と書いているが、他のブロックはすべて `I_{(Mat(2,C))^{⊗M}}`。前者は状態空間 `F = (C^2)^{⊗M}` 側の記号で、`Z_μ, Y_μ` が属する `Mat(2,C)^{⊗M}` とは別の集合の記号である |

### B-4. 複素数を群・モノイド・体の言葉で述べている

| ブロック id | ラベル | 内容 |
| --- | --- | --- |
| `calculation_formulae_023_claim_multiplicative_group_of_polar_representation` | （なし） | 「（極座標表現）は二項演算 `·` について**モノイドをなす**」「…は**群をなす**」 |
| `calculation_formulae_024_claim_multiplicative_group_of_complex_numbers` | `multiplicative_group_of_cc` | `C^× = C∖{0}` は群をなす |
| `calculation_formulae_025_claim_complex_numbers_form_a_field` | `complex_numbers_form_a_field` | 「`C` は**体をなす**」 |
| `calculation_formulae_029_claim_isomorphism_of_phi_cartesian` | `isomorphism_of_phi_cartesian` | 「**モノイド準同型**かつ全単射」。`008_TV1_hatZ_hatY_part2.mjs` の `arg_of_gamma2_quotient` の証明でも「モノイド準同型なのでその逆写像もモノイド準同型」と使われる |

**何が基準に反するか**: README 2 節「環・体などの一般論に持ち上げた証明 ✗」と
3 節 3「より初等的な書き方で済むか」。
これらの主張の中身自体は `C` という具体的な対象についてのものだが、
述べ方が「モノイド」「群」「体」「準同型」という一般論の語彙になっているため、
README 4 節が言う「**述べ方が抽象的なら読者の負担は発生する**」に該当する。
必要なのは実質「積が結合的で単位元があり、0 以外は逆元をもつ」という具体的な事実だけと見られる。

なお README 3 節の失敗例に挙がっている「極座標表現が体をなす」は既に削除されているが、
モノイド・群・体という語彙自体は上記のとおり残っている。

### B-5. 抽象語がタイトルにだけ残っているもの（中身は具体）

| ブロック id | ラベル | 内容 |
| --- | --- | --- |
| `calculation_formulae_046_claim_conjugation_is_ring_homomorphism` | `conjugation_is_ring_homomorphism` | タイトルが「共役写像は**環準同型**」。statement・proof は「乗法的」「単位的」「合成則」を具体的な複素行列について述べており、中身に問題は無い。タイトルとラベル名だけが抽象語 |

### B-6. 本筋に使われていない／本文自身が不要と記録しているブロック

README 3 節 1「これを理解しないと先へ進めないか。そうでないなら入れない」に該当。

| ブロック id | ラベル | 本文自身の記述 |
| --- | --- | --- |
| `exp_conjugation_proof_002_theorem_Ad_exp_lie` | （なし） | 「本ブロックの一般 Lie 群版は**未証明**である」「以降の議論はすべて `matrix_exp_conjugation` を根拠として使い、**本ブロックの一般 Lie 群版を根拠として使うことはない**」。proof は TODO のみ |
| `TV1_hatZ_hatY_008_definition_exact_sequence_aut` | `exact_sequence_of_aut` | 「この完全列そのものは、**本文の他のブロックからは参照されていない**」（`Ker(φ) = Z(R^×)` の 1 点のみ使用） |
| `TV1_hatZ_hatY_010_definition_clifford_group` / `TV1_hatZ_hatY_010a_claim_V2_not_in_clifford_group` | `def_pauli_group`, `def_clifford_group`, `V2_not_in_clifford_group` | 「**クリフォード群は本証明では使わない**」 |

### B-7. 実解析（極限）への脱出箇所が明示されていないブロック

README 1 節「実数への脱出…**どこで脱出したかを明示する**」。
明示している例（良い側）: `V1_restriction_to_eigenspaces` の Step 6
（「ここで解析的操作へ移行するのはこの箇所だけであり、Step 1〜5 はすべて有限個の元の代数的な等式である」）、
`brianhall_exc14`、`partition_function_via_transfer_matrix`（有限和のみである旨を明記）。

明示が無いブロック:

| ブロック id | ラベル | 内容 |
| --- | --- | --- |
| `linear_space_general_003d_claim_matrix_completeness` | `matrix_completeness` | `R` の完備性（Cauchy 列の収束）を根拠に使うが、そこが実解析への依存点であることの明示が無い |
| `exp_linear_map_000a_claim_real_exp_series_converges` | `real_exp_series_converges` | Archimedes の原理、`R` の連続性（上に有界な単調列の収束）を使う |
| `exp_linear_map_000b_claim_matrix_exp_series_converges` | `matrix_exp_series_converges` | `R` の連続性を使う |

（README 2 節は「極限・級数（指数関数の定義に必要な範囲）」を ○ としているので、
使うこと自体は基準内。脱出箇所の明示の有無だけが論点。）

---

## 参考: 数え上げ

| 抽象度の指標 | 出現 |
| --- | --- |
| `\otimes`（テンソル積記号） | 454 箇所（`004`, `006`, `007`, `008` が大半） |
| 「リー群 / リー環 / Lie」 | `005`（7 箇所）、`008 part1`（4 箇所）— いずれも「使っていない」旨の言及と conversion.notes |
| 「準同型」 | 計 35 箇所 |
| 「同型」 | 計 66 箇所 |
| 「基底」 | `002`, `003`, `004`, `008 part1`・計 55 箇所 |
| 「群をなす / 体をなす / モノイド / 多元環」 | `000_20_29`, `004`, `008 part1`, `008 part2` |

---

## 点検の範囲と限界

- `structured-latex/content/` の全ブロックの statement と proof を通読した。
- `structured-latex/notes/`（参照用ノート）は本文ではないため点検対象外とし、
  A-4（リー群経路）と A-8（クリフォード代数）の退避状況の確認にのみ参照した。
- `lean/` および `_old/typst/` は対象外。
- **修正は行っていない。** 各項目をどう扱うか（本文を書き換える／ノートへ移す／そのまま残す）は
  依頼者の判断による。
