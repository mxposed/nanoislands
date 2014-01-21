describe("Input Tests", function() {

    beforeEach(function() {
        var result = yr.run('main', {input: true});
        $('.content').html(result);

        nb.init();
        this.input = nb.find('input');
    });

    afterEach(function() {
        delete this.input;
    });

    describe("Init", function() {
        it("should be inited", function() {
            expect(this.input).to.not.equal(null);
        });
    });

    describe('#getType()', function() {
        it('should return input type', function() {
            expect(this.input.getType()).to.be.equal('input');
        });
    });

    describe("#focus()", function() {
        it("should throws nb-input_focused event", function() {
            var handlerWorks = false;
            this.input.on('nb-focused', function() {
                handlerWorks = true;
            });

            this.input.focus();

            expect(handlerWorks).to.be.ok();
        });

        it("should throws global nb-input_focusout event", function() {
            var handlerWorks = false;
            nb.on('nb-input_focusout', function() {
                handlerWorks = true;
            });
            this.input.focus();

            expect(handlerWorks).to.be.ok();
        });

        it("should be in focus", function() {
            this.input.focus();
            expect(this.input.focused).to.be.ok();
        });
    });

    describe("#blur()", function() {
        it("should not to be in focus", function() {
            this.input.blur();
            expect(this.input.focused).not.to.be.ok();
        });

        it("should throws blur event", function() {
            var handlerWorks = false;
            this.input.on('nb-blured', function() {
                handlerWorks = true;
            });
            this.input.blur();

            expect(handlerWorks).to.be.ok();
        });
    });

    describe("#disable()", function() {
        it("should be disabled", function() {
            this.input.disable();

            expect(this.input.$control.prop('disabled')).to.be.ok();
        });
    });

    describe("#enable()", function() {
        it("should be enabled", function() {
            this.input.enable();

            expect(this.input.$control.prop('disabled')).not.to.be.ok();
        });
    });

    describe("#isEnabled()", function() {
        it("should return true when enabled", function() {
            expect(this.input.isEnabled()).to.be.ok();
        });

        it("should return false when disabled", function() {
            this.input.disable();
            expect(this.input.isEnabled()).not.to.be.ok();
        });
    });

    describe("#setValue()", function() {
        it("should change the value", function() {
            this.input.setValue('Vadim');

            expect(this.input.$control.val()).to.be.equal('Vadim');
        });

        it("should throws nb-value-set event", function() {
            var handlerWorks = false;
            this.input.on('nb-value-set', function() {
                handlerWorks = true;
            });
            this.input.setValue('Vadim');

            expect(handlerWorks).to.be.ok();
        });
    });

    describe("#setName()", function() {
        it("should change the value", function() {
            this.input.setName('Vadim');

            expect(this.input.$control.attr('name')).to.be.equal('Vadim');
        });

        it("should throws nb-name-set event", function() {
            var handlerWorks = false;
            this.input.on('nb-name-set', function() {
                handlerWorks = true;
            });
            this.input.setName('Vadim');

            expect(handlerWorks).to.be.ok();
        });
    });

    describe("#getValue()", function() {
        it("should return the value", function() {
            expect(this.input.getValue()).to.be.equal('Viktor');
        });
    });

    describe("#getName()", function() {
        it("should return the name", function() {
            expect(this.input.getName()).to.be.equal('last-name');
        });
    });

    describe('#destroy()', function() {
        it("should destroy nb.block", function() {
            this.input.destroy();
            expect(nb.hasBlock($('#input')[0])).to.be.equal(false);
        });
    })
});