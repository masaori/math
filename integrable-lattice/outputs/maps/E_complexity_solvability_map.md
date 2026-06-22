# Λ gap-map — 方向 E: 複雑性 × 可解性の分類（cycle 0, 広く浅く）

定義 `inputs/seeds/lambda-statement-program.md`、土台 `docs/discussion/対数順序群上の統計力学/07_Λ帰属と可解性は別.md`。

## 中核の観察（E の Λ 構造）

07 の四軸のうち、模型を区別するのは **3 複雑性（有限 N が poly か #P 困難か）** と **4 可解性（極限に閉形式があるか）**、この二つが独立。E は各模型・境界をこの 2×2 テーブルに**配置する分類命題**そのものを集める。帰属（1）は有限・離散なら○、計算可能性（2）は常に○（自明）。

E の statement は「この模型・境界は (poly/#P) × (closed/none) のどのセルか」。複雑性は**有限の計算問題の決定問題**（Istrail 2000 の #P 困難性等は厳密命題）、可解性は極限の閉形式の有無（Onsager 在／3D 無）。

| | 極限に閉形式 **あり** | 極限に閉形式 **なし** |
|---|---|---|
| **有限が poly** | 2D Ising（Pfaffian/Onsager） | 1D ランダム鎖（Lyapunov） |
| **有限が #P 困難** | SK（Parisi 変分形式）, REM | 3D Ising（Istrail 2000）, 3D EA スピングラス |

## cell key / Summary

`model × E × (complexity, solvability) × decidable(分類が決定問題か) × status`

| cell | model | (complexity, solvability) | status |
|---|---|---|---|
| E.K1 | 2D Ising | (poly, closed) | known |
| E.K2 | SK スピングラス | (#P, closed=変分/Parisi) | known |
| E.K3 | 3D Ising | (#P, none) | known(Istrail 2000) |
| E.K4 | 1D ランダム鎖 | (poly, none=Lyapunov) | known |
| E.K5 | — | (#P, 初等閉形式) は経験的に空 | known(観察, 07§3) |
| E.U1 | 可積分各種 | テーブルへの配置分類（六頂点/RSOS/dimer/Potts × 境界） | unknown |
| E.U2 | — | 「#P × 初等閉形式」両取りの不在の構造的理由 or 反例 | unknown |
| E.U3 | 模型×境界 | どの境界が poly→#P を反転させるかの決定 | unknown |

## Known cells

```yaml
cell_id: E.K1
model: 2D Ising 正方（無磁場・平面）
direction: E
complexity: poly（Pfaffian）
solvability: closed（Onsager）
decidable: yes（平面=Pfaffian の多項式性は定理）
status: known
known_anchors: [07§2 テーブル, 09]
coverage_notes: 両方楽。自由フェルミ/平面性が複雑性と可解性を同時に下げる典型。
review_notes:
```

```yaml
cell_id: E.K2
model: SK スピングラス（平均場）
direction: E
complexity: "#P 困難（分配関数）, NP 困難（基底状態）"
solvability: closed（変分形式 = Parisi 公式）
decidable: 複雑性は定理（Barahona 1982 ほか）
status: known
known_anchors: [07§2,4, Parisi]
coverage_notes: 有限が難でも極限は変分形式で確定。複雑性×可解性の独立の核例。
review_notes: 閉形式の粒度は「初等」でなく「変分」（07§3）。
```

```yaml
cell_id: E.K3
model: 3D Ising
direction: E
complexity: "#P 困難（Istrail 2000）"
solvability: none（閉形式は未解決の有名問題）
decidable: 複雑性は定理
status: known
known_anchors: [07§2, Istrail 2000]
coverage_notes: 有限 #P 困難・極限閉形式なし。
review_notes:
```

```yaml
cell_id: E.K4
model: 1D ランダム鎖
direction: E
complexity: poly（転送行列の積）
solvability: none（ランダム行列積の Lyapunov 指数で一般に閉形式なし）
decidable: yes
status: known
known_anchors: [07§2]
coverage_notes: 有限が安くても極限に式がない反対側の例。
review_notes:
```

```yaml
cell_id: E.K5
model: （クロスセル観察）
direction: E
complexity: "#P 困難"
solvability: 初等閉形式
decidable: —
status: known（観察。両取りの綺麗な例は知られていない, 07§3）
known_anchors: [07§3]
coverage_notes: 初等閉形式を生む構造（自由フェルミ・平面・対称性）は有限も同時に楽にする傾向。論理的独立だが現実に相関。
review_notes: E.U2 へ。
```

## Unknown cells（E の Λ-statement 候補源）

```yaml
cell_id: E.U1
model: 可積分各種（六頂点/RSOS/dimer/Potts × 各境界）
direction: E
target_quantity: 07 テーブルへの配置
complexity: model 依存
solvability: model 依存
decidable: 複雑性は決定問題、可解性は文献事実
status: unknown
known_anchors: [E.K1-K4]
missing_generalization: 可積分模型・境界を複雑性×可解性テーブルへ網羅的に配置する分類命題。各セルの populated/empty を明示。
coverage_notes: 分類そのものを成果に。A/B/C/D の候補がどのセルに落ちるかも整理。
```

```yaml
cell_id: E.U2
model: （メタ）
direction: E
target_quantity: 「#P × 初等閉形式」両取りの不在の構造的理由 or 反例
complexity: "#P"
solvability: 初等閉形式
decidable: —
status: unknown
known_anchors: [E.K5, 07§3]
missing_generalization: 経験的空セル（07§3）を、構造定理（初等閉形式 ⇒ 有限も poly？）として述べるか、反例を探す。
coverage_notes: 複雑性と可解性の相関の根拠。深いが射程大。
```

```yaml
cell_id: E.U3
model: 模型 × 境界
direction: E
target_quantity: どの境界が poly→#P を反転させるか
complexity: poly↔#P
solvability: —
decidable: 複雑性は決定問題
status: unknown
known_anchors: [E.K1（平面 Ising poly）, 非平面で #P]
missing_generalization: 境界・幾何（平面性の破れ・磁場）が複雑性クラスを変える境目を、模型横断で同定。
coverage_notes: C（構造保存）の複雑性版。境界が構造を壊す閾値。
```

## 観察（rank への申し送り, E 分）

- E は **分類・メタ命題**が中心で、A-D のような「個別の ℚ̄/Λ 値命題」とは性格が違う。価値は A-D の候補を 07 テーブルに位置づけ、**「どの方向の statement が (poly,closed) の楽なセル＝可算で完全に閉じる」かを俯瞰**する点。
- A/B/C/D の核（有限 N が ℚ̄/Λ で決定可能）は主に **(poly, closed) セル＝2D Ising 型**に対応。E.U2（#P×初等閉形式の不在）は Λ プログラムの射程の上限を示す（#P 側は有限でも安く解けない＝可算でも計算困難）。
- E は単体の新規性より、cycle 1 で A-D を束ねる際の**整理枠**として効く。
