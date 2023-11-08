

all: main.x86 main.riscv

main.x86: main.go
	go build -o $@ $^

main.riscv: main.go
	GOOS=linux GOARCH=riscv64 go build -o $@ $^
	mv $@ go-gc/overlay/root

.PHONY: clean
clean:
	rm -f main.x86 main.riscv
