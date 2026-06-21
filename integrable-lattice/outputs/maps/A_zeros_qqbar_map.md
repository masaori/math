# Λ gap-map — 方向 A: 分配関数零点 ∈ ℚ̄（cycle 0, 広く浅く）

定義 `inputs/seeds/lambda-statement-program.md`、土台 `docs/discussion/対数順序群上の統計力学/`（特に 05 相転移・06 文献調査・09 2DIsing）。

## 中核の観察（A の Λ 構造）

有限・離散模型では $Z_N(x)=\sum_m\Omega_N(m)x^m\in\mathbb{Z}[x]$。よって **Fisher 零点（$x$＝温度フガシティ平面）・Lee–Yang 零点（活動度平面）は $\mathbb{Z}[x]$ の根＝$\overline{\mathbb{Q}}$**。等号・順序・実軸への距離は `QQbar`（最小多項式＋実根分離）で**無条件決定可能**、丸めゼロ、witness（最小多項式）提示可能。

文献（下記）はほぼ **数値**または**極限の集積曲線（$\mathbb{R}/\mathbb{C}$、$N\to\infty$）** を扱う。**有限 $N$ の零点を $\overline{\mathbb{Q}}$ の厳密対象として述べ・決定する**可算再定式化が差分（06「未踏＝差分」）。相転移本体（零点が実軸を挟む非解析）は ℝ脱出 (b) $N\to\infty$ の一点に隔離される。

## cell key

`model × A × target × home × complexity × solvability × decidable × formal_verifiable × status`

## Summary

| cell | model | target | home | cplx | solv | decid | formal | status |
|---|---|---|---|---|---|---|---|---|
| A.K1 | 2D Ising sq | Fisher 零点(極限集積円) | ℝ/ℂ(極限) | poly | closed | — | — | known |
| A.K2 | Ising(強磁性) | Lee–Yang 単位円定理 | ℚ̄(各N)/ℂ(極限) | poly | closed | yes | yes | known |
| A.K3 | 自由フェルミオン+特殊境界 | 零点の積形 | ℚ̄ | poly | closed | yes | partial | known |
| A.K4 | 自己双対 Ising | 零点軌跡 | ℚ̄/ℝ | poly | closed | yes | partial | known(B 連携) |
| A.U1 | 可積分一般(有限 N) | 零点の厳密 ℚ̄ 軌跡 | ℚ̄ | poly/#P | — | yes | yes | unknown |
| A.U2 | 可積分(自由フェルミ系) | $Z_N(x)$ の ℚ̄ 上積分解 | ℚ̄ | poly | — | yes | partial | unknown |
| A.U3 | 六頂点/dimer | Lee–Yang 活動度零点∈ℚ̄ | ℚ̄ | poly | — | yes | partial | unknown |
| A.U4 | 任意有限・離散 | 有限 ℚ̄ ＋ ℝ脱出一点の分離命題 | ℚ̄ / ℝ脱出 | — | — | yes | yes | unknown |

## Known cells（文献。多くは ℝ/ℂ 漸近・数値で、ℚ̄ 厳密化が差分）

```yaml
cell_id: A.K1
model: 2D Ising 正方格子
direction: A
target_quantity: Fisher 零点（複素温度平面）
home: ℝ/ℂ（極限の集積二円）／有限 N は ℚ̄
complexity: poly（平面=Pfaffian）
solvability: closed（極限の円）
decidable: 有限 N は yes（QQbar）、極限は no（ℝ）
formal_verifiable: 有限 N partial
status: known
known_anchors: [PhysRevD.109.074505(2024), arXiv:2412.07328(低温展開 Fisher 零点)]
coverage_notes: 極限集積曲線（二円）は古典的。有限 N は離散ビーズ。文献は数値/漸近。
review_notes: 有限 N 零点の厳密 ℚ̄ 記述は A.U1 へ。
```

```yaml
cell_id: A.K2
model: Ising（強磁性, 任意格子）
direction: A
target_quantity: Lee–Yang 零点（複素磁場/活動度平面）
home: ℚ̄（各 N）／単位円（極限）
complexity: poly
solvability: closed（Lee–Yang 円定理: 零点は |z|=1 上）
decidable: yes（QQbar）
formal_verifiable: yes（各 N で |z|=1 を代数的に検証可能）
status: known
known_anchors: [Lee-Yang 1952, PhysRevD.109.074505]
coverage_notes: 円定理は強磁性で零点を単位円に拘束。各 N の零点は ℚ̄。
review_notes: 円定理の decide 化（各 N で代数的に |z|^2=1 を確認）は F とも連携。
```

```yaml
cell_id: A.K3
model: 自由フェルミオン可解 + 特殊境界
direction: A
target_quantity: 分配関数零点の積形（product form）
home: ℚ̄
complexity: poly
solvability: closed（積形）
decidable: yes
formal_verifiable: partial
status: known
known_anchors: [arXiv:2507.21943 "Free-fermion approach to the partition function zeros: special boundary conditions and product form"]
coverage_notes: 自由フェルミ＋特殊境界で零点が積形（＝ℚ̄ 因子の積）に閉じる最新例。A.U2 の足場。
review_notes: 一般境界・他模型への拡張が A.U2。
```

```yaml
cell_id: A.K4
model: 自己双対 Ising
direction: A
target_quantity: 零点軌跡（自己双対点との関係）
home: ℚ̄ / ℝ
complexity: poly
solvability: closed
decidable: yes
formal_verifiable: partial
status: known
known_anchors: [arXiv:cond-mat/9805282 "Partition function zeroes of a self-dual Ising model"]
coverage_notes: 双対固定点（B）と零点の集積が代数的に一致。A↔B の結節。
review_notes: 双対による零点位置の代数的固定は B.* と統合検討。
```

## Unknown cells（A の Λ-statement 候補源。選別基準 (i)-(iv) 適合）

```yaml
cell_id: A.U1
model: 可積分格子模型一般（有限 N、まず 2D Ising・六頂点）
direction: A
target_quantity: 有限 N 分配多項式 Z_N(x)∈ℤ[x] の零点の厳密 ℚ̄ 軌跡（最小多項式・実軸距離）
home: ℚ̄
complexity: poly〜#P（模型依存）
solvability: —（有限 N 命題、極限は別）
decidable: yes（QQbar: 最小多項式＋実根分離）
formal_verifiable: yes（witness=最小多項式）
status: unknown
known_anchors: [A.K1, A.K2]
missing_generalization: 文献は数値/極限集積曲線。有限 N 零点を「ℚ̄ の元」として厳密に述べ・決定・witness 提示する可算再定式化が差分（06）。
coverage_notes: 最有力。ℝ 不使用の有限 N 命題で完全に決定可能・形式検証可能。
```

```yaml
cell_id: A.U2
model: 自由フェルミオン可解な可積分模型（境界つき含む）
direction: A
target_quantity: Z_N(x) の ℚ̄ 上の積分解（因数分解の閉形）
home: ℚ̄
complexity: poly
solvability: closed（積形を予想）
decidable: yes
formal_verifiable: partial
status: unknown
known_anchors: [A.K3]
missing_generalization: 特殊境界での積形（K3）を、どの模型・境界クラスまで「Z_N(x)=∏(代数的因子)」に拡張できるか。C（自由フェルミ構造保存）と直結。
coverage_notes: A と C の交差。積形＝ℚ̄ 因子の積で構造保存性の指標。
```

```yaml
cell_id: A.U3
model: 六頂点 / dimer（Ising 以外）
direction: A
target_quantity: Lee–Yang 型 活動度/重み零点 ∈ ℚ̄
home: ℚ̄
complexity: poly
solvability: —
decidable: yes
formal_verifiable: partial
status: unknown
known_anchors: [A.K2]
missing_generalization: Lee–Yang 円定理級の零点拘束を Ising 以外の可積分模型（六頂点フガシティ、dimer 辺重み）で ℚ̄ 厳密に述べる。
coverage_notes: 模型横断で円定理の代数版を探す。
```

```yaml
cell_id: A.U4
model: 任意の有限・離散模型
direction: A
target_quantity: 「有限 N 零点 ∈ ℚ̄（決定可能）」と「相転移 = 零点の実軸挟み込み = ℝ脱出 (b) N→∞ の一点」の厳密分離命題
home: ℚ̄ ＋ ℝ脱出一点
complexity: —
solvability: —
decidable: 有限部 yes
formal_verifiable: yes（有限部）
status: unknown
known_anchors: [A.K1, 05_相転移はΦで論じられるか]
missing_generalization: 「どこまでが可算・決定可能で、どこで ℝ が要るか」を零点プログラムで厳密命題化（梯子の calibration を零点に適用）。
coverage_notes: 09/05 の立場の零点版。メタだが形式検証・逆数学 calibration に直結（可算性の効用§3）。
```

## 観察（rank への申し送り, A 分）

- A は Λ プログラムと最も相性が良い：有限 N で零点が無条件に ℚ̄、`QQbar` で厳密・decide 可能・witness つき。文献の数値/極限とのギャップ（ℚ̄ 厳密化）が明確な差分。
- A.U1（有限 N 零点の厳密 ℚ̄ 軌跡）と A.U4（可算/ℝ 分離命題）は **ℝ を本体に含まない**点で選別基準 (ii) を最強で満たす。A.U2 は C（自由フェルミ構造）と交差。
- 次の周で SageMath `QQbar` 実演（A.U1 を小 N で）に進めば即・形式検証可能な成果になる。
