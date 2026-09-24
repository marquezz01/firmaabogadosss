document.addEventListener('DOMContentLoaded', () => {
    
    // 1. Set Current Year dynamically in Footer
    const yearSpan = document.getElementById('current-year');
    if (yearSpan) {
        yearSpan.textContent = new Date().getFullYear();
    }

    // 2. Glassmorphism Header Scroll Effect
    const header = document.getElementById('main-header');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            header.style.padding = '5px 0';
            header.style.background = 'rgba(255, 255, 255, 0.95)';
            header.style.boxShadow = '0 10px 30px rgba(0,0,0,0.08)';
        } else {
            header.style.padding = '0';
            header.style.background = 'rgba(255, 255, 255, 0.85)';
            header.style.boxShadow = '0 4px 30px rgba(0, 0, 0, 0.05)';
        }
    });

    // 3. Mobile Menu Toggle
    const mobileBtn = document.querySelector('.mobile-menu-btn');
    const mainNav = document.querySelector('.main-nav');

    const setMenuOpen = (isOpen) => {
        document.body.classList.toggle('nav-open', isOpen);
        if (mobileBtn) {
            mobileBtn.setAttribute('aria-expanded', String(isOpen));
            mobileBtn.setAttribute('aria-label', isOpen ? 'Cerrar menú' : 'Abrir menú');
            const icon = mobileBtn.querySelector('i');
            if (icon) {
                icon.className = isOpen ? 'fas fa-times' : 'fas fa-bars';
            }
        }
    };

    if (mobileBtn) {
        mobileBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            setMenuOpen(!document.body.classList.contains('nav-open'));
        });
    }

    // Close mobile menu when clicking outside
    document.addEventListener('click', (e) => {
        if (!document.body.classList.contains('nav-open')) return;
        if (mainNav && !mainNav.contains(e.target) && mobileBtn && !mobileBtn.contains(e.target)) {
            setMenuOpen(false);
        }
    });

    // Close mobile menu when clicking any nav link
    document.querySelectorAll('.nav-list a').forEach(link => {
        link.addEventListener('click', () => {
            if (window.innerWidth <= 768) {
                setMenuOpen(false);
            }
        });
    });

    // Close on Escape key
    document.addEventListener('keydown', (event) => {
        if (event.key === 'Escape' && document.body.classList.contains('nav-open')) {
            setMenuOpen(false);
            mobileBtn?.focus();
        }
    });

    // Reset when resizing to desktop
    window.addEventListener('resize', () => {
        if (window.innerWidth > 768 && document.body.classList.contains('nav-open')) {
            setMenuOpen(false);
        }
    });

    // 4. Animated Counters (Intersection Observer)
    const counters = document.querySelectorAll('.counter');
    const animationSpeed = 250; // The higher, the slower it animates

    const animateCounters = (entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const counterElement = entry.target;
                const targetValue = +counterElement.getAttribute('data-target');
                
                const updateCount = () => {
                    const currentCount = +counterElement.innerText.replace('+', '').replace(/\./g, '');
                    const increment = targetValue / animationSpeed;

                    if (currentCount < targetValue) {
                        counterElement.innerText = '+' + Math.ceil(currentCount + increment).toLocaleString('es-ES');
                        setTimeout(updateCount, 15);
                    } else {
                        counterElement.innerText = '+' + targetValue.toLocaleString('es-ES');
                    }
                };

                updateCount();
                // Stop observing once animated
                observer.unobserve(counterElement);
            }
        });
    };

    const counterObserver = new IntersectionObserver(animateCounters, {
        threshold: 0.6 // Trigger when 60% of the element is visible
    });

    counters.forEach(counter => {
        counterObserver.observe(counter);
    });

    // 5. Smooth Scrolling for Anchor Links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const targetId = this.getAttribute('href');
            
            // Ignore if it's just a dummy link
            if(targetId !== '#' && targetId.startsWith('#')) {
                e.preventDefault();
                const targetElement = document.querySelector(targetId);
                
                if(targetElement) {
                    const headerHeight = document.querySelector('header').offsetHeight;
                    // Calculate exact position minus the sticky header
                    const targetPosition = targetElement.getBoundingClientRect().top + window.pageYOffset - headerHeight;
                    
                    window.scrollTo({
                        top: targetPosition,
                        behavior: 'smooth'
                    });
                }
            }
        });
    });
    
    // 6. Video Placeholder Interaction
    const videoBtn = document.querySelector('.video-placeholder');
    if(videoBtn) {
        videoBtn.addEventListener('click', () => {
           alert('Aquí se cargaría el iframe o reproductor de video HTML5 real (ej. YouTube, Vimeo o MP4).'); 
        });
    }

    // 7. Contact form validation and states
    const contactForm = document.getElementById('contact-form');
    if (contactForm) {
        const statusEl = contactForm.querySelector('.form-status');
        const submitBtn = document.getElementById('contact-submit');
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const phonePattern = /^[\d\s()+-]{7,20}$/;

        const fields = {
            name: document.getElementById('contact-name'),
            email: document.getElementById('contact-email'),
            phone: document.getElementById('contact-phone'),
            topic: document.getElementById('contact-topic'),
            message: document.getElementById('contact-message'),
            consent: document.getElementById('contact-consent')
        };

        const setFieldError = (field, messageId, isInvalid) => {
            const group = field.closest('.form-group') || field;
            const errorEl = document.getElementById(messageId);
            field.classList.toggle('is-invalid', isInvalid);
            if (group && group.classList) {
                group.classList.toggle('is-invalid', isInvalid);
            }
            if (errorEl) {
                errorEl.style.display = isInvalid ? 'block' : '';
            }
            field.setAttribute('aria-invalid', String(isInvalid));
            if (isInvalid) {
                field.setAttribute('aria-describedby', messageId);
            } else {
                field.removeAttribute('aria-describedby');
            }
        };

        const validators = {
            name: () => fields.name.value.trim().length >= 2,
            email: () => emailPattern.test(fields.email.value.trim()),
            phone: () => !fields.phone.value.trim() || phonePattern.test(fields.phone.value.trim()),
            topic: () => Boolean(fields.topic.value),
            message: () => fields.message.value.trim().length >= 20,
            consent: () => fields.consent.checked
        };

        const errorIds = {
            name: 'contact-name-error',
            email: 'contact-email-error',
            phone: 'contact-phone-error',
            topic: 'contact-topic-error',
            message: 'contact-message-error',
            consent: 'contact-consent-error'
        };

        const validateField = (key) => {
            const isValid = validators[key]();
            setFieldError(fields[key], errorIds[key], !isValid);
            return isValid;
        };

        const showStatus = (type, message) => {
            statusEl.className = `form-status is-visible is-${type}`;
            statusEl.innerHTML = `<i class="fas ${type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}" aria-hidden="true"></i><span>${message}</span>`;
        };

        Object.keys(fields).forEach((key) => {
            const eventName = key === 'consent' || key === 'topic' ? 'change' : 'blur';
            fields[key].addEventListener(eventName, () => validateField(key));
        });

        contactForm.addEventListener('submit', (event) => {
            event.preventDefault();
            const invalidKey = Object.keys(validators).find((key) => !validateField(key));

            if (invalidKey) {
                showStatus('error', 'Revisa los campos marcados e inténtalo de nuevo.');
                fields[invalidKey].focus();
                return;
            }

            submitBtn.disabled = true;
            submitBtn.classList.add('is-loading');
            submitBtn.querySelector('.btn-label').textContent = 'Enviando...';
            submitBtn.setAttribute('aria-busy', 'true');

            window.setTimeout(() => {
                submitBtn.disabled = false;
                submitBtn.classList.remove('is-loading');
                submitBtn.querySelector('.btn-label').textContent = 'Enviar mensaje';
                submitBtn.removeAttribute('aria-busy');
                contactForm.reset();
                Object.keys(fields).forEach((key) => setFieldError(fields[key], errorIds[key], false));
                showStatus('success', 'Mensaje enviado. Te contactaremos en un día hábil.');
                statusEl.focus?.();
            }, 700);
        });
    }
});
