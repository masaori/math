# Λ gap-map — 方向 B: 臨界点の代数性・双対固定（cycle 0, 広く浅く）

定義 `inputs/seeds/lambda-statement-program.md`、土台 `docs/discussion/対数順序群上の統計力学/`（特に 08 KW双対性・09 2DIsing $x_c=\sqrt2-1$・05 相転移）。

## 中核の観察（B の Λ 構造）

自己双対条件（KW / star-triangle）は **ℤ 係数の代数的不動点方程式**。よって**自己双対点＝臨界点は $\overline{\mathbb{Q}}$ の元**で、その値・実根性は `QQbar` で無条件決定可能・witness（最小多項式）付き。08 が言う通り、双対が「買うもの」は**位置の条件付き固定＝代数的臨界点**（「買わないもの」は閉形式・転移の存在）。

- 2D Ising 正方: $\sinh 2K=1\iff x_c=\sqrt2-1\in\overline{\mathbb{Q}}$（KW 自己双対点）。
- $q$-状態 Potts 正方: 自己双対点 $e^{K_c}=1+\sqrt q\in\overline{\mathbb{Q}}$（整数 $q$）。
- Potts 三角/六角: star-triangle 臨界条件は多項式 → 代数的臨界点。

「相転移の存在・非解析性・臨界指数」は ℝ脱出 (b) $N\to\infty$ 側。**B が可算で言えるのは臨界点の位置の代数性だけ**（07-4 可解性とは別、08 と一致）。

## cell key

`model × B × target × home × complexity × solvability × decidable × formal_verifiable × status`

## Summary

| cell | model | target | home | decid | formal | status |
|---|---|---|---|---|---|---|
| B.K1 | 2D Ising 正方 | $x_c=\sqrt2-1$（KW 自己双対） | ℚ̄ | yes | yes | known |
| B.K2 | $q$-Potts 正方 | 自己双対点 $1+\sqrt q$ | ℚ̄ | yes | yes | known |
| B.K3 | Potts 三角/六角 | star-triangle 臨界多項式 | ℚ̄ | yes | partial | known |
| B.K4 | 一般 KW 自己双対 | 双対対合の不動点 | ℚ̄ | yes | partial | known(08) |
| B.U1 | 可積分一般 | 「代数的双対対合の不動点∈ℚ̄」分類命題 | ℚ̄ | yes | yes | unknown |
| B.U2 | 自己双対系 | 自己双対多項式の一意実根∈ℚ̄（witness） | ℚ̄ | yes | yes | unknown |
| B.U3 | 双対で固定されない系 | 臨界点が代数的でない/未知の境界 | ℚ̄ or ℝ | 一部 | 一部 | unknown |
| B.U4 | Ising/Potts | 自己双対点 = Fisher 零点集積点（A↔B） | ℚ̄ | yes | partial | unknown |

## Known cells

```yaml
cell_id: B.K1
model: 2D Ising 正方格子
direction: B
target_quantity: 臨界点 x_c = √2−1
home: ℚ̄
complexity: poly
solvability: closed（Onsager）
decidable: yes（最小多項式 x^2+2x−1）
formal_verifiable: yes
status: known
known_anchors: [09_2DIsing(Step4 x_c=√2−1), 08_KW双対性, Kramers-Wannier 1941]
coverage_notes: KW 自己双対 sinh2K=1 から代数的に確定。臨界点の位置は ℚ̄、非解析性は ℝ。
review_notes:
```

```yaml
cell_id: B.K2
model: q-状態 Potts 正方格子
direction: B
target_quantity: 自己双対点 e^{K_c}=1+√q
home: ℚ̄（q 整数/代数的）
complexity: poly〜#P（q 依存）
solvability: q≤4 連続転移など部分的
decidable: yes（√q は代数的）
formal_verifiable: yes
status: known
known_anchors: [hep-lat/9801006 "Critical Equalities for Potts Models", 08_KW双対性]
coverage_notes: 自己双対点は 1+√q。整数 q で ℚ̄。
review_notes: 自己双対「点」と転移点の一致は q≤4 で成立（別事実、ℝ 側）。
```

```yaml
cell_id: B.K3
model: Potts 三角/六角格子
direction: B
target_quantity: star-triangle 臨界条件（多項式方程式の根）
home: ℚ̄
complexity: poly〜#P
solvability: 部分的
decidable: yes（整係数多項式の根）
formal_verifiable: partial
status: known
known_anchors: [hep-lat/9801006, Onsager star-triangle]
coverage_notes: star-triangle で三角/六角の臨界条件が多項式 → 代数的臨界点。
review_notes:
```

```yaml
cell_id: B.K4
model: 一般の KW 自己双対系
direction: B
target_quantity: 双対対合の不動点
home: ℚ̄
complexity: —
solvability: —
decidable: yes
formal_verifiable: partial
status: known
known_anchors: [08_KW双対性_補足（ℤ[t]/Λ 表現, 自己双対 d=2p+2）]
coverage_notes: 08 が KW を可算（ℤ[t]）表現し「双対が買う＝代数的臨界点」を明示。一般枠は既出。
review_notes: 一般命題の厳密化が B.U1。
```

## Unknown cells（B の Λ-statement 候補源）

```yaml
cell_id: B.U1
model: 可積分格子模型一般
direction: B
target_quantity: 「ℤ係数の代数的双対対合をもつ模型の自己双対点は ℚ̄ で、QQbar 決定可能」分類命題
home: ℚ̄
complexity: —
solvability: —（位置のみ、転移存在は別）
decidable: yes
formal_verifiable: yes
status: unknown
known_anchors: [B.K1, B.K2, B.K4, 08]
missing_generalization: 個別例（Ising/Potts）は既知。「どの模型が代数的双対で臨界点を ℚ̄ に固定できるか」を分類し決定可能命題として述べる総合化が差分。
coverage_notes: 08 の一般論を「臨界点∈ℚ̄ の決定可能性」分類へ。
```

```yaml
cell_id: B.U2
model: 自己双対系（Ising/Potts/六頂点 等）
direction: B
target_quantity: 自己双対多項式 D(x)∈ℤ[x] の一意実根として臨界点を与え witness 提示
home: ℚ̄
complexity: poly
solvability: —
decidable: yes
formal_verifiable: yes（最小多項式 witness, QQbar）
status: unknown
known_anchors: [B.K1, 08（ℤ[t] 表現）]
missing_generalization: 臨界点を「自己双対多項式の根」として ℝ を一切使わず述べ、一意性・実根性を decide する形式は未整備。
coverage_notes: A.U1（零点 witness）の B 版。ℝ 不使用・完全決定可能。
```

```yaml
cell_id: B.U3
model: 双対で臨界点が固定されない可積分系
direction: B
target_quantity: 臨界点が代数的でない/双対で固定されない境界の同定
home: ℚ̄ または ℝ
complexity: —
solvability: —
decidable: 一部
formal_verifiable: 一部
status: unknown
known_anchors: [B.K1-K4 の反例側]
missing_generalization: B が効く範囲の境界（どの模型で臨界点が ℚ̄ を出て ℝ/超越になるか）を画定。梯子 calibration の臨界点版。
coverage_notes: B のスコープ確定。A.U4 と同類のメタ命題。
```

```yaml
cell_id: B.U4
model: Ising / Potts
direction: B
target_quantity: 自己双対点 = Fisher 零点集積点（A↔B 統合）
home: ℚ̄
complexity: poly
solvability: —
decidable: yes
formal_verifiable: partial
status: unknown
known_anchors: [B.K1, A.K4（自己双対 Ising zeros）]
missing_generalization: 「自己双対点（代数的）と Fisher 零点の集積点が代数的に一致する」ことを有限 N の ℚ̄ 命題＋極限の分離として述べる。
coverage_notes: A と B の結節。cond-mat/9805282（自己双対 Ising zeros）が足場。
```

## 観察（rank への申し送り, B 分）

- B も Λ 相性良：自己双対条件＝ℤ係数代数方程式 ⇒ 臨界点∈ℚ̄・決定可能・witness。08 が「双対が買う＝代数的臨界点」と既に明言しており、B の中核は確立済みで、差分は**総合化（B.U1 分類）と witness 形式化（B.U2）**。
- B.U2 は A.U1 と同型（「厳密 ℚ̄ 値を最小多項式 witness で述べ decide」）。A・B は **零点∈ℚ̄／臨界点∈ℚ̄** という共通の「代数的・決定可能・形式検証可能」型。B.U4 で A↔B が結節。
- B は単体で新規性が薄い恐れ（個別例は古典的、一般論は 08）。価値は A との統合（零点と臨界点を一つの ℚ̄ 決定可能命題群に）にありそう。次の C（構造保存）と合わせて観察する。
