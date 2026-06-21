# 01. 自動証明（Lean / Coq / Isabelle）での効用

**主張**：$\Lambda$（と $\mathbb{Z},\mathbb{Q},\mathbb{Z}[x]$）に絞ると、形式証明は (i) 実数の形式化コストを払わず、(ii) 等号・順序が決定可能なので自動タクティクで放電でき、(iii) 既存ライブラリにほぼ載り、(iv) $\log p$ の超越性証明を回避でき、(v) 解析でなく差分商で済むぶん軽い。

## 1. 「decidable」という罠語を先に整理

混乱の最大の源を先に潰す。

- **古典 HOL/Lean の `Decidable`**：排中律 (LEM) で `Decidable P` インスタンスが存在すること。Mathlib には `Real.decidableEq`・`Real.decidableLT` が**ある**が、いずれも `noncomputable`（`Classical.dec` 由来、実行できない）[R-C7]。
- **構成的・実行可能な決定可能性**：真偽を**有限ステップで計算するアルゴリズム**があること。`decide`/`omega`/`native_decide` が実際に走る。

本ノートで言う「決定可能」は後者。$\mathbb{R}$ の等号は前者の意味でしか決定可能でなく、後者の意味では**構成的に決定不能**（後述）。$\Lambda$ は両方の意味で決定可能。この区別が「$\Lambda$ に絞ると自動化が効く」の核心。[R-C7][I-C5]

## 2. 実数を持ち込むコスト

### 2.1 構成そのものが重い

- Mathlib の `Real` は $\mathbb{Q}$ の Cauchy 列の同値類（`CauSeq.Completion.Cauchy abs`）として定義される。商型・同値類の上に環構造を持ち上げる手間がかかる。[R-C1]
- Coq 標準ライブラリの実数は**構成されず公理的**に導入される（順序体＋上限公理）。完備性公理は「上限が存在する」と主張するだけで**計算手段を与えない**ため、抽出して走るコードにならない。[R-C2][R-C8]
- 構成的実数 (CoRN/C-CoRN) は計算可能だが「評価用に設計されていない」ため遅く、効率的な exact 実数演算は別途の工学を要する。[R-C3][R-C11]
- Isabelle/HOL も $\mathbb{Q}$ の Cauchy 完備化で $\mathbb{R}$ を構成。[R-C4]

### 2.2 等号は決定不能・順序は半決定のみ（構成的）

- 実数の等号は構成的に**決定不能**：判定不能問題（例：Goldbach 述語）から実数 $r$ を作り、$r=0$ がその述語の全 $n$ 成立と同値になるよう仕込める。[R-C5]
- 順序 $<,\le$ も決定不能。構成的には $\ne$ の代わりに正の**アパートネス** $\#$ を使う。比較は**半決定**：$x\ne y$ なら $x<y$ か $x>y$ を有限時間で確定できるが、$x=y$ では手続きが**停止しない**（$<$ は r.e. だが decidable でない）。[R-C6][X-C2]
- 構造的事実：**計算可能な実関数は必ず連続**。離散・可算では任意の決定可能関数が作れるのと対照的。[X-C3]

### 2.3 解析の形式化は研究級の重量

- 各証明系は極限・連続（ε–δ vs 列）の定義を選び同値性を証明し、積分・微分を組み直す必要がある。Coq の解析を「使いやすく」するために Coquelicot が別途作られたこと自体、基盤層の扱いにくさを示す。[R-C13]
- 例：非負関数の Lebesgue 積分の Coq 形式化は複数論文に渡る大仕事（σ-代数・測度・単関数・単調収束・Fatou）[X-C9]。中心極限定理は専用の本格的形式化を要した（Isabelle、Avigad ら）[X-C10]。
- 形式化のオーバーヘッド指標「de Bruijn factor」は概ね一定（圧縮で ~4、生で 10–20）だが、解析はその係数が大きく出る側。[R-C12]

**含意**：統計力学の核を $\mathbb{R}$ で書くと、この重量がすべての証明に乗る。$\Lambda$ で書けば §3 のとおり回避できる。

## 3. $\Lambda$ 側の決定可能性（自動化が効く）

### 3.1 理論レベル

- **Presburger 算術** $(\mathbb{Z},+,<)$ は決定可能（Presburger 1929、量化子消去）。複雑性は二重指数下界（Fischer–Rabin）・三重指数上界（Oppen）。[D-C1][D-C2][D-C3]
- **順序アーベル群一般**の一階理論は決定可能（Gurevich）。**有限生成自由アーベル群** $\bigoplus\mathbb{Z}\cong\mathbb{Z}^n$（固定順序つき）の等号・順序は座標ごとの整数比較に還元され、Presburger 内で完全に決定可能。[D-C4][D-C7]
- $\mathbb{Z},\mathbb{Q}$ の等号・順序は決定可能（$a/b$ vs $c/d$ は $ad$ vs $cb$ の整数比較）。[D-C5][D-C6]
- 対比：$\mathbb{R}$ は**一階代数的断片 (RCF)** だけが決定可能（Tarski–Seidenberg、ただし二重指数；実装された検証済み QE は日常タクティクには非現実的）。解析的演算（極限・$\exp$・一般の実数等号）が入った瞬間に決定可能性を失う。[D-C9][D-C10][D-C15][D-C16]

### 3.2 タクティクレベル（実際に何が放電するか）

- Lean：`omega`（ℤ/ℕ 上の線形整数算術＝Presburger 断片の決定手続き）、`decide`（`Decidable` 命題をカーネル計算で評価）、`linarith`（稠密線形順序で完全）。[D-C13]
- Coq/Rocq：`lia`（線形整数算術の**完全**決定手続き）、`lra`（線形実/有理算術の完全決定手続き）。[D-C14]
- $\Lambda$ 上の主張（第〇法則 $\beta_A=\beta_B$、エントロピー差の符号、零点係数の整数等式など）は、整数比較・線形整数算術に落ちるので**これらで自動放電できる**。$\mathbb{R}$ 上の極限・指数の主張にはこの自動化は効かない（決定可能理論の外）。[D-C16]

## 4. Mathlib の整備状況（ほぼそのまま載る）

- **キャリア**：`Nat.Primes →₀ ℤ`（＝ `Finsupp`）が最適。`Finsupp` は成熟した加法 API・`DecidableEq` を持ち、`finsuppLEquivDirectSum` で $\bigoplus_p\mathbb{Z}$ 表示と相互変換できる。`FreeAbelianGroup` 型もあるが Finsupp/決定可能等号の API が薄く、Finsupp キャリア推奨。[M-C1][M-C3][M-C4][M-C14]
- **$\log$ ＝素因数分解**：`Nat.factorization : ℕ → (ℕ →₀ ℕ)` が「素数→指数」写像として完備。`padicValNat`・`multiplicity` と一致する補題、$\mathrm{factorization}(mn)=\mathrm{factorization}(m)+\mathrm{factorization}(n)$（乗法→加法）、積で $n$ を復元する補題まで在る。`Nat.factorizationEquiv` も。[M-C8][M-C9][M-C10][M-C12]
- **順序・アルキメデス**：`LinearOrderedAddCommGroup`・`Archimedean` あり、ℤ/ℚ はインスタンス。アルキメデス順序群の分類（ℤ か稠密か）も形式化済み。[M-C5][M-C6][M-C7]
- **要自作のギャップ**：$(\mathbb{Q}_{>0},\times)\cong(\mathrm{Primes}\to_0\mathbb{Z})$ の群同型がパッケージ済み宣言として見当たらない（ℕ レベルの部品は在るので組み立てで済む）。[M-C13]

## 5. 超越性を回避できる（設計上の最大の利得）

- $\ell_p=\log p$ は $\overline{\mathbb{Q}}$ 上**超越**（Hermite–Lindemann）。$\{\log p\}$ の $\mathbb{R}$ 上一次独立は Baker 級の結果を要する。[R-C/超越]
- Hermite–Lindemann–Weierstrass は **Isabelle AFP に完全形式化**あり（Eberl 2021、$\ln z$ の超越性系も含む）。**Mathlib には `Real.log p` の超越性が宣言として無い**（HLW の解析部は形式化されつつあるが系として未パッケージ）。Coq は Lindemann–Weierstrass あり、Gelfond–Schneider は 2026 に Lean 4 で初形式化。[M-C15][M-C16][M-C17]
- **設計上の鍵**：$\ell_p$ を $\mathrm{Primes}\to_0\mathbb{Z}$ の**形式生成元**として扱えば、超越性も $\mathbb{R}$ 一次独立性も**一切消費しない**。$\{\ell_p\}$ の独立性は「$\sum a_p\ell_p=0\Rightarrow\prod p^{a_p}=1\Rightarrow a_p=0$」という**初等的・整数的**事実（算術の基本定理）で済み、Baker/HLW を呼ばない。$p\mapsto\mathrm{Real.log}\,p$ で $\mathbb{R}$ に埋め込む段でのみ超越性が要るが、核では埋め込まない。[M-C18]

これは [統計力学 00](../対数順序群上の統計力学/00_記号と定義.md) §0.4「$\ell_p$ は形式記号、$\ln p\in\mathbb{R}$ は参照しない」「Schanuel 不要」の、形式証明側での具体的な配当。

## 6. 差分商の軽さ（解析でなく代数）

- 逆温度 $\beta=S(U+1)-S(U)$ は**微分でなく差分商**（[統計力学 00](../対数順序群上の統計力学/00_記号と定義.md) §6、[01](../対数順序群上の統計力学/01_β定数化はΛを出るか.md)）。形式証明では群の減法＝純代数的操作で、極限・連続性・収束の補題を一切要しない。
- 第〇法則 $\beta_A=\beta_B$ は離散集合上の $\arg\max$ 条件 $\omega(U^\ast\pm1)\le\omega(U^\ast)$ を $\log$ で書き換えた整数比較。微分も極値解析も使わない。$\mathbb{R}$ の微分で定義すると §2.3 の解析重量が乗る。

## 7. まとめ

| 論点 | $\Lambda$ 側 | $\mathbb{R}$ 側 |
|---|---|---|
| 構成 | `Finsupp`/`Nat.factorization` 既存 [M] | Cauchy 完備化／公理的、重い [R-C1,C2] |
| 等号 | 決定可能（整数比較） [D-C7] | 構成的に決定不能 [R-C5] |
| 順序 | 決定可能 | 半決定のみ [R-C6][X-C2] |
| 自動化 | `omega`/`lia`/`decide` [D-C13,C14] | 専用解析証明、自動化弱い [R-C13] |
| 超越性 | 不要（形式生成元） [M-C18] | Real.log p 超越性が要・未パッケージ [M-C16] |
| 微分 | 差分商＝代数 | 極限・連続性ライブラリ [X-C9,C10] |

一文：**$\Lambda$ に絞ると、証明系で実数を構成する手間・等号の決定不能性・解析ライブラリの重量・超越性証明をすべて回避でき、主張は `omega`/`lia`/`decide` で自動放電できる整数・有理・自由アーベル群の言明に収まる。** $\mathbb{R}$ を呼ぶのは統計力学ノートの脱出 (a)(b)(c) だけで、そこでのみ `noncomputable` と解析証明のコストを払う。

（出典コード [R-*]=実数形式化、[D-*]=決定可能性、[M-*]=Mathlib、[X-*]=横断、は [出典.md](出典.md) に対応。）
