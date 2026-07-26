#!/usr/bin/env node
/**
 * 互換入口。実体は `validate-content.ts`（Node 22.18+ の型ストリップでそのまま動く）。
 * リポジトリの CLAUDE.md が `node structured-latex/tools/validate-content.mjs` を
 * 検証コマンドとして案内しているため、その呼び出しを壊さないために残す。
 */
import "./validate-content.ts";
