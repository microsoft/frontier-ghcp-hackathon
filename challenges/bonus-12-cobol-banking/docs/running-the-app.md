# Running the COBOL Banking Application

Running the COBOL code is **optional** for this challenge -- you can read and work with the `.cbl` files without compiling. But if you want to see the system in action, here is how.

## Prerequisites

You need **GnuCOBOL** installed. On Debian/Ubuntu:

```bash
sudo apt-get update
sudo apt-get install -y gnucobol
```

On macOS with Homebrew:

```bash
brew install gnucobol
```

Verify the install:

```bash
cobc --version
```

You should see `cobc (GnuCOBOL)` followed by a version number. Version 3.1.2 or later is recommended.

## Compiling the Programs

All commands run from the `challenges/bonus-12-cobol-banking/` directory.

### Step 1: Compile and run the initializer

```bash
cobc -x -free programs/BNKINIT.cbl
./BNKINIT
```

This creates ISAM data files in `data/` and loads seed data (customers, accounts, transactions, loans, users, and system configuration). It **clears all existing data** and creates fresh records, so only run it when you want a clean slate.

### Step 2: Compile the main application

`BNKMAIN` calls 10 other modules at runtime. All modules must be compiled together so the linker can resolve them:

```bash
cobc -x -free programs/BNKMAIN.cbl \
    programs/BNKAUTH.cbl programs/BNKCUST.cbl \
    programs/BNKACCT.cbl programs/BNKTXN.cbl \
    programs/BNKLOAN.cbl programs/BNKINTR.cbl \
    programs/BNKBATCH.cbl programs/BNKRPT.cbl \
    programs/BNKAUDT.cbl programs/BNKUTIL.cbl
```

The `-x` flag produces an executable. The `-free` flag enables free-format source (no fixed columns). Copybook paths in the source use relative paths (`copybooks/*.cpy`), so no `-I` flag is needed as long as you compile from the challenge root directory.

If you only run `cobc -x -free programs/BNKMAIN.cbl` without the other modules, you will get `module 'BNKAUTH' not found` at runtime.

### Step 3: Run the application

```bash
./BNKMAIN
```

This launches the main menu. Log in with one of the default accounts:

| User | Password | Role |
|------|----------|------|
| `admin` | `admin123` | ADMIN -- full access including batch processing and user management |
| `teller1` | `teller123` | TELLER -- can process transactions |
| `teller2` | `teller123` | TELLER -- can process transactions |
| `auditor1` | `audit123` | AUDITOR -- read-only access to reports and audit logs |

## Quick Walkthrough

After logging in as `admin`, try these operations to get oriented:

1. **View customers** -- Select option 1 (Customer Management), then search or view by ID.
2. **Check an account balance** -- Option 2 (Account Management), then balance inquiry.
3. **Make a deposit** -- Log in as `teller1`, option 3 (Transactions), then deposit.
4. **Run end-of-day batch** -- Log in as `admin`, option 6. This calculates interest, checks loans, and charges fees.
5. **View reports** -- Option 5 for statements and portfolio summaries.

## Stopping the Application

Type `Q` at the main menu to log out and exit.

## Troubleshooting

**"cobc: command not found"** -- GnuCOBOL is not installed. See Prerequisites above.

**Compilation errors about copybooks** -- Make sure you are running the compile command from the `challenges/bonus-12-cobol-banking/` directory so the relative `copybooks/` paths resolve correctly.

**"file not found" at runtime** -- The `data/` directory must exist. Run `mkdir -p data` if it is missing, then run `./BNKINIT` to create the ISAM files.

**"module 'BNKAUTH' not found"** -- You compiled BNKMAIN without linking the other modules. See Step 2 above for the full compile command.

**"BNKINIT already loaded" or stale data** -- Run `./BNKINIT` again to reset everything. This is destructive -- it wipes all data files and reloads seed data.

**Garbled terminal output** -- Some terminals handle the DISPLAY output differently. Make sure your terminal supports standard COBOL console I/O. If columns look off, widen your terminal to at least 120 characters.
