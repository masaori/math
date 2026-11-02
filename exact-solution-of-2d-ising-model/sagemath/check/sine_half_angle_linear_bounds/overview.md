# SageMath Check: sine_half_angle_linear_bounds

## 対象

**対象ラベル**: `sine_half_angle_linear_bounds` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_sine_half_angle_linear_bounds`（θ ∈ [0, π] なら c₀θ/2 ≤ sin(θ/2) ≤ θ/2）
- 範囲: 準備の鎖・上の鎖・下の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 等号の行（準備の 1・4 行目、上の 1 行目、下の 1・3・5・6 行目）。端点で等号になる不等号の行（θ = 0, π） | `check_proof_lines.sage` | QQ[θ, s, π] の多項式の等式で厳密に。端点では q/2 ∈ {0, 1/2} を QQ で確かめ、両辺が π の不定元の多項式として一致することを見る | **PASS** | 成り立つ |
| 不等号の行（準備の 2・3 行目と続きの二行、上の 2 行目、下の 2・4 行目）と主張 | `check_proof_lines.sage` | [0, π] の 12 等分点 θ = qπ で sin(θ/2) を AA、θ と π をボールで、狭義の不等号が確定することを確かめる | **PASS** | 成り立つ |
| 対照 | `check_proof_lines.sage` | 逆向きの狭義の不等号がボールで確定する: c₀ の代わりに 0.65（> 2/π）を置くと θ = π で下側が成り立たない | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: sin・cos の値は、角度を π の有理数倍に限り、1 の冪根の虚部と、本文の定義 cos θ := √(1 - (sin θ)²) から `AA` で作る（共通の準備 `sagemath/_shared/sine_cosine_by_definition.sage`）。等号の行は `QQ` 上の多項式環・`AA` で確かめた。
- **`ℝ` への脱出（`RealBallField(256)`）**: 角度 `qπ` と π を含む量の大小だけ。π が `QQ`・`AA` に入らないためである。Arb の `pi()` は π を厳密に含む区間で、判定は差のボールの下端の符号で行い、許容誤差は置かない。

範囲外のもの:

- 選んだ以外の θ。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sine_half_angle_linear_bounds
```

実行ログは `logs/` に保存する。
