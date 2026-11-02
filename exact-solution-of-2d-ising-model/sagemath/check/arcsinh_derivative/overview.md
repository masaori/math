# SageMath Check: arcsinh_derivative

## 対象

**対象ラベル**: `arcsinh_derivative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_arcsinh_derivative`（arcsinh'(y) = 1/√(y²+1)）
- 範囲: r' の鎖の三行、s' の鎖の四行、arcsinh' の鎖の六行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| r' の鎖（和と定数関数、積と恒等関数、四則） | `check_proof_lines.sage` | QQ[y] の微分と、関数体の微分で d(r) = 2y | **PASS** | 成り立つ |
| s' の鎖（合成、平方根、r' の代入、約分） | `check_proof_lines.sage` | 関数体 QQ(y)[s]/(s²-y²-1) の y についての微分で厳密に。微分は s² = y²+1 から決まる | **PASS** | 成り立つ |
| arcsinh' の鎖の 1・2 行目 合成と log'(w) = 1/w | `check_proof_lines.sage` | 微分の公式を当てはめた形 d(p)/p として置く（log' = 1/w は本文が持ち込む事実） | **PASS** | 成り立つ |
| arcsinh' の鎖の 3〜6 行目（p = id + s、s' の代入、通分、約分） | `check_proof_lines.sage` | 同じ関数体で厳密に。対照として外側の微分だけの 1/p は一致しない | **PASS** | 成り立つ |
| 主張そのもの | `check_proof_lines.sage` | SR の記号微分の値を 6 点で QQbar へ送り、1/√(y²+1) と厳密に比べる | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行は `QQ` 上の多項式環・有理関数体・剰余環、関数体 `QQ(y)[s]/(s²-y²-1)`、`AA`・`QQbar`、形式冪級数（全次数 14 以下）で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`）**: 不等号の行と主張の点での確認だけ。exp の値が `QQ` に収まらないためである。ボールは本文の exp の部分和に尾の評価を半径として足したもの（共通の準備 `sagemath/_shared/hyperbolic_by_definition.sage`）で、Arb の exp は使わない。arcsinh の値を囲むときだけ Arb の `log`・`sqrt` を使う（本文の log は exp の逆写像で、本文の exp は標準の exp に等しいため）。
- **構成上かならず一致する比較**: 定義を当てはめる行（例えば 1 行目の「cosh の定義」）は、左辺を定義の関数から、右辺を本文の式のまま作って比べており、定義の書き写しの誤りだけを検出する。

範囲外のもの:

- 選んだ以外の点と、全次数 14 を超える項。微分の公式・(R3)・(R4) そのもの（本文が外部から持ち込む実数解析の事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh arcsinh_derivative
```

実行ログは `logs/` に保存する。
