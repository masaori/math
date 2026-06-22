# Λ gap-map — 方向 D: Massieu 自由エントロピー Φ_N ∈ Λ（cycle 0, 広く浅く）

定義 `inputs/seeds/lambda-statement-program.md`、土台 `docs/discussion/対数順序群上の統計力学/`（特に 00 §2,6・04 分配関数と自由エネルギー・09 Step1 の Φ_L 例）。

## 中核の観察（D の Λ 構造）

有限・離散で有理点 $x=q\in\mathbb{Q}_{>0}$ なら $Z_N(q)\in\mathbb{Q}_{>0}$、その**素因数分解の指数ベクトルが Massieu 自由エントロピー** $\Phi_N=\log Z_N(q)\in\Lambda$。これは $\Lambda$ ネイティブ（09 例: $Z_{C_4}(1/2)=41/8\Rightarrow\Phi=\ell_{41}-3\ell_2$）。等号・順序は素因数分解・整数比較で無条件決定可能。逆温度 $\beta_N(U)=S_N(U{+}1)-S_N(U)\in\Lambda$ も差分商で $\Lambda$、第〇法則 $\beta_A=\beta_B$ は整数比較（00 §6）。

D の statement は「有限 N の Φ・β・S を $\Lambda$ の元として述べ、その恒等式・漸化式・単調性を整数比較で decide する」型。**ℝ を一切使わない有限 N 命題**で、選別基準 (ii) を最強で満たす。

## cell key / Summary

`model × D × target × home × decid × formal × status`

| cell | model | target | home | decid | formal | status |
|---|---|---|---|---|---|---|
| D.K1 | 任意有限・離散 | Φ_N=log Z_N(q)∈Λ（素因数分解） | Λ | yes | yes | known(04/09) |
| D.K2 | 接触系 | 第〇法則 β_A=β_B（整数比較） | Λ | yes | yes | known(00§6) |
| D.K3 | 任意 | Φ_A=S_AB−S_B（Λ ネイティブ） | Λ | yes | yes | known(04) |
| D.U1 | 可積分（転送行列） | Φ_N の漸化式を Λ 関係として（Z_L=Tr T^L 反映） | Λ | yes | yes | unknown |
| D.U2 | 可積分 | 特殊有理点 q での Z_N(q) の素因数構造・閉 Λ 形 | Λ | yes | partial | unknown |
| D.U3 | 任意有限 | β_N=ΔS の有限 N 単調性・凹凸を整数比較で decide | Λ | yes | yes | unknown |
| D.U4 | 任意 | Φ_N(q)=Σ_{root∈ℚ̄} log|q−root|（D↔A 接続） | Λ／ℚ̄ | yes | partial | unknown |

## Known cells

```yaml
cell_id: D.K1
model: 任意の有限・離散模型
direction: D
target_quantity: Massieu Φ_N = log Z_N(q), q∈ℚ_{>0}
home: Λ
decidable: yes（素因数分解の指数ベクトル）
formal_verifiable: yes（ZZ 因数分解, decide）
status: known
known_anchors: [04_分配関数と自由エネルギー, 09(Φ_L 例), 00§2]
coverage_notes: 有理点で Z_N(q)∈ℚ、Φ_N はその素因数分解。Λ ネイティブ・厳密。
review_notes:
```

```yaml
cell_id: D.K2
model: 接触する二系 A,B
direction: D
target_quantity: 第〇法則 β_A(U_A*)=β_B(U_B*)
home: Λ
decidable: yes（整数比較）
formal_verifiable: yes
status: known
known_anchors: [00§6（β=差分商∈Λ, 第〇法則）]
coverage_notes: 逆温度=差分商∈Λ、平衡条件は整数比較で無条件判定。
review_notes:
```

```yaml
cell_id: D.K3
model: 任意
direction: D
target_quantity: Φ_A = S_AB − S_B
home: Λ
decidable: yes
formal_verifiable: yes
status: known
known_anchors: [04]
coverage_notes: Massieu 自由エントロピーは Λ ネイティブ（温度=量子 δ なしで定義）。
review_notes:
```

## Unknown cells（D の Λ-statement 候補源）

```yaml
cell_id: D.U1
model: 可積分模型（転送行列をもつ。Ising/六頂点/dimer）
direction: D
target_quantity: Φ_N(q) の有限 N 漸化式を Λ の関係式として
home: Λ
decidable: yes
formal_verifiable: yes
status: unknown
known_anchors: [D.K1, 09(Z_L=Tr T^L)]
missing_generalization: Z_L=Tr T(q)^L（整数行列の冪のトレース）が Φ_L=log Z_L(q) の Λ 漸化式・整除性に与える構造を、有限 N 命題として述べ decide する。
coverage_notes: 転送行列の整数性 → Φ の Λ 漸化式。ℝ 不使用。
```

```yaml
cell_id: D.U2
model: 可積分模型
direction: D
target_quantity: 特殊有理点 q での Z_N(q) の素因数構造・閉 Λ 形
home: Λ
decidable: yes
formal_verifiable: partial
status: unknown
known_anchors: [D.K1, 09(Z_{C4}(1/2)=41/8)]
missing_generalization: 可積分模型の Z_N(q) が特殊 q で示す素因数構造（例: 円分的因子, 既知数列との一致）を Λ の閉形として捉える。数論的内容。
coverage_notes: 分配関数値の整数論。新規かつ可算ネイティブ。
```

```yaml
cell_id: D.U3
model: 任意の有限・離散
direction: D
target_quantity: β_N=ΔS の有限 N 単調性・凹凸（熱容量符号）を整数比較で decide
home: Λ
decidable: yes（整数比較）
formal_verifiable: yes
status: unknown
known_anchors: [D.K2, 00§6, README「誤差関数 r(ε) の Λ 内評価」]
missing_generalization: 逆温度の差分商の有限 N での単調性・凹凸（熱容量の符号）を ℝ 微分でなく Λ 整数比較で述べ decide する。
coverage_notes: README の未解決スレッド「r(ε) の Λ 内評価・熱容量対応」に直結。
```

```yaml
cell_id: D.U4
model: 任意（D↔A 接続）
direction: D
target_quantity: Φ_N(q) = Σ_{root∈ℚ̄ of Z_N} log|q − root|
home: Λ ／ ℚ̄
decidable: yes
formal_verifiable: partial
status: unknown
known_anchors: [D.K1, A.U1（零点∈ℚ̄）]
missing_generalization: Massieu Φ（Λ 値）を分配多項式の ℚ̄ 零点を通して表し、D（Λ）と A（ℚ̄）を一つの可算命題に束ねる。
coverage_notes: D×A 結節。Φ の Λ 値と零点の ℚ̄ を橋渡し。
```

## 観察（rank への申し送り, D 分）

- D は **ℝ を本体に一切含まない**有限 N 命題ばかりで、選別基準 (ii)(iii) を最強で満たし、`ZZ` 因数分解・整数比較で完全 decide。形式検証（F）に最も乗りやすい。
- 既知核（D.K1-K3）は 04/00 で確立済み。差分は **有限 N の Φ・β を可積分模型で具体的に Λ 命題化**（D.U1 漸化式, D.U3 単調性）と、**数論的内容**（D.U2）。
- D.U4 で A（零点∈ℚ̄）と接続。A/B/C/D 全てが「有限 N＝可算（Λ/ℚ̄）で決定可能」という同一テーマに収束しつつある。
