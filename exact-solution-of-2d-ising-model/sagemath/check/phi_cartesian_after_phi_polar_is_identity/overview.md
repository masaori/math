# SageMath Check: phi_cartesian_after_phi_polar_is_identity

## 対象

**対象ラベル**: `phi_cartesian_after_phi_polar_is_identity` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_phi_cartesian_after_phi_polar_is_identity`（φ_cartesian ∘ φ_polar は ℂ の恒等写像）
- 範囲: 主張と、証明の場合分けの六つの場合の鎖のすべての行

## 証明の行との対応

`S := √(x²+y²)`、`t := y/x`、`U := √(1+t²)`、`α := arctan(t)`、`X := √(x²)`、`X' := √((-x)²)`、`W := √(x²(1+t²))` と書く。
行の番号は `check_case_chains.sage` の冒頭の対応表と同じである。本文は各場合の最初の行を「写像の合成の定義」と「`φ_polar` の定義の場合」の二行に分けているが、検算は二つをまとめて「行 0 → 1」と数えるので、検算の行 k（k ≥ 1）は本文の行 k+1 に当たる。

| 証明の行 | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `x > 0` の行 0 → 1 → 2（写像の合成の定義・`def_phi_polar`・`def_phi_cartesian`） | 定義の適用であり、定義を写したものとの一致しか確かめない。具体の点で、`φ_polar(x,y) = [(S, α)]` を `phi_polar_equals` で判定し、`φ_cart` を 1 の冪根から計算して `(S cos α, S sin α)` と比べる | **PASS** | 6 点 |
| `x > 0` の行 2 → 3（`cos_arctan_sin_arctan`） | 具体の点で、`α` を `[-π/2,π/2]` の中で `sin α = t/U` を満たす `qπ` として探し、1 の冪根から作った `cos α, sin α` が `1/U, t/U` に一致すること。`sin α = t/U` は `α` の選び方から構成上一致するので、独立に確かめているのは `cos α = 1/U` である | **PASS** | 6 点 |
| `x > 0` の行 3 → 8 | 一般の点で、平方根を不定元とした有理関数体で、各行で根拠に挙げた関係（`x = X`、`W = XU`、`W = S`）だけを代入して比べる。`x²(1+t²) = x²+y²` も有理関数として。具体の点で、各行を `AA` で別々に計算して隣どうしを比べ、`x = X`、`XU = W`、`W = S`、`S ≠ 0` を確かめる | **PASS** | 一般の点と 8 点 |
| `x < 0` の二つの鎖の本文の四行（検算の三行。`y ≥ 0` で `α+π`、`y < 0` で `α-π`） | 具体の点で、`φ_cart([(S, α±π)])` を 1 の冪根から計算し、`cos(α±π) = -cos α`、`sin(α±π) = -sin α` と、共通の式 `(-S cos α, -S sin α)` に着くこと | **PASS** | 5 点 |
| `x < 0` の共通の鎖の行 c0 → c8 | 行 c0 → c1 は上と同じく 1 の冪根で（独立に確かめているのは cos の成分）。行 c1 → c8 は一般の点で関係（`x = -X'`、`X' = X`、`W = XU`、`W = S`）だけを代入して、具体の点で `AA` で隣どうしを比べる | **PASS** | 一般の点と 7 点 |
| `x = 0, y > 0`、`x = 0, y < 0`、`x = y = 0` の鎖 | 具体の点で一行ずつ。最初の行は `phi_polar_equals` で定義の場合と比べる。`cos(±π/2)`、`sin(±π/2)`、`cos 0`、`sin 0` は 1 の冪根から | **PASS** | 7 点 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。準備は `sagemath/_shared/polar_trigonometry_exact.sage`。

- **一般の点**: `x, y` と平方根 `S, U, X, X', W` を `QQ` 上の不定元とする有理関数体。平方根どうしの関係は、各行の根拠に挙げたものだけを代入する。
- **具体の点**: `(x, y)` を `AA × AA` で直接与える。`α` が `π` の有理数倍になる 11 点（`(1,0)`、`(1,1)`、`(√3,1)`、`(1,-√3)`、`(5√3,-5)`、
  `((√6+√2)/4, (√6-√2)/4)`、`(-2,0)`、`(-√3,1)`、`(-2,2√3)`、`(-1,-1)`、`(-7/2,-7√3/2)`）では鎖の全行を、
  ならない 4 点（`(2,1)`、`(3,-7)`、`(-2,1)`、`(-3,-1)`）では代数の行（行 3 以降と c1 以降）だけを確かめる。
- `α = arctan(t)` の判定: `def_arctan` により `arctan(t) = arcsin(t/U)`、`arcsin` は `[-1,1] → [-π/2,π/2]` の全単射で `sin` はその逆写像
  （`arcsin_is_bijection`・`def_sin`）だから、`[-π/2,π/2]` の `qπ` で `sin(qπ) = t/U` なら `α = qπ`。

確かめられない点と理由:

- 本文の `def_sin`・`def_cos` は `[-π/2, π/2]` でしか定めておらず、`def_phi_cartesian` は未完と書いている。`x < 0` の場合の
  `cos(α±π)`・`sin(α±π)` はその外の値であり、検算は通常の cos・sin の値（1 の冪根）で確かめている。本文が未整備の拡張を先取りしている。
- `α` が `π` の有理数倍にならない点では、`cos α`・`sin α` を厳密に作れないので、行 1 → 3 と `x < 0` の三行は確かめていない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh phi_cartesian_after_phi_polar_is_identity
```

実行ログは `sagemath/check/phi_cartesian_after_phi_polar_is_identity/logs/` に保存する。
